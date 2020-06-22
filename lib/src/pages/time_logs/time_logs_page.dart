import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/time_logs_bloc.dart';
import 'package:psp_developer/src/models/time_logs_model.dart';
import 'package:psp_developer/src/pages/time_logs/time_log_edit_page.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/providers/models/fab_model.dart';
import 'package:psp_developer/src/providers/models/time_log_pending_interruption.dart';
import 'package:psp_developer/src/shared_preferences/shared_preferences.dart';
import 'package:psp_developer/src/utils/constants.dart';
import 'package:psp_developer/src/utils/searchs/search_time_logs.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:psp_developer/src/widgets/buttons_widget.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';
import 'package:psp_developer/src/widgets/drawer_program_items.dart';
import 'package:psp_developer/src/widgets/not_autorized_screen.dart';
import 'package:tuple/tuple.dart';

class TimeLogsPage extends StatefulWidget {
  final int programId;

  TimeLogsPage({this.programId});

  @override
  _TimeLogsPageState createState() => _TimeLogsPageState();
}

class _TimeLogsPageState extends State<TimeLogsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController _scrollController = ScrollController();
  double _lastScroll = 0;

  TimeLogsBloc _timeLogsBloc;

  @override
  void initState() {
    _lastScroll = 0;

    _timeLogsBloc = context.read<BlocProvider>().timeLogsBloc;
    _timeLogsBloc.getTimeLogs(false, widget.programId);

    if (_timeLogsBloc.allowCreateTimeLog) {
      addListenerToScrollController();
    }

    super.initState();
  }

  void addListenerToScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.offset > _lastScroll &&
          _scrollController.offset > 150) {
        Provider.of<FabModel>(context, listen: false).isShowing = false;
      } else {
        Provider.of<FabModel>(context, listen: false).isShowing = true;
      }

      _lastScroll = _scrollController.offset;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isValidToken()) return NotAutorizedScreen();

    var isShowing = (Provider.of<FabModel>(context).isShowing &&
        _timeLogsBloc.allowCreateTimeLog);

    if (Preferences().pendingInterruptionStartAt != null) {
      isShowing = false;
    }

    return ChangeNotifierProvider(
      create: (_) => FabModel(),
      child: Scaffold(
          key: _scaffoldKey,
          drawer: DrawerProgramItems(programId: widget.programId),
          appBar: CustomAppBar(
            title: S.of(context).appBarTitleTimeLogs,
            searchDelegate: SearchTimeLogs(_timeLogsBloc, widget.programId),
          ),
          floatingActionButton: FAB(
            isShowing: isShowing,
            onPressed: () => navigateToEditPage(null),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: _body(_timeLogsBloc, widget.programId)),
    );
  }

  Widget _body(TimeLogsBloc timeLogsBloc, int programId) {
    return StreamBuilder(
      stream: timeLogsBloc.timeLogStream,
      builder: (BuildContext context,
          AsyncSnapshot<Tuple2<int, List<TimeLogModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final timeLogs = snapshot.data.item2 ?? [];

        final statusCode = snapshot.data.item1;

        if (statusCode != 200) {
          showSnackBar(context, _scaffoldKey.currentState, statusCode);
        }

        if (timeLogs.isEmpty) {
          return RefreshIndicator(
            onRefresh: () =>
                _refreshTimeLogs(context, timeLogsBloc, widget.programId),
            child: ListView(
              children: [
                Center(child: Text(S.of(context).thereIsNoInformation)),
              ],
            ),
          );
        }

        _timeLogsBloc.verifyIfAllowCreateTimeLogs(timeLogs);
        Provider.of<FabModel>(context).isShowing = true;

        return RefreshIndicator(
          onRefresh: () =>
              _refreshTimeLogs(context, timeLogsBloc, widget.programId),
          child: _buildListView(timeLogs),
        );
      },
    );
  }

  ListView _buildListView(List<TimeLogModel> timeLogs) {
    return ListView.separated(
        itemCount: timeLogs.length,
        physics: AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        itemBuilder: (context, i) => _buildItemList(timeLogs, i, context),
        separatorBuilder: (BuildContext context, int index) => Divider(
              thickness: 1.0,
            ));
  }

  Widget _buildItemList(
      List<TimeLogModel> timeLogs, int i, BuildContext context) {
    final timeLog = timeLogs[i];

    var isEnabled =
        Provider.of<TimelogPendingInterruptionModel>(context).isListItemsEnable;

    if (!isEnabled &&
        Preferences().timeLogIdWithPendingInterruption == timeLog.id) {
      isEnabled = true;
    }

    return ChangeNotifierProvider(
      create: (_) => TimelogPendingInterruptionModel(),
      child: CustomListTile(
        title: 'id: ${timeLog.id}',
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () => navigateToEditPage(timeLog),
        isEnable: isEnabled,
        subtitle: Constants.format
            .format(DateTime.fromMillisecondsSinceEpoch(timeLog.startDate)),
      ),
    );
  }

  void navigateToEditPage(TimeLogModel timeLog) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => TimeLogEditPage(
            programId: widget.programId,
            timeLog: timeLog,
          ),
        ));
  }

  Future<void> _refreshTimeLogs(
      BuildContext context, TimeLogsBloc timeLogsBloc, int programId) async {
    await timeLogsBloc.getTimeLogs(true, widget.programId);
  }
}
