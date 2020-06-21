import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psp_developer/src/blocs/defect_logs_bloc.dart';
import 'package:psp_developer/src/models/defect_logs_model.dart';
import 'package:psp_developer/src/pages/defect_logs/defect_log_edit_page.dart';
import 'package:psp_developer/src/utils/searchs/search_delegate.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';

class SearchDefectLogs extends DataSearch {
  final DefectLogsBloc _defectLogsBloc;
  final int programId;

  SearchDefectLogs(this._defectLogsBloc, this.programId);

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return super.textNoResults(context);

    final defectLogs =
        _defectLogsBloc?.lastValueDefectLogsController?.item2 ?? [];
    if (defectLogs.isNotEmpty && defectLogs != null) {
      return Container(
          child: ListView(
        children: defectLogs
            .where((defectLog) => _areItemContainQuery(defectLog, query))
            .map((defectLog) {
          return CustomListTile(
            title: 'id: ${defectLog.id}',
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () => navigateToEditPage(context, defectLog),
            subtitle: defectLog.description,
          );
        }).toList(),
      ));
    } else {
      return super.textNoResults(context);
    }
  }

  void navigateToEditPage(BuildContext context, DefectLogModel defectLog) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => DefectLogEditPage(
            programId: programId,
            defectLog: defectLog,
          ),
        ));
  }

  bool _areItemContainQuery(DefectLogModel defectLog, String query) {
    return '${defectLog.id}'.contains(query.toLowerCase()) ||
            defectLog.description.toLowerCase().contains(query.toLowerCase())
        ? true
        : false;
  }
}
