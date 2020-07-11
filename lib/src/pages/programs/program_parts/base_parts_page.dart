import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/base_parts_bloc.dart';
import 'package:psp_developer/src/models/base_parts_model.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:psp_developer/src/widgets/buttons_widget.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';
import 'package:psp_developer/src/widgets/inputs_widget.dart';
import 'package:psp_developer/src/widgets/spinner_widget.dart';
import 'package:tuple/tuple.dart';

class BasePartsPage extends StatefulWidget {
  final int programId;

  BasePartsPage({this.programId});

  @override
  _BasePartsPageState createState() => _BasePartsPageState();
}

class _BasePartsPageState extends State<BasePartsPage>
    with AutomaticKeepAliveClientMixin {
  BasePartsBloc _basePartBloc;
  int programBaseId = 1;

  @override
  void initState() {
    _basePartBloc = context.read<BlocProvider>().basePartsBloc;

    super.initState();
  }

  @override
  void dispose() {
    _basePartBloc.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
                onPressed: () => _removeBasePart(ctx, baseParts[i]),
              ),
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editBasePart(ctx, baseParts[i])),
            ],
          ),
        ),
        isAnimated: false,
        onTap: () {});
  }

  void _removeBasePart(BuildContext ctx, BasePartModel basePart) {
    final addedBasePartsModel =
        Provider.of<_AddedBasePartsModel>(ctx, listen: false);

    _basePartBloc.addedBaseParts.remove(basePart);

    addedBasePartsModel.removeBasePart(basePart);
  }

  void _editBasePart(BuildContext ctx, BasePartModel basePart) {
    final addedBasePartsModel =
        Provider.of<_AddedBasePartsModel>(ctx, listen: false);

    addedBasePartsModel.currentBasePart = basePart;

    _removeBasePart(ctx, basePart);
  }
}

class _Form extends StatefulWidget {
  final int programsId;
  final BasePartsBloc basePartBloc;
  final BuildContext ctx;

  _Form(this.basePartBloc, this.ctx, this.programsId);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();
  BasePartModel _basePart = BasePartModel();

  bool isUIDisable;
  int _currentBaseProgramId;

  List<Tuple2<int, String>> programsTuple;

  @override
  void initState() {
    _basePart = context.read<_AddedBasePartsModel>().currentBasePart;

    programsTuple = context
        .read<BlocProvider>()
        .programsBloc
        .lastValueProgramsByOrganizationController
        ?.item2;

    _initializeCurrentBaseProgramId();

    isUIDisable = isNullOrEmpty(programsTuple);

    super.initState();
  }

  void _initializeCurrentBaseProgramId() {
    _currentBaseProgramId = _basePart?.programsBaseId ?? -1;

    if (!isNullOrEmpty(programsTuple)) {
      _currentBaseProgramId = programsTuple[0].item1;
    }
  }

  @override
  Widget build(BuildContext context) {
    _basePart = Provider.of<_AddedBasePartsModel>(context).currentBasePart;

    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 10),
            _buildBaseProgramDropdownButton(),
            _builNumericInput(
                context,
                S.of(context).labelPlannedLinesBase,
                '${_basePart?.plannedLinesBase ?? ''}',
                (value) => _basePart?.plannedLinesBase = int.tryParse(value)),
            _builNumericInput(
                context,
                S.of(context).labelPlannedLinesDeleted,
                '${_basePart?.plannedLinesDeleted ?? ''}',
                (value) =>
                    _basePart?.plannedLinesDeleted = int.tryParse(value)),
            _builNumericInput(
                context,
                S.of(context).labelPlannedLinesEdits,
                '${_basePart?.plannedLinesEdits ?? ''}',
                (value) => _basePart?.plannedLinesEdits = int.tryParse(value)),
            _builNumericInput(
                context,
                S.of(context).labelPlannedLinesAdded,
                '${_basePart?.plannedLinesAdded ?? ''}',
                (value) => _basePart?.plannedLinesAdded = int.tryParse(value)),
            SubmitButton(onPressed: (isUIDisable) ? null : _saveBasePart)
          ],
        ));
  }

  Widget _buildBaseProgramDropdownButton() {
    _basePart = Provider.of<_AddedBasePartsModel>(context).currentBasePart;

    return Spinner(
      label: S.of(context).labelBaseProgram,
      items: _getDropDownMenuItems(),
      value: _basePart?.programsBaseId ?? _currentBaseProgramId,
      onChanged: (value) {
        setState(() {
          _formKey.currentState.save();
          _basePart.programsBaseId = value;
          _currentBaseProgramId = value;
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
          value: -1, child: Text(S.of(context).labelDoNotHavePrograms)));
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
        return (widget.basePartBloc.isValidNumber(value)
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

    _basePart.programsId = widget.programsId;
    _basePart.programsBaseId = _currentBaseProgramId;

    Provider.of<_AddedBasePartsModel>(widget.ctx, listen: false)
      ..addBaseParts(_basePart)
      ..currentBasePart = BasePartModel();

    widget.basePartBloc.addedBaseParts.add(_basePart);

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

  BasePartModel _currentBasePart = BasePartModel();

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
