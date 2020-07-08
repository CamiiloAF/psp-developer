import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/time_logs_bloc.dart';
import 'package:psp_developer/src/models/time_logs_model.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/providers/models/fab_model.dart';
import 'package:psp_developer/src/providers/models/time_log_pending_interruption.dart';
import 'package:psp_developer/src/shared_preferences/shared_preferences.dart';
import 'package:psp_developer/src/utils/constants.dart';
import 'package:psp_developer/src/utils/token_handler.dart';
import 'package:psp_developer/src/utils/utils.dart' as utils;
import 'package:psp_developer/src/widgets/buttons_widget.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/inputs_widget.dart';
import 'package:psp_developer/src/widgets/not_autorized_screen.dart';
import 'package:psp_developer/src/widgets/spinner_widget.dart';

class TimeLogEditPage extends StatefulWidget {
  final int programId;
  final TimeLogModel timeLog;

  TimeLogEditPage({@required this.programId, @required this.timeLog});

  @override
  _TimeLogEditPageState createState() =>
      _TimeLogEditPageState((timeLog == null) ? TimeLogModel() : timeLog);
}

class _TimeLogEditPageState extends State<TimeLogEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TimeLogsBloc _timeLogsBloc;
  final TimeLogModel _timeLogModel;

  final _inputDeltaTimeController = TextEditingController();
  final _inputInterruptionController = TextEditingController();

  int _currentPhaseId;

  int _deltaTime;

  bool isSubmiteButtonEnabled = true;

  _TimeLogEditPageState(this._timeLogModel);

  @override
  void initState() {
    _currentPhaseId = _timeLogModel?.phasesId ?? 1;
    _timeLogsBloc = context.read<BlocProvider>().timeLogsBloc;

    isSubmiteButtonEnabled = Preferences().pendingInterruptionStartAt == null;

    _inputInterruptionController.text = '${_timeLogModel?.interruption ?? 0}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!TokenHandler.existToken()) return NotAutorizedScreen();

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(title: S.of(context).appBarTitleTimeLogs),
      body: _createBody(),
    );
  }

  Widget _createBody() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildPhaseDropdownButton(),
              _buildInputStartDate(),
              _buildInputFinishDate(),
              _buildInputDeltaTime(),
              _buildInputInterruption(),
              _buildInputInterruptionStartAt(),
              _buildStartInterruptionButton(),
              _buildInputComments(),
              SubmitButton(
                  onPressed: (isSubmiteButtonEnabled) ? () => _submit() : null)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhaseDropdownButton() {
    return Spinner(
      label: S.of(context).labelPhase,
      items: _getDropDownMenuItems(),
      value: _currentPhaseId,
      onChanged: (value) {
        setState(() {
          _currentPhaseId = value;
        });
      },
    );
  }

  List<DropdownMenuItem<int>> _getDropDownMenuItems() {
    var items = <DropdownMenuItem<int>>[];
    Constants.PHASES.forEach((phase) {
      items.add(DropdownMenuItem(value: phase.id, child: Text(phase.name)));
    });

    return items;
  }

  Widget _buildInputStartDate() {
    return InputDate(
        initialValue: (_timeLogModel.startDate != null)
            ? DateTime.fromMillisecondsSinceEpoch(_timeLogModel.startDate)
            : null,
        isRequired: true,
        labelAndHint: S.of(context).labelStartDate,
        onChanged: (value) {
          _timeLogModel.startDate = value?.millisecondsSinceEpoch;
          _setDeltaTime();
        },
        onSaved: (DateTime value) =>
            _timeLogModel.startDate = value?.millisecondsSinceEpoch);
  }

  Widget _buildInputFinishDate() {
    return InputDate(
        initialValue: (_timeLogModel.finishDate != null)
            ? DateTime.fromMillisecondsSinceEpoch(_timeLogModel.finishDate)
            : null,
        labelAndHint: S.of(context).labelFinishDate,
        onChanged: (value) {
          _timeLogModel.finishDate = value?.millisecondsSinceEpoch;
          _setDeltaTime();
        },
        onSaved: (DateTime value) =>
            _timeLogModel.finishDate = value?.millisecondsSinceEpoch);
  }

  Widget _buildInputDeltaTime() {
    _setDeltaTime();
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: TextFormField(
          controller: _inputDeltaTimeController,
          decoration: InputDecoration(
              labelText: S.of(context).labelDeltaTime,
              helperText: S.of(context).helperTimeInMinutes),
          readOnly: true),
    );
  }

  Widget _buildInputInterruption() {
    return InputForm(
        controller: _inputInterruptionController,
        onSaved: (value) => (value == null || value.isEmpty)
            ? _timeLogModel.interruption = 0
            : _timeLogModel.interruption = int.tryParse(value),
        label: S.of(context).labelInterruption,
        isReadOnly: true);
  }

  Widget _buildInputInterruptionStartAt() {
    if (_timeLogModel.id == null) return Container();

    final pendingInterruptionStartAt = Preferences().pendingInterruptionStartAt;
    final timeLogIdWithPendingInterruption =
        Preferences().timeLogIdWithPendingInterruption;

    final initialValue = (pendingInterruptionStartAt != null &&
            timeLogIdWithPendingInterruption == _timeLogModel.id)
        ? Constants.format.format(
            DateTime.fromMillisecondsSinceEpoch(pendingInterruptionStartAt))
        : '';

    return Container(
      width: (initialValue.isEmpty) ? 0 : null,
      height: (initialValue.isEmpty) ? 0 : null,
      child: InputForm(
          initialValue: initialValue,
          onSaved: (value) {},
          label: S.of(context).labelInterruptionStartAt,
          isReadOnly: true),
    );
  }

  Widget _buildStartInterruptionButton() {
    if (_timeLogModel.id == null) return Container(height: 10);

    final pendingInterruptionStartAt = Preferences().pendingInterruptionStartAt;

    final buttonText = (pendingInterruptionStartAt == null)
        ? S.of(context).buttonStartInterruption
        : S.of(context).buttonStopInterruption;

    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          CustomRaisedButton(
              paddingHorizontal: 0,
              paddingVertical: 0,
              buttonText: buttonText,
              onPress: () {
                _onPressInterruptionButton(pendingInterruptionStartAt);
              }),
        ],
      ),
    );
  }

  void _onPressInterruptionButton(int pendingInterruptionStartAt) {
    setState(() {
      if (pendingInterruptionStartAt == null) {
        Preferences().pendingInterruptionStartAt =
            DateTime.now().millisecondsSinceEpoch;
        Preferences().timeLogIdWithPendingInterruption = _timeLogModel.id;

        isSubmiteButtonEnabled = false;
        Provider.of<FabModel>(context, listen: false).isShowing = false;
      } else {
        final currentInterruption = utils.getMinutesBetweenTwoDates(
            DateTime.fromMillisecondsSinceEpoch(pendingInterruptionStartAt),
            DateTime.now());

        final totalInterruption =
            currentInterruption + _timeLogModel.interruption;

        _inputInterruptionController.text = '$totalInterruption';

        Preferences().removePendingInterruptionAndTimeLogId();

        isSubmiteButtonEnabled = true;
        Provider.of<FabModel>(context, listen: false).isShowing = true;
      }
    });
    Provider.of<TimelogPendingInterruptionModel>(context, listen: false)
        .isListItemsEnable = Preferences().pendingInterruptionStartAt == null;
  }

  Widget _buildInputComments() {
    return InputMultiline(
      initialValue: _timeLogModel.comments,
      label: S.of(context).labelComments,
      onSaved: (value) =>
          _timeLogModel.comments = (value.isEmpty) ? null : value,
    );
  }

  void _setDeltaTime() async {
    final startDate = (_timeLogModel.startDate != null)
        ? DateTime.fromMillisecondsSinceEpoch(_timeLogModel.startDate)
        : null;

    final finishDate = (_timeLogModel.finishDate != null)
        ? DateTime.fromMillisecondsSinceEpoch(_timeLogModel.finishDate)
        : null;

    final timeInMinutes =
        utils.getMinutesBetweenTwoDates(startDate, finishDate);

    setState(() {
      _deltaTime = timeInMinutes;
      _inputDeltaTimeController.text =
          (_deltaTime != null) ? '$_deltaTime' : '';
    });
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

    if (!_isValidDeltaTime()) return;

    final progressDialog =
        utils.getProgressDialog(context, S.of(context).progressDialogSaving);

    await progressDialog.show();

    var statusCode = -1;

    _timeLogModel.deltaTime = _deltaTime?.toDouble();
    _timeLogModel.phasesId = _currentPhaseId;

    if (_timeLogModel.id == null) {
      _timeLogModel.programsId = widget.programId;
      statusCode = await _timeLogsBloc.insertTimeLog(_timeLogModel);
      await progressDialog.hide();
    } else {
      statusCode = await _timeLogsBloc.updateTimeLog(_timeLogModel);
      await progressDialog.hide();
    }

    Provider.of<FabModel>(context, listen: false).isShowing = true;

    if (statusCode == 201) {
      Navigator.pop(context);
    } else {
      await utils.showSnackBar(context, _scaffoldKey.currentState, statusCode);
    }
  }

  bool _isValidDeltaTime() {
    if (_deltaTime == null || _deltaTime >= 0) return true;

    utils.showSnackBarIncorrectDates(context, _scaffoldKey.currentState);
    return false;
  }
}
