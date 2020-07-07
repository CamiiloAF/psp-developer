import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psp_developer/src/blocs/time_logs_bloc.dart';
import 'package:psp_developer/src/models/time_logs_model.dart';
import 'package:psp_developer/src/searches/mixings/time_logs_page_and_search_mixing.dart';
import 'package:psp_developer/src/searches/search_delegate.dart';
import 'package:psp_developer/src/utils/constants.dart';

class SearchTimeLogs extends DataSearch with TimeLogsPageAndSearchMixing {
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
          return buildItemList(context, timeLog,
              closeSearch: () => close(context, null));
        }).toList(),
      ));
    } else {
      return super.textNoResults(context);
    }
  }

  bool _areItemContainQuery(TimeLogModel timeLog, String query) {
    return '${timeLog.id}'.contains(query.toLowerCase()) ||
            Constants.format
                .format(DateTime.fromMillisecondsSinceEpoch(timeLog.startDate))
                .contains(query)
        ? true
        : false;
  }
}
