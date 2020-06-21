import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psp_developer/src/blocs/time_logs_bloc.dart';
import 'package:psp_developer/src/models/time_logs_model.dart';
import 'package:psp_developer/src/pages/time_logs/time_log_edit_page.dart';
import 'package:psp_developer/src/utils/searchs/search_delegate.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';

import '../constants.dart';

class SearchTimeLogs extends DataSearch {
  final TimeLogsBloc _timeLogsBloc;
  final int _programId;

  SearchTimeLogs(this._timeLogsBloc, this._programId);

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return super.textNoResults(context);

    final timeLogs = _timeLogsBloc?.lastValueTimeLogsController?.item2 ?? [];
    if (timeLogs.isNotEmpty && timeLogs != null) {
      return Container(
          child: ListView(
        children: timeLogs
            .where((timeLog) => _areItemContainQuery(timeLog, query))
            .map((timeLog) {
          return CustomListTile(
              title: 'id: ${timeLog.id}',
              onTap: () {
                close(context, null);
                navigateToProjectEditPage(context, timeLog);
              },
              subtitle: Constants.format.format(
                  DateTime.fromMillisecondsSinceEpoch(timeLog.startDate)));
        }).toList(),
      ));
    } else {
      return super.textNoResults(context);
    }
  }

  void navigateToProjectEditPage(BuildContext context, TimeLogModel timeLog) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => TimeLogEditPage(
            programId: _programId,
            timeLog: timeLog,
          ),
        ));
  }

  bool _areItemContainQuery(TimeLogModel timeLog, String query) {
    return '${timeLog.id}'.contains(query.toLowerCase()) ||
            timeLog.comments.toLowerCase().contains(query.toLowerCase())
        ? true
        : false;
  }
}
