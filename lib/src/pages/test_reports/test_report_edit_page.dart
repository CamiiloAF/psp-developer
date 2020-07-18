import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/test_reports_bloc.dart';
import 'package:psp_developer/src/models/test_reports_model.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/utils/token_handler.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:psp_developer/src/widgets/buttons_widget.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/inputs_widget.dart';
import 'package:psp_developer/src/widgets/not_authorized_screen.dart';

class TestReportEditPage extends StatefulWidget {
  final int programId;
  final TestReportModel testReport;

  TestReportEditPage({@required this.programId, @required this.testReport});

  @override
  _TestReportEditPageState createState() => _TestReportEditPageState(
      (testReport == null) ? TestReportModel() : testReport);
}

class _TestReportEditPageState extends State<TestReportEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TestReportsBloc _testReportsBloc;
  final TestReportModel _testReportModel;

  _TestReportEditPageState(this._testReportModel);

  String _inputNameError;
  int _inputNameCounter = 0;

  @override
  void initState() {
    _testReportsBloc = context.read<BlocProvider>().testReportsBloc;
    _inputNameCounter = _testReportModel.testName?.length ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!TokenHandler.existToken()) return NotAuthorizedScreen();

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(title: S.of(context).appBarTitleTestReports),
      body: _createBody(),
    );
  }

  Widget _createBody() {
    final isSubmiteButtonEnabled = (Provider.of<BlocProvider>(context)
        .programsBloc
        .hasCurrentProgramEnded());

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildInputTestNumber(),
              _buildInputTestName(),
              _buildInputTestConditions(),
              _buildInputExpectedResult(),
              _buildInputCurrentResult(),
              _buildInputTestDescription(),
              _buildInputObjective(),
              SubmitButton(
                  onPressed: (isSubmiteButtonEnabled) ? () => _submit() : null)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputTestNumber() {
    final s = S.of(context);

    return InputForm(
      onSaved: (value) => _testReportModel.testNumber = int.tryParse(value),
      label: s.labelTestNumber,
      maxLenght: 5,
      onChanged: (value) => _testReportsBloc.validateRequiredInput(s, value),
      initialValue: '${_testReportModel.testNumber ?? ''}',
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildInputTestName() {
    return InputName(
      initialValue: _testReportModel.testName,
      label: S.of(context).labelName,
      counter: _inputNameCounter.toString(),
      errorText: _inputNameError,
      onChanged: (value) {
        setState(() {});
        _inputNameCounter = value.length;
        if (value.trim().length < 3) {
          _inputNameError = S.of(context).inputNameError;
          return S.of(context).inputNameError;
        } else {
          _inputNameError = null;
          return null;
        }
      },
      onSaved: (value) => _testReportModel.testName = value,
    );
  }

  Widget _buildInputTestConditions() {
    final s = S.of(context);
    return InputMultiline(
        initialValue: _testReportModel.conditions,
        label: s.labelConditions,
        onChanged: (value) => _testReportsBloc.validateRequiredInput(s, value),
        onSaved: (value) => _testReportModel.conditions = value);
  }

  Widget _buildInputExpectedResult() {
    final s = S.of(context);
    return InputMultiline(
        initialValue: _testReportModel.expectedResult,
        label: S.of(context).labelExpectedResult,
        onChanged: (value) => _testReportsBloc.validateRequiredInput(s, value),
        onSaved: (value) => _testReportModel.expectedResult = value);
  }

  Widget _buildInputCurrentResult() {
    return InputMultiline(
        initialValue: _testReportModel.currentResult,
        label: S.of(context).labelCurrentResult,
        onSaved: (value) =>
            _testReportModel.currentResult = (value.isNotEmpty) ? value : null);
  }

  Widget _buildInputTestDescription() {
    return InputMultiline(
        initialValue: _testReportModel.description,
        label: S.of(context).labelDescription,
        onSaved: (value) =>
            _testReportModel.description = (value.isNotEmpty) ? value : null);
  }

  Widget _buildInputObjective() {
    final s = S.of(context);
    return InputMultiline(
        initialValue: _testReportModel.objective,
        label: s.labelObjective,
        onChanged: (value) =>
            _testReportsBloc.validateRequiredInput(s, value),
        onSaved: (value) =>
            _testReportModel.objective = (value.isNotEmpty) ? value : null);
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

    if (!_testReportsBloc.isUniqueTestNumber(_testReportModel.testNumber)) {
      _showSnackbarAlreadyExistTestNumber();
      return;
    }

    final progressDialog =
        getProgressDialog(context, S.of(context).progressDialogSaving);

    await progressDialog.show();

    var statusCode = -1;

    if (_testReportModel.id == null) {
      _testReportModel.programsId = widget.programId;
      statusCode = await _testReportsBloc.insertTestReport(_testReportModel);
    } else {
      statusCode = await _testReportsBloc.updateTestReport(_testReportModel);
    }
    await progressDialog.hide();

    if (statusCode == 201) {
      Navigator.pop(context);
    } else {
      await showSnackBar(context, _scaffoldKey.currentState, statusCode);
    }
  }

  void _showSnackbarAlreadyExistTestNumber() {
    final snackbar = buildSnackbar(
        Text(S.of(context).messageAlreadyExistTestNumber),
        durationInMilliseconds: 3000);

    _scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
