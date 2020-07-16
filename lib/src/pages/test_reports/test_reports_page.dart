import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/test_reports_bloc.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/providers/models/fab_model.dart';
import 'package:psp_developer/src/searches/mixins/test_reports_page_and_search_mixing.dart';
import 'package:psp_developer/src/searches/search_test_reports.dart';
import 'package:psp_developer/src/shared_preferences/shared_preferences.dart';
import 'package:psp_developer/src/utils/token_handler.dart';
import 'package:psp_developer/src/widgets/buttons_widget.dart';
import 'package:psp_developer/src/widgets/common_list_of_models.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/drawer_program_items.dart';
import 'package:psp_developer/src/widgets/not_authorized_screen.dart';

class TestReportsPage extends StatefulWidget {
  static const ROUTE_NAME = 'test-reports';

  @override
  _TestReportsPageState createState() => _TestReportsPageState();
}

class _TestReportsPageState extends State<TestReportsPage>
    with TestReportsPageAndSearchMixing {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TestReportsBloc _testReportsBloc;
  int _programId;

  @override
  void initState() {
    _testReportsBloc = context.read<BlocProvider>().testReportsBloc;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _programId = ModalRoute.of(context).settings.arguments;
    if (_testReportsBloc.lastValueTestReportsController == null) {
      _testReportsBloc.getTestReports(false, _programId);
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _testReportsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!TokenHandler.existToken()) return NotAuthorizedScreen();

    var isShowing = Provider.of<FabModel>(context).isShowing;

    if (Preferences().pendingInterruptionStartAt != null) {
      isShowing = false;
    }

    return ChangeNotifierProvider(
      create: (_) => FabModel(),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerProgramItems(programId: _programId),
        appBar: CustomAppBar(
          title: S.of(context).appBarTitleTestReports,
          searchDelegate: SearchTestReports(_testReportsBloc, _programId),
        ),
        floatingActionButton: FAB(
          isShowing: isShowing,
          onPressed: () => navigateToEditPage(context, null, _programId),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _body(),
      ),
    );
  }

  Widget _body() => CommonListOfModels(
        stream: _testReportsBloc.testReportsStream,
        onRefresh: _onRefreshTestReports,
        scaffoldKey: _scaffoldKey,
        buildItemList: (items, index) => buildItemList(context, items[index]),
      );

  Future<void> _onRefreshTestReports() async =>
      await _testReportsBloc.getTestReports(true, _programId);
}
