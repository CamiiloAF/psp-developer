import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psp_developer/src/blocs/time_logs_bloc.dart';
import 'package:psp_developer/src/models/time_logs_model.dart';
import 'package:psp_developer/src/utils/searchs/search_delegate.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';

class SearchTimeLogs extends DataSearch {
  final TimeLogsBloc _timeLogsBloc;

  SearchTimeLogs(this._timeLogsBloc);

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
            },
            subtitle: timeLog.comments,
          );
        }).toList(),
      ));
    } else {
      return super.textNoResults(context);
    }
  }

  bool _areItemContainQuery(TimeLogModel timeLog, String query) {
    return '${timeLog.id}'.contains(query.toLowerCase()) ||
            timeLog.comments.toLowerCase().contains(query.toLowerCase())
        ? true
        : false;
  }
}
