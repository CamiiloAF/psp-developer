import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/defect_logs_bloc.dart';
import 'package:psp_developer/src/models/defect_logs_model.dart';
import 'package:psp_developer/src/pages/defect_logs/defect_log_edit_page.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/providers/models/fab_model.dart';
import 'package:psp_developer/src/utils/searchs/search_defect_logs.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:psp_developer/src/widgets/buttons_widget.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';
import 'package:psp_developer/src/widgets/drawer_program_items.dart';
import 'package:psp_developer/src/widgets/not_autorized_screen.dart';
import 'package:tuple/tuple.dart';

class DefectLogsPage extends StatefulWidget {
  final int programId;

  DefectLogsPage({this.programId});

  @override
  _DefectLogsPageState createState() => _DefectLogsPageState();
}

class _DefectLogsPageState extends State<DefectLogsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController _fabController = ScrollController();
  double _lastScroll = 0;

  DefectLogsBloc _defectLogsBloc;

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

    _defectLogsBloc = context.read<BlocProvider>().defectLogsBloc;
    _defectLogsBloc.getDefectLogs(false, widget.programId);
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
          title: S.of(context).appBarTitleDefectLogs,
          searchDelegate: SearchDefectLogs(_defectLogsBloc, widget.programId),
        ),
        floatingActionButton: FAB(
          isShowing: isShowing,
          onPressed: () => navigateToEditPage(null),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _body(_defectLogsBloc, widget.programId),
      ),
    );
  }

  Widget _body(DefectLogsBloc defectLogsBloc, int programId) {
    return StreamBuilder(
      stream: defectLogsBloc.defectLogStream,
      builder: (BuildContext context,
          AsyncSnapshot<Tuple2<int, List<DefectLogModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final defectLogs = snapshot.data.item2 ?? [];

        final statusCode = snapshot.data.item1;

        if (statusCode != 200) {
          showSnackBar(context, _scaffoldKey.currentState, statusCode);
        }

        if (defectLogs.isEmpty) {
          return RefreshIndicator(
            onRefresh: () =>
                _refreshDefectLogs(context, defectLogsBloc, programId),
            child: ListView(
              children: [
                Center(child: Text(S.of(context).thereIsNoInformation)),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () =>
              _refreshDefectLogs(context, defectLogsBloc, programId),
          child: _buildListView(defectLogs),
        );
      },
    );
  }

  ListView _buildListView(List<DefectLogModel> defectLogs) {
    return ListView.separated(
        itemCount: defectLogs.length,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, i) => _buildItemList(defectLogs, i, context),
        separatorBuilder: (BuildContext context, int index) => Divider(
              thickness: 1.0,
            ));
  }

  Widget _buildItemList(
      List<DefectLogModel> defectLogs, int i, BuildContext context) {
    return CustomListTile(
      title: 'id: ${defectLogs[i].id}',
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () => navigateToEditPage(defectLogs[i]),
      subtitle: defectLogs[i].description,
    );
  }

  void navigateToEditPage(DefectLogModel defectLog) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => DefectLogEditPage(
            programId: widget.programId,
            defectLog: defectLog,
          ),
        ));
  }

  Future<void> _refreshDefectLogs(BuildContext context,
      DefectLogsBloc defectLogsBloc, int programId) async {
    await defectLogsBloc.getDefectLogs(true, programId);
  }
}
