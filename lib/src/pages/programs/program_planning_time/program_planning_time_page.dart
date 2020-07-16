import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/programs_bloc.dart';
import 'package:psp_developer/src/models/planning_time_model.dart';
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

class ProgramPlanningTimePage extends StatefulWidget {
  static const ROUTE_NAME = 'planning-time';

  @override
  _ProgramPlanningTimePageState createState() =>
      _ProgramPlanningTimePageState();
}

class _ProgramPlanningTimePageState extends State<ProgramPlanningTimePage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ProgramsBloc _programBloc;

  ProgramModel _currentProgram;

  final _timePlanningInPhases = TimePlanningInPhases();

  @override
  Widget build(BuildContext context) {
    if (!TokenHandler.existToken()) return NotAuthorizedScreen();

    _programBloc = Provider.of<BlocProvider>(context).programsBloc;

    _currentProgram = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(title: S.of(context).appBarTitlePlanningTime),
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

              _buildNumericInput(
                  phases[0].name,
                  null,
                  (value) => _timePlanningInPhases.planningTimeInPlan =
                      int.tryParse(value)),
              _buildNumericInput(
                  phases[1].name,
                  null,
                  (value) => _timePlanningInPhases.planningTimeInDld =
                      int.tryParse(value)),
              _buildNumericInput(
                  phases[2].name,
                  null,
                  (value) => _timePlanningInPhases.planningTimeInCode =
                      int.tryParse(value)),
              _buildNumericInput(
                  phases[3].name,
                  null,
                  (value) => _timePlanningInPhases.planningTimeInCompile =
                      int.tryParse(value)),
              _buildNumericInput(
                  phases[4].name,
                  null,
                  (value) => _timePlanningInPhases.planningTimeInUt =
                      int.tryParse(value)),
              _buildNumericInput(
                  phases[5].name,
                  null,
                  (value) => _timePlanningInPhases.planningTimeInPm =
                      int.tryParse(value)),
              SubmitButton(onPressed: _submit)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumericInput(
      String phase, String initialValue, Function(String value) onSaved) {
    return CustomInput(
      initialValue: initialValue,
      label: S.of(context).labelWithPlaceHolderEstimatedTimeIn(phase),
      helperText: S.of(context).helperTimeInMinutes,
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

    final planningTimes = _buildPlanningTimes();

    return ProgramPartsModel(
      planningTimes: planningTimes,
      baseParts: baseParts,
      reusableParts: reusableParts,
      newParts: newParts,
    );
  }

  List<PlanningTimeModel> _buildPlanningTimes() {
    return [
      _planningTimeLogBuilder(1, _timePlanningInPhases.planningTimeInPlan),
      _planningTimeLogBuilder(2, _timePlanningInPhases.planningTimeInDld),
      _planningTimeLogBuilder(3, _timePlanningInPhases.planningTimeInCode),
      _planningTimeLogBuilder(4, _timePlanningInPhases.planningTimeInCompile),
      _planningTimeLogBuilder(5, _timePlanningInPhases.planningTimeInUt),
      _planningTimeLogBuilder(6, _timePlanningInPhases.planningTimeInPm),
    ];
  }

  PlanningTimeModel _planningTimeLogBuilder(int phaseId, int planningTime) =>
      PlanningTimeModel(
          phasesId: phaseId,
          planningTime: planningTime,
          programsId: _currentProgram.id);
}
