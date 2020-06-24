// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:psp_developer/generated/l10n.dart';
// import 'package:psp_developer/src/blocs/reusable_parts_bloc.dart';
// import 'package:psp_developer/src/providers/bloc_provider.dart';
// import 'package:psp_developer/src/widgets/buttons_widget.dart';
// import 'package:psp_developer/src/widgets/custom_list_tile.dart';
// import 'package:psp_developer/src/widgets/inputs_widget.dart';

// class ReusablePartsPage extends StatefulWidget {
//   final int programId;

//   ReusablePartsPage({this.programId});

//   @override
//   _ReusablePartsPageState createState() => _ReusablePartsPageState();
// }

// class _ReusablePartsPageState extends State<ReusablePartsPage> {
//   ReusablePartsBloc _reusablePartBloc;

//   @override
//   void initState() {
//     _reusablePartBloc = context.read<BlocProvider>().reusablePartsBloc;

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => _AddedReusablePartsModel(),
//       builder: (ctx, child) => Column(
//         children: [
//           Expanded(
//             flex: 3,
//             child: SingleChildScrollView(
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 15.0),
//                 child: _Form(_reusablePartBloc, ctx),
//               ),
//             ),
//           ),
//           Expanded(child: _buildAddedReusablePartsList(ctx)),
//         ],
//       ),
//     );
//   }

//   Widget _buildAddedReusablePartsList(BuildContext ctx) {
//     final reusableParts = Provider.of<_AddedReusablePartsModel>(ctx)
//         .addedReusableParts
//         .reversed
//         .toList();
//     return ListView.separated(
//         itemCount: reusableParts.length,
//         itemBuilder: (context, i) => _buildItemList(reusableParts, i, ctx),
//         separatorBuilder: (BuildContext context, int index) => Divider(
//               thickness: 1.0,
//             ));
//   }

//   Widget _buildItemList(
//       List<ReusablePartModel> reusableParts, int i, BuildContext ctx) {
//     final addedReusablePartsModel =
//         Provider.of<_AddedReusablePartsModel>(ctx, listen: false);

//     return CustomListTile(
//         title:
//             '${reusableParts.length - i} - ${S.of(context).labelPlannedLinesReusable}: ${reusableParts[i].plannedLinesReusable}',
//         trailing: Container(
//           width: MediaQuery.of(context).size.width * 0.25,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.delete),
//                 onPressed: () => addedReusablePartsModel
//                     .removeReusablePart(reusableParts[i]),
//               ),
//               IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () {
//                     addedReusablePartsModel.currentReusablePart =
//                         reusableParts[i];
//                     addedReusablePartsModel
//                         .removeReusablePart(reusableParts[i]);
//                   }),
//             ],
//           ),
//         ),
//         isAnimated: false,
//         onTap: () {});
//   }
// }

// class _Form extends StatefulWidget {
//   final ReusablePartsBloc _reusablePartBloc;
//   final BuildContext ctx;

//   _Form(this._reusablePartBloc, this.ctx);

//   @override
//   __FormState createState() => __FormState();
// }

// class __FormState extends State<_Form> {
//   final _formKey = GlobalKey<FormState>();

//   ReusablePartModel _reusablePart = ReusablePartModel();

//   @override
//   Widget build(BuildContext context) {
//     _reusablePart =
//         Provider.of<_AddedReusablePartsModel>(context).currentReusablePart;

//     return Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             SizedBox(height: 10),
//             _builNumericInput(
//                 context,
//                 S.of(context).labelPlannedLinesReusable,
//                 '${_reusablePart?.plannedLinesReusable ?? ''}',
//                 (value) =>
//                     _reusablePart.plannedLinesReusable = int.parse(value)),
//             _builNumericInput(
//                 context,
//                 S.of(context).labelPlannedLinesDeleted,
//                 '${_reusablePart?.plannedLinesDeleted ?? ''}',
//                 (value) =>
//                     _reusablePart.plannedLinesDeleted = int.parse(value)),
//             _builNumericInput(
//                 context,
//                 S.of(context).labelPlannedLinesEdits,
//                 '${_reusablePart?.plannedLinesEdits ?? ''}',
//                 (value) => _reusablePart.plannedLinesEdits = int.parse(value)),
//             _builNumericInput(
//                 context,
//                 S.of(context).labelPlannedLinesAdded,
//                 '${_reusablePart?.plannedLinesAdded ?? ''}',
//                 (value) => _reusablePart.plannedLinesAdded = int.parse(value)),
//             SubmitButton(onPressed: _saveReusablePart)
//           ],
//         ));
//   }

//   Widget _builNumericInput(BuildContext context, String label, String text,
//       Function(String) onSaved) {
//     final controller = TextEditingController();
//     controller.text = text;

//     return InputForm(
//       label: label,
//       controller: controller,
//       margin: EdgeInsets.only(top: 10),
//       onSaved: onSaved,
//       validator: (value) {
//         return (widget._reusablePartBloc.isValidNumber(value)
//             ? null
//             : S.of(context).invalidNumber);
//       },
//       maxLenght: 10,
//       keyboardType: TextInputType.number,
//     );
//   }

//   void _saveReusablePart() {
//     if (!_formKey.currentState.validate()) return;

//     _formKey.currentState.save();

//     Provider.of<_AddedReusablePartsModel>(widget.ctx, listen: false)
//       ..addReusableParts(_reusablePart)
//       ..currentReusablePart = ReusablePartModel();

//     _reusablePart = ReusablePartModel();

//     clearInputs();
//   }

//   void clearInputs() {
//     setState(() {});
//   }
// }

// class _AddedReusablePartsModel with ChangeNotifier {
//   final List<ReusablePartModel> _addedReusableParts = [];

//   List<ReusablePartModel> get addedReusableParts => _addedReusableParts;

//   ReusablePartModel _currentReusablePart;

//   void addReusableParts(ReusablePartModel value) {
//     _addedReusableParts.add(value);
//     notifyListeners();
//   }

//   void removeReusablePart(ReusablePartModel value) {
//     _addedReusableParts.remove(value);
//     notifyListeners();
//   }

//   ReusablePartModel get currentReusablePart => _currentReusablePart;
//   set currentReusablePart(value) {
//     _currentReusablePart = value;
//     notifyListeners();
//   }
// }
