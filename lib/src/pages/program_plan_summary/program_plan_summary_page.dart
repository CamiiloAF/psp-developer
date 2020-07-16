//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:psp_developer/generated/l10n.dart';
//import 'package:psp_developer/src/providers/bloc_provider.dart';
//import 'package:psp_developer/src/utils/constants.dart';
//import 'package:psp_developer/src/widgets/custom_app_bar.dart';
//
//class ProgramPlanSummary extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final programPlanSummaryBloc =
//        Provider.of<BlocProvider>(context).programPlanSummaryBloc;
//
//    final itemsTime = programPlanSummaryBloc.itemsTime;
//
//    final defectsInjected = programPlanSummaryBloc.defectsInjected;
//    final defectsRemoved = programPlanSummaryBloc.defectsRemoved;
//
//    return Scaffold(
//      appBar: CustomAppBar(title: 'Summary'),
//      body: Container(
//        margin: EdgeInsets.all(12),
//        child: Column(
//          children: [
//            _ProgramSizeSummary(),
//            _TimeInPhase(),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//class _ProgramSizeSummary extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final programLines =
//        Provider.of<BlocProvider>(context).programPlanSummaryBloc.items;
//
//    return Card(
//      elevation: 8,
//      child: Padding(
//        padding: const EdgeInsets.symmetric(vertical: 8),
//        child: Column(children: [
//          Text(
//            S.of(context).titleProgramSizeSummary,
//            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//          ),
//          SizedBox(
//            height: 20,
//          ),
//          Table(
//            border: TableBorder(
//                bottom: BorderSide(width: .2),
//                horizontalInside: BorderSide(width: .2)),
//            children: [
//              _buildTableRow('', 'Planned', 'Current'),
//              _buildTableRow('Base', programLines['base_planned'],
//                  programLines['base_actual']),
//              _buildTableRow('Deleted', programLines['deleted_planned'],
//                  programLines['deleted_actual']),
//              _buildTableRow('Modified', programLines['modified_planned'],
//                  programLines['modified_actual']),
//              _buildTableRow('Added', programLines['added_planned'],
//                  programLines['added_actual']),
//              _buildTableRow('Reused', programLines['reused_planned'],
//                  programLines['reused_actual']),
//              _buildTableRow(
//                  '',
//                  _calculateTotalLines(programLines, isPlanned: true),
//                  _calculateTotalLines(programLines, isPlanned: false)),
//            ],
//          ),
//        ]),
//      ),
//    );
//  }
//
//  TableRow _buildTableRow(
//      String label, dynamic plannedSize, dynamic currentSize) {
//    return TableRow(children: [
//      Padding(
//        padding: const EdgeInsets.only(left: 8, top: 5),
//        child: Text(label),
//      ),
//      Padding(
//        padding: const EdgeInsets.all(5),
//        child: Center(child: Text('$plannedSize')),
//      ),
//      Padding(
//        padding: const EdgeInsets.all(5),
//        child: Center(child: Text('$currentSize')),
//      ),
//    ]);
//  }
//
//  int _calculateTotalLines(Map<String, int> programLines, {bool isPlanned}) {
//    var total = 0;
//
//    final typeLines = (isPlanned) ? 'planned' : 'actual';
//
//    total += programLines['base_$typeLines'];
//    total += programLines['deleted_$typeLines'];
//    total += programLines['modified_$typeLines'];
//    total += programLines['added_$typeLines'];
//
//    return total;
//  }
//}
//
//class _TimeInPhase extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final tableRowItems = itemsTime
//        .map((item) => _buildTableRow(
//            item['phaseId'], item['actualTime'], item['percent']))
//        .toList();
//
//    return Card(
//      elevation: 8,
//      child: Column(
//        children: [
//          Text(
//            'TIME IN PHASE (MIN)',
//            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//          ),
//          SizedBox(
//            height: 20,
//          ),
//          Padding(
//            padding: const EdgeInsets.symmetric(vertical: 8),
//            child: Table(
//              border: TableBorder(
//                  bottom: BorderSide(width: .2),
//                  horizontalInside: BorderSide(width: .2)),
//              children: [
//                _buildTableRow(null, 'Actual', 'Percent'),
//                ...tableRowItems,
//                _buildTableRow(null, 'Total: ${_calculateTotal()}', null),
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  TableRow _buildTableRow(int phaseId, dynamic actualTime, dynamic percent) {
//    return TableRow(children: [
//      Padding(
//        padding: const EdgeInsets.only(left: 8, top: 5),
//        child:
//            Text((phaseId == null) ? '' : Constants.PHASES[phaseId - 1].name),
//      ),
//      Padding(
//        padding: const EdgeInsets.all(5),
//        child: Center(child: Text('$actualTime')),
//      ),
//      Padding(
//        padding: const EdgeInsets.all(5),
//        child: Center(child: Text((percent != null) ? '$percent %' : '')),
//      ),
//    ]);
//  }
//
//  int _calculateTotal() {
//    var total = 0;
//
//    itemsTime.forEach((element) {
//      total += element['actualTime'];
//    });
//
//    return total;
//  }
//
////! defectsInjected
////json{
////  phaseId: 1,
////  defectsInjected: 9,
////  percent: 20
////}
//
//// ? DefectsRemovedInPhase:
//// json{
////  phaseId: 1,
////  defectsRemoved: 13,
////  percent: 58
////}
//}
