import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/test_reports_bloc.dart';
import 'package:psp_developer/src/models/test_reports_model.dart';
import 'package:psp_developer/src/pages/test_reports/test_report_edit_page.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/providers/models/fab_model.dart';
import 'package:psp_developer/src/utils/searchs/search_test_reports.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:psp_developer/src/widgets/buttons_widget.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';
import 'package:psp_developer/src/widgets/drawer_program_items.dart';
import 'package:psp_developer/src/widgets/not_autorized_screen.dart';
import 'package:tuple/tuple.dart';

class TestReportsPage extends StatefulWidget {
  final int programId;

  TestReportsPage({this.programId});

  @override
  _TestReportsPageState createState() => _TestReportsPageState();
}

class _TestReportsPageState extends State<TestReportsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _fabController = ScrollController();
  double _lastScroll = 0;

  TestReportsBloc _testReportsBloc;

  @override
  void initState() {
    _lastScroll = 0;

    _fabController.addListener(() {
      if (_fabController.offset > _lastScroll && _fabController.offset > 150) {
        Provider.of<FabModel>(context, listen: false).isShowing = false;
      } else {
        Provider.of<FabModel>(context, listen: false).isShowing = true;
      }

      _lastScroll = _fabController.offset;
    });
    super.initState();

    _testReportsBloc = context.read<BlocProvider>().testReportsBloc;
    _testReportsBloc.getTestReports(false, widget.programId);
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isValidToken()) return NotAutorizedScreen();
    final isShowing = Provider.of<FabModel>(context).isShowing;

    return ChangeNotifierProvider(
      create: (_) => FabModel(),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerProgramItems(programId: widget.programId),
        appBar: CustomAppBar(
          title: S.of(context).appBarTitleTestReports,
          searchDelegate: SearchTestReports(_testReportsBloc, widget.programId),
        ),
        floatingActionButton: FAB(
          isShowing: isShowing,
          onPressed: () => navigateToEditPage(null),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _body(_testReportsBloc, widget.programId),
      ),
    );
  }

  Widget _body(TestReportsBloc testReportsBloc, int programId) {
    return StreamBuilder(
      stream: testReportsBloc.testReportsStream,
      builder: (BuildContext context,
          AsyncSnapshot<Tuple2<int, List<TestReportModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final testReports = snapshot.data.item2 ?? [];

        final statusCode = snapshot.data.item1;

        if (statusCode != 200) {
          showSnackBar(context, _scaffoldKey.currentState, statusCode);
        }

        if (testReports.isEmpty) {
          return RefreshIndicator(
            onRefresh: () =>
                _refreshTestReports(context, testReportsBloc, programId),
            child: ListView(
              children: [
                Center(child: Text(S.of(context).thereIsNoInformation)),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () =>
              _refreshTestReports(context, testReportsBloc, programId),
          child: _buildListView(testReports),
        );
      },
    );
  }

  ListView _buildListView(List<TestReportModel> testReports) {
    return ListView.separated(
        itemCount: testReports.length,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, i) => _buildItemList(testReports, i, context),
        separatorBuilder: (BuildContext context, int index) => Divider(
              thickness: 1.0,
            ));
  }

  Widget _buildItemList(
      List<TestReportModel> testReports, int i, BuildContext context) {
    return CustomListTile(
      title: testReports[i].testName,
      trailing:
          Text('${S.of(context).labelNumber} ${testReports[i].testNumber}'),
      onTap: () => navigateToEditPage(testReports[i]),
      subtitle: testReports[i].objective,
    );
  }

  void navigateToEditPage(TestReportModel testReport) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => TestReportEditPage(
            programId: widget.programId,
            testReport: testReport,
          ),
        ));
  }

  Future<void> _refreshTestReports(BuildContext context,
      TestReportsBloc testReportsBloc, int programId) async {
    await testReportsBloc.getTestReports(true, programId);
  }
}
