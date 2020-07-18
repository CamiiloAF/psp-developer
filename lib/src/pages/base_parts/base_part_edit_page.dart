import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/base_parts_bloc.dart';
import 'package:psp_developer/src/models/base_parts_model.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:psp_developer/src/widgets/buttons_widget.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/inputs_widget.dart';
import 'package:psp_developer/src/widgets/spinner_widget.dart';
import 'package:tuple/tuple.dart';

class BasePartEditPage extends StatefulWidget {
  static const ROUTE_NAME = 'base-part-edit';

  @override
  _BasePartEditPageState createState() => _BasePartEditPageState();
}

class _BasePartEditPageState extends State<BasePartEditPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  BasePartModel _basePart;

  @override
  void didChangeDependencies() {
    _basePart = ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(title: S.of(context).appBarTitleBaseParts),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: _Form(_basePart, _scaffoldKey),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  final BasePartModel basePart;
  final GlobalKey<ScaffoldState> scaffoldKey;

  _Form(this.basePart, this.scaffoldKey);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();

  BasePartsBloc _basePartBloc;
  List<Tuple2<int, String>> programsTuple;

  @override
  void initState() {
    _basePartBloc = context.read<BlocProvider>().basePartsBloc;

    programsTuple = context
        .read<BlocProvider>()
        .programsBloc
        .lastValueProgramsByOrganizationController
        ?.item2;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isSubmiteButtonEnabled = (Provider.of<BlocProvider>(context)
        .programsBloc
        .hasCurrentProgramEnded());

    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 10),
            _buildBaseProgramDropdownButton(),
            _buildInputsForPlannedLines(),
            _buildInputsForCurrentLines(),
            SubmitButton(
                onPressed: (isSubmiteButtonEnabled) ? () => _submit() : null)
          ],
        ));
  }

  Widget _buildInputsForPlannedLines() {
    final s = S.of(context);
    return Column(
      children: [
        _builNumericInput(
            s.labelPlannedLinesBase,
            '${widget.basePart?.plannedLinesBase ?? ''}',
            (value) => widget.basePart?.plannedLinesBase = int.tryParse(value),
            isReadOnly: true),
        _builNumericInput(
            s.labelPlannedLinesDeleted,
            '${widget.basePart?.plannedLinesDeleted ?? ''}',
            (value) =>
                widget.basePart?.plannedLinesDeleted = int.tryParse(value),
            isReadOnly: true),
        _builNumericInput(
            s.labelPlannedLinesEdits,
            '${widget.basePart?.plannedLinesEdits ?? ''}',
            (value) => widget.basePart?.plannedLinesEdits = int.tryParse(value),
            isReadOnly: true),
        _builNumericInput(
            s.labelPlannedLinesAdded,
            '${widget.basePart?.plannedLinesAdded ?? ''}',
            (value) => widget.basePart?.plannedLinesAdded = int.tryParse(value),
            isReadOnly: true),
      ],
    );
  }

  Widget _buildInputsForCurrentLines() {
    final s = S.of(context);
    return Column(
      children: [
        _builNumericInput(
          s.labelCurrentLinesBase,
          '${widget.basePart?.currentLinesBase ?? ''}',
          (value) => widget.basePart?.currentLinesBase = int.tryParse(value),
        ),
        _builNumericInput(
          s.labelCurrentLinesDeleted,
          '${widget.basePart?.currentLinesDeleted ?? ''}',
          (value) => widget.basePart?.currentLinesDeleted = int.tryParse(value),
        ),
        _builNumericInput(
          s.labelCurrentLinesEdits,
          '${widget.basePart?.currentLinesEdits ?? ''}',
          (value) => widget.basePart?.currentLinesEdits = int.tryParse(value),
        ),
        _builNumericInput(
          s.labelCurrentLinesAdded,
          '${widget.basePart?.currentLinesAdded ?? ''}',
          (value) => widget.basePart?.currentLinesAdded = int.tryParse(value),
        ),
      ],
    );
  }

  Widget _buildBaseProgramDropdownButton() {
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
        (element) => element.item1 == widget.basePart.programsBaseId);

    return programTuple.item2;
  }

  Widget _builNumericInput(String label, String text, Function(String) onSaved,
      {isReadOnly = false}) {
    final controller = TextEditingController();
    controller.text = text;

    return InputForm(
      label: label,
      controller: controller,
      margin: EdgeInsets.only(top: 10),
      isReadOnly: isReadOnly,
      onSaved: onSaved,
      validator: (value) {
        return (_basePartBloc.isValidNumber(value)
            ? null
            : S.of(context).invalidNumber);
      },
      maxLenght: 10,
      keyboardType: TextInputType.number,
    );
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

    final progressDialog =
        getProgressDialog(context, S.of(context).progressDialogSaving);

    await progressDialog.show();

    final statusCode = await _basePartBloc.updateBasePart(widget.basePart);

    await showSnackBar(context, widget.scaffoldKey.currentState, statusCode);
    await progressDialog.hide();
  }
}
