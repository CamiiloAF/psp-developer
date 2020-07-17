import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/time_logs_bloc.dart';
import 'package:psp_developer/src/models/time_logs_model.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/providers/models/fab_model.dart';
import 'package:psp_developer/src/providers/models/time_log_pending_interruption.dart';
import 'package:psp_developer/src/searches/mixins/time_logs_page_and_search_mixing.dart';
import 'package:psp_developer/src/searches/search_time_logs.dart';
import 'package:psp_developer/src/shared_preferences/shared_preferences.dart';
import 'package:psp_developer/src/utils/token_handler.dart';
import 'package:psp_developer/src/widgets/buttons_widget.dart';
import 'package:psp_developer/src/widgets/common_list_of_models.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/drawer_program_items.dart';
import 'package:psp_developer/src/widgets/not_authorized_screen.dart';

class TimeLogsPage extends StatefulWidget {
  static const ROUTE_NAME = 'time-logs';
  @override
  _TimeLogsPageState createState() => _TimeLogsPageState();
}

class _TimeLogsPageState extends State<TimeLogsPage>
    with TimeLogsPageAndSearchMixing {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TimeLogsBloc _timeLogsBloc;
  int _programId;

  @override
  void initState() {
    final blocProvider = context.read<BlocProvider>();
    _timeLogsBloc = blocProvider.timeLogsBloc;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _programId = ModalRoute.of(context).settings.arguments;

    Provider.of<BlocProvider>(context)
        .programsBloc
        .setCurrentProgram(_programId);

    if (_timeLogsBloc.lastValueTimeLogsController == null) {
      _timeLogsBloc.getTimeLogs(false, _programId);
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timeLogsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!TokenHandler.existToken()) return NotAuthorizedScreen();

    var isShowing = (Provider.of<FabModel>(context).isShowing &&
        _timeLogsBloc.allowCreateTimeLog);

    if (Preferences().pendingInterruptionStartAt != null) {
      isShowing = false;
      Provider.of<TimelogPendingInterruptionModel>(context).isListItemsEnable =
          false;
    }

    return ChangeNotifierProvider(
      create: (_) => FabModel(),
      child: _buildScaffold(context, isShowing),
    );
  }

  Scaffold _buildScaffold(BuildContext context, bool isShowing) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: DrawerProgramItems(programId: _programId),
        appBar: CustomAppBar(
          title: S.of(context).appBarTitleTimeLogs,
          searchDelegate: SearchTimeLogs(_timeLogsBloc),
        ),
        floatingActionButton: FAB(
          isShowing: isShowing,
          onPressed: () => navigateToEditPage(context, null, _programId),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _body());
  }

  Widget _body() => CommonListOfModels(
        stream: _timeLogsBloc.timeLogsStream,
        onRefresh: _onRefreshTimeLogs,
        scaffoldKey: _scaffoldKey,
        buildItemList: (items, index) => buildItemList(context, items[index]),
        verifyIfAllowCreateTimeLogs: (List<TimeLogModel> timeLogs) {
          _timeLogsBloc.verifyIfAllowCreateTimeLogs(timeLogs);
        },
      );

  Future<void> _onRefreshTimeLogs() async =>
      await _timeLogsBloc.getTimeLogs(true, _programId);
}
