import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/new_parts_bloc.dart';
import 'package:psp_developer/src/models/new_parts_model.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/providers/models/added_new_parts_model.dart';
import 'package:psp_developer/src/utils/constants.dart';
import 'package:psp_developer/src/widgets/buttons_widget.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';
import 'package:psp_developer/src/widgets/inputs_widget.dart';
import 'package:psp_developer/src/widgets/spinner_widget.dart';

class NewPartsPage extends StatefulWidget {
  final int programId;

  NewPartsPage({this.programId});

  @override
  _NewPartsPageState createState() => _NewPartsPageState();
}

class _NewPartsPageState extends State<NewPartsPage>
    with AutomaticKeepAliveClientMixin {
  NewPartsBloc _newPartBloc;
  int programNewId = 1;

  @override
  void initState() {
    _newPartBloc = context.read<BlocProvider>().newPartsBloc;

    super.initState();
  }

  @override
  void dispose() {
    _newPartBloc.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: _Form(_newPartBloc, widget.programId),
            ),
          ),
        ),
        Expanded(child: _buildAddedNewPartsList()),
      ],
    );
  }

  Widget _buildAddedNewPartsList() {
    final newParts = Provider.of<AddedNewPartsModel>(context)
        .addedNewParts
        .reversed
        .toList();

    return ListView.separated(
        itemCount: newParts.length,
        itemBuilder: (context, i) => _buildItemList(newParts, i),
        separatorBuilder: (BuildContext context, int index) => Divider(
              thickness: 1.0,
            ));
  }

  Widget _buildItemList(List<NewPartModel> newParts, int i) {
    return CustomListTile(
        title:
            '${newParts.length - i} - ${S.of(context).labelName}: ${newParts[i].name}',
        trailing: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _removeNewPart(newParts[i]),
              ),
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editNewPart(newParts[i])),
            ],
          ),
        ),
        isAnimated: false,
        onTap: () {});
  }

  void _removeNewPart(NewPartModel newPart) {
    final addedNewPartsModel =
        Provider.of<AddedNewPartsModel>(context, listen: false);

    _newPartBloc.addedNewParts.remove(newPart);

    addedNewPartsModel.removeNewPart(newPart);
  }

  void _editNewPart(NewPartModel newPart) {
    final addedNewPartsModel =
        Provider.of<AddedNewPartsModel>(context, listen: false);

    addedNewPartsModel.currentNewPart = newPart;
    addedNewPartsModel.setNewPartTypeAndSizeById(newPart.typesSizesId);

    _removeNewPart(newPart);
  }
}

class _Form extends StatefulWidget {
  final NewPartsBloc newPartBloc;
  final int programId;

  _Form(this.newPartBloc, this.programId);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();
  NewPartModel _newPart = NewPartModel();

  @override
  void initState() {
    _newPart = context.read<AddedNewPartsModel>().currentNewPart;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _newPart = Provider.of<AddedNewPartsModel>(context).currentNewPart;

    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 10),
            _buildSizeTypeDropdownButton(true),
            _buildSizeTypeDropdownButton(false),
            _buildInputName(
              '${_newPart?.name ?? ''}',
            ),
            _buildNumericInput(
                context,
                S.of(context).labelMethodsPlanned,
                '${_newPart?.numberMethodsPlanned ?? ''}',
                (value) =>
                    _newPart?.numberMethodsPlanned = int.tryParse(value)),
            SubmitButton(onPressed: _saveNewPart)
          ],
        ));
  }

  Widget _buildSizeTypeDropdownButton(bool isForType) {
    final addedNewPartsModel = Provider.of<AddedNewPartsModel>(context);
    _newPart = addedNewPartsModel.currentNewPart;

    return Spinner(
      label: (isForType) ? S.of(context).labelType : S.of(context).labelSize,
      items: _getDropDownMenuItems(isForType),
      value: (isForType)
          ? addedNewPartsModel.newPartType
          : addedNewPartsModel.newPartSize,
      onChanged: (value) {
        setState(() {
          _formKey.currentState.save();
          if (isForType) {
            addedNewPartsModel.newPartType = value;
          } else {
            addedNewPartsModel.newPartSize = value;
          }
        });
      },
    );
  }

  List<DropdownMenuItem<String>> _getDropDownMenuItems(bool isForType) {
    final items = <DropdownMenuItem<String>>[];

    if (isForType) {
      Constants.NEW_PART_TYPE.forEach((type) {
        items.add(
            DropdownMenuItem(value: type, child: Text(type.toUpperCase())));
      });
    } else {
      Constants.NEW_PART_SIZE.forEach((size) {
        items.add(
            DropdownMenuItem(value: size, child: Text(size.toUpperCase())));
      });
    }

    return items;
  }

  Widget _buildInputName(String text) {
    final controller = TextEditingController();
    controller.text = text;

    return InputForm(
      label: S.of(context).labelName,
      controller: controller,
      margin: EdgeInsets.only(top: 10),
      onSaved: (value) => _newPart?.name = value,
      validator: (value) {
        return (value.length >= 3 ? null : S.of(context).inputNameError);
      },
      maxLength: 50,
    );
  }

  Widget _buildNumericInput(BuildContext context, String label, String text,
      Function(String) onSaved) {
    final controller = TextEditingController();
    controller.text = text;

    return InputForm(
      label: label,
      controller: controller,
      margin: EdgeInsets.only(top: 10),
      onSaved: onSaved,
      validator: (value) {
        return (widget.newPartBloc.isValidNumber(value)
            ? null
            : S.of(context).invalidNumber);
      },
      maxLength: 10,
      keyboardType: TextInputType.number,
    );
  }

  void _saveNewPart() {
    if (!_formKey.currentState.validate()) return;
    final addedNewPartsModel =
        Provider.of<AddedNewPartsModel>(context, listen: false);

    _formKey.currentState.save();

    _newPart.programsId = widget.programId;
    _newPart.typesSizesId = Constants.NEW_PART_TYPES_SIZE[
        '${addedNewPartsModel.newPartType}-${addedNewPartsModel.newPartSize}'];
    _newPart.plannedLines = widget.newPartBloc.calculatePlanningLines(
        _newPart.typesSizesId, _newPart.numberMethodsPlanned);

    Provider.of<AddedNewPartsModel>(context, listen: false)
      ..addNewParts(_newPart)
      ..currentNewPart = NewPartModel();

    widget.newPartBloc.addedNewParts.add(_newPart);

    addedNewPartsModel.resetValues();

    clearInputs();
  }

  void clearInputs() {
    setState(() {});
  }
}
