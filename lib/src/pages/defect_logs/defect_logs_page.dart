import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/defect_logs_bloc.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/providers/models/fab_model.dart';
import 'package:psp_developer/src/searches/mixins/defect_logs_page_and_search_mixing.dart';
import 'package:psp_developer/src/searches/search_defect_logs.dart';
import 'package:psp_developer/src/shared_preferences/shared_preferences.dart';
import 'package:psp_developer/src/utils/token_handler.dart';
import 'package:psp_developer/src/widgets/buttons_widget.dart';
import 'package:psp_developer/src/widgets/common_list_of_models.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/drawer_program_items.dart';
import 'package:psp_developer/src/widgets/not_authorized_screen.dart';

class DefectLogsPage extends StatefulWidget {
  static const ROUTE_NAME = 'defect-logs';
  @override
  _DefectLogsPageState createState() => _DefectLogsPageState();
}

class _DefectLogsPageState extends State<DefectLogsPage>
    with DefectLogsPageAndSearchMixing {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _programId;

  DefectLogsBloc _defectLogsBloc;

  @override
  void initState() {
    _defectLogsBloc = context.read<BlocProvider>().defectLogsBloc;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _programId = ModalRoute.of(context).settings.arguments;
    if (_defectLogsBloc.lastValueDefectLogsController == null) {
      _defectLogsBloc.getDefectLogs(false, _programId);
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _defectLogsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!TokenHandler.existToken()) return NotAuthorizedScreen();

    var isShowing = (Provider.of<FabModel>(context).isShowing &&
        !Provider.of<BlocProvider>(context)
            .programsBloc
            .hasCurrentProgramEnded());

    if (Preferences().pendingInterruptionStartAt != null) isShowing = false;

    return ChangeNotifierProvider(
      create: (_) => FabModel(),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerProgramItems(programId: _programId, scaffoldKey: _scaffoldKey,),
        appBar: CustomAppBar(
          title: S.of(context).appBarTitleDefectLogs,
          searchDelegate: SearchDefectLogs(_defectLogsBloc, _programId),
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
        stream: _defectLogsBloc.defectLogsStream,
        onRefresh: _onRefreshDefectLogs,
        scaffoldKey: _scaffoldKey,
        buildItemList: (items, index) => buildItemList(context, items[index]),
      );

  Future<void> _onRefreshDefectLogs() async =>
      await _defectLogsBloc.getDefectLogs(true, _programId);
}
