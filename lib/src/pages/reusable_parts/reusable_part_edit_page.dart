import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/reusable_parts_bloc.dart';
import 'package:psp_developer/src/models/reusable_parts_model.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:psp_developer/src/widgets/buttons_widget.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/inputs_widget.dart';
import 'package:psp_developer/src/widgets/spinner_widget.dart';
import 'package:tuple/tuple.dart';

class ReusablePartEditPage extends StatefulWidget {
  static const ROUTE_NAME = 'reusable-parts-edit';

  @override
  _ReusablePartEditPageState createState() => _ReusablePartEditPageState();
}

class _ReusablePartEditPageState extends State<ReusablePartEditPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ReusablePartModel _reusablePart;

  @override
  void didChangeDependencies() {
    _reusablePart = ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(title: S.of(context).appBarTitleReusableParts),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: _Form(_reusablePart, _scaffoldKey),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  final ReusablePartModel reusablePart;
  final GlobalKey<ScaffoldState> scaffoldKey;

  _Form(this.reusablePart, this.scaffoldKey);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();

  ReusablePartsBloc _reusablePartsBloc;
  List<Tuple2<int, String>> programsTuple;

  @override
  void initState() {
    _reusablePartsBloc = context.read<BlocProvider>().reusablePartsBloc;

    programsTuple = context
        .read<BlocProvider>()
        .programsBloc
        .lastValueProgramsByOrganizationController
        ?.item2;

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
            _buildReusableProgramDropdownButton(),
            _buildNumericInput(S.of(context).labelPlannedLinesBase,
                '${widget.reusablePart?.plannedLines ?? ''}', null,
                isReadOnly: true),
            _buildNumericInput(
              S.of(context).labelCurrentLinesBase,
              '${widget.reusablePart?.currentLines ?? ''}',
              (value) =>
                  widget.reusablePart?.currentLines = int.tryParse(value),
            ),
            SubmitButton(
                onPressed: (isSubmitButtonEnabled) ? () => _submit() : null)
          ],
        ));
  }

  Widget _buildReusableProgramDropdownButton() {
    final programBaseName = getProgramNameById();

    return Spinner(
      label: S.of(context).labelBaseProgram,
      items: [
        DropdownMenuItem(value: programBaseName, child: Text(programBaseName))
      ],
      value: programBaseName,
      onChanged: (value) {},
    );
  }

  String getProgramNameById() {
    final programTuple = programsTuple.firstWhere(
        (element) => element.item1 == widget.reusablePart.programsReusablesId);

    return programTuple.item2;
  }

  Widget _buildNumericInput(
      String label, String initialValue, Function(String) onSaved,
      {bool isReadOnly = false}) {
    return InputForm(
      label: label,
      initialValue: initialValue,
      isReadOnly: isReadOnly,
      margin: EdgeInsets.only(top: 10),
      onSaved: onSaved,
      validator: (value) {
        return (_reusablePartsBloc.isValidNumber(value)
            ? null
            : S.of(context).invalidNumber);
      },
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

    final statusCode =
        await _reusablePartsBloc.updateReusablePart(widget.reusablePart);

    await showSnackBar(context, widget.scaffoldKey.currentState, statusCode);
    await progressDialog.hide();
  }
}
