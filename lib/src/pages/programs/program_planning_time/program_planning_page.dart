import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/programs_bloc.dart';
import 'package:psp_developer/src/models/planning/planning_model.dart';
import 'package:psp_developer/src/models/planning/planning_per_phase_model.dart';
import 'package:psp_developer/src/models/program_parts_model.dart';
import 'package:psp_developer/src/models/programs_model.dart';
import 'package:psp_developer/src/pages/time_logs/time_logs_page.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/utils/constants.dart';
import 'package:psp_developer/src/utils/token_handler.dart';
import 'package:psp_developer/src/utils/utils.dart' as utils;
import 'package:psp_developer/src/widgets/buttons_widget.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/inputs_widget.dart';
import 'package:psp_developer/src/widgets/not_authorized_screen.dart';

import '../programs_page.dart';

class ProgramPlanningPage extends StatefulWidget {
  static const ROUTE_NAME = 'planning';

  @override
  _ProgramPlanningPageState createState() => _ProgramPlanningPageState();
}

class _ProgramPlanningPageState extends State<ProgramPlanningPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ProgramsBloc _programBloc;

  ProgramModel _currentProgram;

  final _planningPerPhases = PlanningPerPhaseModel();

  @override
  Widget build(BuildContext context) {
    if (!TokenHandler.existToken()) return NotAuthorizedScreen();

    _programBloc = Provider.of<BlocProvider>(context).programsBloc;

    _currentProgram = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(title: S.of(context).appBarTitlePlanning),
      body: _createBody(),
    );
  }

  Widget _createBody() {
    final phases = Constants.PHASES;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildPlanInputs(),
              _buildDldInputs(),
              _buildCodeInputs(),
              _buildCompileInputs(),
              _buildUtInputs(),
              _buildPmInputs(),
              SubmitButton(onPressed: _submit)
            ],
          ),
        ),
      ),
    );
  }

  Column _buildPlanInputs() {
    final phaseName = Constants.PHASES[0].name;
    return Column(
      children: [
        _buildEstimatedTimeInput(
            phaseName,
            (value) =>
                _planningPerPhases.planningTimeInPlan = int.tryParse(value)),
        _buildEstimatedDefectsInput(
          phaseName,
          (value) =>
              _planningPerPhases.planningDefectsInPlan = int.tryParse(value),
        ),
      ],
    );
  }

  Column _buildDldInputs() {
    final phaseName = Constants.PHASES[1].name;
    return Column(
      children: [
        _buildEstimatedTimeInput(
            phaseName,
            (value) =>
                _planningPerPhases.planningTimeInDld = int.tryParse(value)),
        _buildEstimatedDefectsInput(
          phaseName,
          (value) =>
              _planningPerPhases.planningDefectsInDld = int.tryParse(value),
        ),
      ],
    );
  }

  Column _buildCodeInputs() {
    final phaseName = Constants.PHASES[2].name;
    return Column(
      children: [
        _buildEstimatedTimeInput(
            phaseName,
            (value) =>
                _planningPerPhases.planningTimeInCode = int.tryParse(value)),
        _buildEstimatedDefectsInput(
          phaseName,
          (value) =>
              _planningPerPhases.planningDefectsInCode = int.tryParse(value),
        ),
      ],
    );
  }

  Column _buildCompileInputs() {
    final phaseName = Constants.PHASES[3].name;
    return Column(
      children: [
        _buildEstimatedTimeInput(
            phaseName,
            (value) =>
                _planningPerPhases.planningTimeInCompile = int.tryParse(value)),
        _buildEstimatedDefectsInput(
          phaseName,
          (value) =>
              _planningPerPhases.planningDefectsInCompile = int.tryParse(value),
        ),
      ],
    );
  }

  Column _buildUtInputs() {
    final phaseName = Constants.PHASES[4].name;
    return Column(
      children: [
        _buildEstimatedTimeInput(
            phaseName,
            (value) =>
                _planningPerPhases.planningTimeInUt = int.tryParse(value)),
        _buildEstimatedDefectsInput(
          phaseName,
          (value) =>
              _planningPerPhases.planningDefectsInUt = int.tryParse(value),
        ),
      ],
    );
  }

  Column _buildPmInputs() {
    final phaseName = Constants.PHASES[5].name;
    return Column(
      children: [
        _buildEstimatedTimeInput(
            phaseName,
            (value) =>
                _planningPerPhases.planningTimeInPm = int.tryParse(value)),
        _buildEstimatedDefectsInput(
          phaseName,
          (value) =>
              _planningPerPhases.planningDefectsInPm = int.tryParse(value),
        ),
      ],
    );
  }

  Widget _buildEstimatedTimeInput(
      String phase, Function(String value) onSaved) {
    return _buildNumericInput(phase, onSaved,
        S.of(context).labelWithPlaceHolderEstimatedTimeIn(phase));
  }

  Widget _buildEstimatedDefectsInput(
      String phase, Function(String value) onSaved) {
    return _buildNumericInput(phase, onSaved,
        S.of(context).labelWithPlaceHolderEstimatedDefectsIn(phase),
        putHelper: false);
  }

  Widget _buildNumericInput(
      String phase, Function(String value) onSaved, String label,
      {bool putHelper = true}) {
    return CustomInput(
      label: label,
      helperText: (putHelper) ? S.of(context).helperTimeInMinutes : null,
      errorText: S.of(context).invalidNumber,
      keyboardType: TextInputType.number,
      onSaved: onSaved,
      onChanged: _onChangeNumericInput,
      validator: _inputNumericValidator,
    );
  }

  bool _onChangeNumericInput(String value) =>
      !_programBloc.isValidNumber(value);

  String _inputNumericValidator(String value) =>
      (_programBloc.isValidNumber(value)) ? null : S.of(context).invalidNumber;

  void _submit() async {
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

    final progressDialog =
        utils.getProgressDialog(context, S.of(context).progressDialogSaving);

    await progressDialog.show();

    var statusCode = -1;

    final blocProvider = Provider.of<BlocProvider>(context, listen: false);

    final programPartsModel = _buildProgramParts(context);

    statusCode = await blocProvider.programsBloc
        .updateProgramWithProgramParts(_currentProgram, programPartsModel);

    await progressDialog.hide();

    if (statusCode == 204) {
      await Navigator.pushNamedAndRemoveUntil(context, TimeLogsPage.ROUTE_NAME,
          (route) => route.settings.name == ProgramsPage.ROUTE_NAME,
          arguments: _currentProgram.id);
    } else {
      await utils.showSnackBar(context, _scaffoldKey.currentState, statusCode);
    }
  }

  ProgramPartsModel _buildProgramParts(BuildContext context) {
    final blocProvider = Provider.of<BlocProvider>(context, listen: false);

    final baseParts = blocProvider.basePartsBloc.addedBaseParts;
    final reusableParts = blocProvider.reusablePartsBloc.addedReusableParts;
    final newParts = blocProvider.newPartsBloc.addedNewParts;

    final planning = _buildPlanningModels();

    return ProgramPartsModel(
      baseParts: baseParts,
      reusableParts: reusableParts,
      newParts: newParts,
      planning: planning
    );
  }

  List<PlanningModel> _buildPlanningModels() {
    return [
      _planningBuilder(1, _planningPerPhases.planningTimeInPlan,
          _planningPerPhases.planningDefectsInPlan),
      _planningBuilder(2, _planningPerPhases.planningTimeInDld,
          _planningPerPhases.planningDefectsInDld),
      _planningBuilder(3, _planningPerPhases.planningTimeInCode,
          _planningPerPhases.planningDefectsInCode),
      _planningBuilder(4, _planningPerPhases.planningTimeInCompile,
          _planningPerPhases.planningDefectsInCompile),
      _planningBuilder(5, _planningPerPhases.planningTimeInUt,
          _planningPerPhases.planningDefectsInUt),
      _planningBuilder(6, _planningPerPhases.planningTimeInPm,
          _planningPerPhases.planningDefectsInPm),
    ];
  }

  PlanningModel _planningBuilder(
          int phaseId, int planningTime, int planningDefect) =>
      PlanningModel(
          phasesId: phaseId,
          planningTime: planningTime,
          planningDefect: planningDefect,
          programsId: _currentProgram.id);
}
