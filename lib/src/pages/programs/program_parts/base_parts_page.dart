import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/base_parts_bloc.dart';
import 'package:psp_developer/src/models/base_parts_model.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/widgets/buttons_widget.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';
import 'package:psp_developer/src/widgets/inputs_widget.dart';

class BasePartsPage extends StatefulWidget {
  final int programId;

  BasePartsPage({this.programId});

  @override
  _BasePartsPageState createState() => _BasePartsPageState();
}

class _BasePartsPageState extends State<BasePartsPage> {
  BasePartsBloc _basePartBloc;

  @override
  void initState() {
    _basePartBloc = context.read<BlocProvider>().basePartsBloc;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _AddedBasePartsModel(),
      builder: (ctx, child) => Column(
        children: [
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: _Form(_basePartBloc, ctx, widget.programId),
              ),
            ),
          ),
          Expanded(child: _buildAddedBasePartsList(ctx)),
        ],
      ),
    );
  }

  Widget _buildAddedBasePartsList(BuildContext ctx) {
    final baseParts =
        Provider.of<_AddedBasePartsModel>(ctx).addedBaseParts.reversed.toList();
    return ListView.separated(
        itemCount: baseParts.length,
        itemBuilder: (context, i) => _buildItemList(baseParts, i, ctx),
        separatorBuilder: (BuildContext context, int index) => Divider(
              thickness: 1.0,
            ));
  }

  Widget _buildItemList(
      List<BasePartModel> baseParts, int i, BuildContext ctx) {
    final addedBasePartsModel =
        Provider.of<_AddedBasePartsModel>(ctx, listen: false);

    return CustomListTile(
        title:
            '${baseParts.length - i} - ${S.of(context).labelPlannedLinesBase}: ${baseParts[i].plannedLinesBase}',
        trailing: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () =>
                    addedBasePartsModel.removeBasePart(baseParts[i]),
              ),
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    addedBasePartsModel.currentBasePart = baseParts[i];
                    addedBasePartsModel.removeBasePart(baseParts[i]);
                  }),
            ],
          ),
        ),
        isAnimated: false,
        onTap: () {});
  }
}

class _Form extends StatefulWidget {
  final int programsId;
  final BasePartsBloc _basePartBloc;
  final BuildContext ctx;

  _Form(this._basePartBloc, this.ctx, this.programsId);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();

  BasePartModel _basePart = BasePartModel();

  @override
  Widget build(BuildContext context) {
    _basePart = Provider.of<_AddedBasePartsModel>(context).currentBasePart;

    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 10),
            _builNumericInput(
                context,
                S.of(context).labelPlannedLinesBase,
                '${_basePart?.plannedLinesBase ?? ''}',
                (value) => _basePart.plannedLinesBase = int.parse(value)),
            _builNumericInput(
                context,
                S.of(context).labelPlannedLinesDeleted,
                '${_basePart?.plannedLinesDeleted ?? ''}',
                (value) => _basePart.plannedLinesDeleted = int.parse(value)),
            _builNumericInput(
                context,
                S.of(context).labelPlannedLinesEdits,
                '${_basePart?.plannedLinesEdits ?? ''}',
                (value) => _basePart.plannedLinesEdits = int.parse(value)),
            _builNumericInput(
                context,
                S.of(context).labelPlannedLinesAdded,
                '${_basePart?.plannedLinesAdded ?? ''}',
                (value) => _basePart.plannedLinesAdded = int.parse(value)),
            SubmitButton(onPressed: _saveBasePart)
          ],
        ));
  }

  Widget _builNumericInput(BuildContext context, String label, String text,
      Function(String) onSaved) {
    final controller = TextEditingController();
    controller.text = text;

    return InputForm(
      label: label,
      controller: controller,
      margin: EdgeInsets.only(top: 10),
      onSaved: onSaved,
      validator: (value) {
        return (widget._basePartBloc.isValidNumber(value)
            ? null
            : S.of(context).invalidNumber);
      },
      maxLenght: 10,
      keyboardType: TextInputType.number,
    );
  }

  void _saveBasePart() {
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

//TODO: Agrear el spinner para los programas base
    _basePart.programsId = widget.programsId;
    Provider.of<_AddedBasePartsModel>(widget.ctx, listen: false)
      ..addBaseParts(_basePart)
      ..currentBasePart = BasePartModel();

    _basePart = BasePartModel();

    clearInputs();
  }

  void clearInputs() {
    setState(() {});
  }
}

class _AddedBasePartsModel with ChangeNotifier {
  final List<BasePartModel> _addedBaseParts = [];

  List<BasePartModel> get addedBaseParts => _addedBaseParts;

  BasePartModel _currentBasePart;

  void addBaseParts(BasePartModel value) {
    _addedBaseParts.add(value);
    notifyListeners();
  }

  void removeBasePart(BasePartModel value) {
    _addedBaseParts.remove(value);
    notifyListeners();
  }

  BasePartModel get currentBasePart => _currentBasePart;
  set currentBasePart(value) {
    _currentBasePart = value;
    notifyListeners();
  }
}
