import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/reusable_parts_bloc.dart';
import 'package:psp_developer/src/models/reusable_parts_model.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:psp_developer/src/widgets/buttons_widget.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';
import 'package:psp_developer/src/widgets/inputs_widget.dart';
import 'package:psp_developer/src/widgets/spinner_widget.dart';
import 'package:tuple/tuple.dart';

class ReusablePartsPage extends StatefulWidget {
  final int programId;

  ReusablePartsPage({this.programId});

  @override
  _ReusablePartsPageState createState() => _ReusablePartsPageState();
}

class _ReusablePartsPageState extends State<ReusablePartsPage>
    with AutomaticKeepAliveClientMixin {
  ReusablePartsBloc _reusablePartBloc;
  int programReusableId = 1;

  @override
  void initState() {
    _reusablePartBloc = context.read<BlocProvider>().reusablePartsBloc;

    super.initState();
  }

  @override
  void dispose() {
    _reusablePartBloc.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => _AddedReusablePartsModel(),
      builder: (ctx, child) => Column(
        children: [
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: _Form(_reusablePartBloc, ctx, widget.programId),
              ),
            ),
          ),
          Expanded(child: _buildAddedReusablePartsList(ctx)),
        ],
      ),
    );
  }

  Widget _buildAddedReusablePartsList(BuildContext ctx) {
    final reusableParts = Provider.of<_AddedReusablePartsModel>(ctx)
        .addedReusableParts
        .reversed
        .toList();

    return ListView.separated(
        itemCount: reusableParts.length,
        itemBuilder: (context, i) => _buildItemList(reusableParts, i, ctx),
        separatorBuilder: (BuildContext context, int index) => Divider(
              thickness: 1.0,
            ));
  }

  Widget _buildItemList(
      List<ReusablePartModel> reusableParts, int i, BuildContext ctx) {
    return CustomListTile(
        title:
            '${reusableParts.length - i} - ${S.of(context).labelPlannedLinesBase}: ${reusableParts[i].plannedLines}',
        trailing: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _removeReusablePart(ctx, reusableParts[i]),
              ),
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editReusablePart(ctx, reusableParts[i])),
            ],
          ),
        ),
        isAnimated: false,
        onTap: () {});
  }

  void _removeReusablePart(BuildContext ctx, ReusablePartModel reusablePart) {
    final addedReusablePartsModel =
        Provider.of<_AddedReusablePartsModel>(ctx, listen: false);

    _reusablePartBloc.addedReusableParts.remove(reusablePart);

    addedReusablePartsModel.removeReusablePart(reusablePart);
  }

  void _editReusablePart(BuildContext ctx, ReusablePartModel reusablePart) {
    final addedReusablePartsModel =
        Provider.of<_AddedReusablePartsModel>(ctx, listen: false);

    addedReusablePartsModel.currentReusablePart = reusablePart;

    _removeReusablePart(ctx, reusablePart);
  }
}

class _Form extends StatefulWidget {
  final int programsId;
  final ReusablePartsBloc reusablePartBloc;
  final BuildContext ctx;

  _Form(this.reusablePartBloc, this.ctx, this.programsId);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();
  ReusablePartModel _reusablePart = ReusablePartModel();

  bool isUIDisable;
  int _currentReusableProgramId;

  List<Tuple2<int, String>> programsTuple;

  @override
  void initState() {
    _reusablePart =
        context.read<_AddedReusablePartsModel>().currentReusablePart;

    programsTuple = context
        .read<BlocProvider>()
        .programsBloc
        .lastValueProgramsByOrganizationController
        ?.item2;

    _currentReusableProgramId =
        (isNullOrEmpty(programsTuple)) ? -1 : programsTuple[0].item1;

    isUIDisable = isNullOrEmpty(programsTuple);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _reusablePart =
        Provider.of<_AddedReusablePartsModel>(context).currentReusablePart;

    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 10),
            _buildReusableProgramDropdownButton(),
            _builNumericInput(
                context,
                S.of(context).labelPlannedLinesBase,
                '${_reusablePart?.plannedLines ?? ''}',
                (value) => _reusablePart?.plannedLines = int.tryParse(value)),
            SubmitButton(onPressed: (isUIDisable) ? null : _saveReusablePart)
          ],
        ));
  }

  Widget _buildReusableProgramDropdownButton() {
    _reusablePart =
        Provider.of<_AddedReusablePartsModel>(context).currentReusablePart;

    return Spinner(
      label: S.of(context).labelReusableProgram,
      items: _getDropDownMenuItems(),
      value: _reusablePart?.programsReusablesId ?? _currentReusableProgramId,
      onChanged: (value) {
        setState(() {
          _formKey.currentState.save();
          _reusablePart.programsReusablesId = value;
          _currentReusableProgramId = value;
        });
      },
    );
  }

  List<DropdownMenuItem<int>> _getDropDownMenuItems() {
    final items = <DropdownMenuItem<int>>[];

    if (!isNullOrEmpty(programsTuple)) {
      programsTuple.forEach((programTuple) {
        items.add(DropdownMenuItem(
            value: programTuple.item1, child: Text(programTuple.item2)));
      });
    } else {
      items.add(DropdownMenuItem(
          value: -1,
          child: Text((isNullOrEmpty(programsTuple))
              ? S.of(context).labelDoNotHavePrograms
              : S.of(context).labelNone)));
    }

    return items;
  }

  Widget _builNumericInput(BuildContext context, String label, String text,
      Function(String) onSaved) {
    final controller = TextEditingController();
    controller.text = text;

    return InputForm(
      label: label,
      controller: controller,
      isEnabled: !isUIDisable,
      margin: EdgeInsets.only(top: 10),
      onSaved: onSaved,
      validator: (value) {
        return (widget.reusablePartBloc.isValidNumber(value)
            ? null
            : S.of(context).invalidNumber);
      },
      maxLenght: 10,
      keyboardType: TextInputType.number,
    );
  }

  void _saveReusablePart() {
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

    _reusablePart.programsId = widget.programsId;
    _reusablePart.programsReusablesId =
        (_currentReusableProgramId == -1) ? null : _currentReusableProgramId;

    Provider.of<_AddedReusablePartsModel>(widget.ctx, listen: false)
      ..addReusableParts(_reusablePart)
      ..currentReusablePart = ReusablePartModel();

    widget.reusablePartBloc.addedReusableParts.add(_reusablePart);

    _reusablePart = ReusablePartModel();

    clearInputs();
  }

  void clearInputs() {
    setState(() {});
  }
}

class _AddedReusablePartsModel with ChangeNotifier {
  final List<ReusablePartModel> _addedReusableParts = [];

  List<ReusablePartModel> get addedReusableParts => _addedReusableParts;

  ReusablePartModel _currentReusablePart = ReusablePartModel();

  void addReusableParts(ReusablePartModel value) {
    _addedReusableParts.add(value);
    notifyListeners();
  }

  void removeReusablePart(ReusablePartModel value) {
    _addedReusableParts.remove(value);
    notifyListeners();
  }

  ReusablePartModel get currentReusablePart => _currentReusablePart;
  set currentReusablePart(value) {
    _currentReusablePart = value;
    notifyListeners();
  }
}
