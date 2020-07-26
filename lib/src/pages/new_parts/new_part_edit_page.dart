import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/new_parts_bloc.dart';
import 'package:psp_developer/src/models/new_parts_model.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/utils/constants.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:psp_developer/src/widgets/buttons_widget.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/inputs_widget.dart';
import 'package:psp_developer/src/widgets/spinner_widget.dart';

class NewPartEditPage extends StatefulWidget {
  static const ROUTE_NAME = 'new-part-edit';

  @override
  _NewPartEditPageState createState() => _NewPartEditPageState();
}

class _NewPartEditPageState extends State<NewPartEditPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  NewPartModel _newPart;

  @override
  void didChangeDependencies() {
    _newPart = ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(title: S.of(context).appBarTitleNewParts),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: _Form(newPart: _newPart, scaffoldKey: _scaffoldKey),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final NewPartModel newPart;

  _Form({this.newPart, this.scaffoldKey});

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();

  NewPartsBloc _newPartsBloc;

  @override
  void initState() {
    _newPartsBloc = context.read<BlocProvider>().newPartsBloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isSubmitButtonEnabled = !(Provider.of<BlocProvider>(context)
        .programsBloc
        .hasCurrentProgramEnded());

    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 10),
            _buildSizeTypeDropdownButton(true),
            _buildSizeTypeDropdownButton(false),
            _buildInputName(
              '${widget.newPart?.name ?? ''}',
            ),
            SizedBox(height: 10),

            _buildPlannedInputs(),
            _buildCurrentInputs(),
            SubmitButton(
                onPressed: (isSubmitButtonEnabled) ? () => _submit() : null)
          ],
        ));
  }

  Widget _buildSizeTypeDropdownButton(bool isForType) {
    final typeSize = getNewPartTypeSize();

    return Spinner(
      label: (isForType) ? S.of(context).labelType : S.of(context).labelSize,
      items: _getDropDownMenuItems(isForType, typeSize),
      value: (isForType) ? typeSize[0] : typeSize[1],
      onChanged: (value) {},
    );
  }

  List<String> getNewPartTypeSize() {
    List<String> typeSize;

    Constants.NEW_PART_TYPES_SIZE.forEach((key, value) {
      if (value == widget.newPart.typesSizesId) {
        typeSize = key.split('-');
      }
    });

    return typeSize;
  }

  List<DropdownMenuItem<String>> _getDropDownMenuItems(
      bool isForType, List<String> typeSize) {
    final items = <DropdownMenuItem<String>>[];

    if (isForType) {
      final type = typeSize[0];
      items.add(DropdownMenuItem(value: type, child: Text(type.toUpperCase())));
    } else {
      final size = typeSize[1];
      items.add(DropdownMenuItem(value: size, child: Text(size.toUpperCase())));
    }

    return items;
  }

  Widget _buildInputName(String initialValue) {
    return InputForm(
      label: S.of(context).labelName,
      initialValue: initialValue,
      isReadOnly: true,
      margin: EdgeInsets.only(top: 10),
    );
  }

  Widget _buildPlannedInputs() {
    final s = S.of(context);
    return Column(
      children: [
        _buildNumericInput(s.labelPlannedLinesBase,
            '${widget.newPart?.plannedLines ?? ''}', null,
            isReadOnly: true),
        _buildNumericInput(s.labelMethodsPlanned,
            '${widget.newPart?.numberMethodsPlanned ?? ''}', null,
            isReadOnly: true),
      ],
    );
  }

  Widget _buildCurrentInputs() {
    final s = S.of(context);

    return Column(
      children: [
        _buildNumericInput(
          s.labelCurrentLinesBase,
          '${widget.newPart?.currentLines ?? ''}',
          (value) => widget.newPart?.currentLines = int.tryParse(value),
        ),
        _buildNumericInput(
          s.labelMethodsCurrent,
          '${widget.newPart?.numberMethodsCurrent ?? ''}',
          (value) => widget.newPart?.numberMethodsCurrent = int.tryParse(value),
        ),
      ],
    );
  }

  Widget _buildNumericInput(
      String label, String initialValue, Function(String) onSaved,
      {bool isReadOnly = false}) {
    return InputForm(
      label: label,
      initialValue: initialValue,
      margin: EdgeInsets.only(top: 10),
      isReadOnly: isReadOnly,
      onSaved: onSaved,
      validator: (onSaved!=null)? (String value) =>
          (!_newPartsBloc.isValidNumber(value)) ? S.of(context).invalidNumber : null : null,
      maxLength: 10,
      keyboardType: TextInputType.number,
    );
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

    final progressDialog =
        getProgressDialog(context, S.of(context).progressDialogSaving);

    await progressDialog.show();

    final statusCode = await _newPartsBloc.updateNewPart(widget.newPart);

    await showSnackBar(context, widget.scaffoldKey.currentState, statusCode);
    await progressDialog.hide();
  }
}
