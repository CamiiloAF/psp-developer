import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/defect_logs_bloc.dart';
import 'package:psp_developer/src/models/defect_logs_model.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/utils/constants.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:psp_developer/src/widgets/buttons_widget.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/inputs_widget.dart';
import 'package:psp_developer/src/widgets/spinner_widget.dart';

class DefectLogEditPage extends StatefulWidget {
  final int programId;
  final DefectLogModel defectLog;

  DefectLogEditPage({@required this.programId, @required this.defectLog});

  @override
  _DefectLogEditPageState createState() => _DefectLogEditPageState(
      (defectLog == null) ? DefectLogModel() : defectLog);
}

class _DefectLogEditPageState extends State<DefectLogEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  DefectLogsBloc _defectLogsBloc;
  final DefectLogModel _defectLogModel;

  int _currentChainedDefectId;
  int _currentStandardDefectId;
  int _currentAddedPhaseId;
  int _currentRemovedPhaseId;

  String _inputDescriptionError;

  final _inputTimeForRepairController = TextEditingController();

  _DefectLogEditPageState(this._defectLogModel);

  @override
  void initState() {
    _currentChainedDefectId = _defectLogModel?.defectLogChainedId ?? -1;
    _currentStandardDefectId = _defectLogModel?.standardDefectsId ?? 1;
    _currentAddedPhaseId = _defectLogModel?.phaseAddedId ?? 1;
    _currentRemovedPhaseId = _defectLogModel?.phaseRemovedId ?? -1;

    _defectLogsBloc = context.read<BlocProvider>().defectLogsBloc;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(title: S.of(context).appBarTitleDefectLogs),
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
              _buildChainedDefectLogDropdownButton(),
              _buildStandardDefectDropdownButton(),
              _buildPhaseDropdownButton(true),
              _buildPhaseDropdownButton(false),
              _buildInputDescription(),
              _buildInputSolution(),
              _buildInputStartDate(),
              _buildInputFinishDate(),
              _buildInputTimeForRepair(),
              SubmitButton(onPressed: () => _submit())
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChainedDefectLogDropdownButton() {
    return Spinner(
      label: S.of(context).labelChainedDefectLog,
      items: getChainedDefectDropDownMenuItems(),
      value: _currentChainedDefectId,
      onChanged: (value) {
        setState(() {
          _currentChainedDefectId = value;
        });
      },
    );
  }

  List<DropdownMenuItem<int>> getChainedDefectDropDownMenuItems() {
    final items = <DropdownMenuItem<int>>[
      DropdownMenuItem(value: -1, child: Text(S.of(context).labelNone))
    ];
    _defectLogsBloc?.lastValueDefectLogsController?.item2?.forEach((defectLog) {
      if (_defectLogModel != null && defectLog.id != _defectLogModel.id) {
        items.add(DropdownMenuItem(
            value: defectLog.id, child: Text('${defectLog.id}')));
      }
    });

    return items;
  }

  Widget _buildStandardDefectDropdownButton() {
    return Spinner(
      label: S.of(context).labelStandardDefect,
      items: getStandardDefectDropDownMenuItems(),
      value: _currentStandardDefectId,
      onChanged: (value) {
        setState(() {
          _currentStandardDefectId = value;
        });
      },
    );
  }

  List<DropdownMenuItem<int>> getStandardDefectDropDownMenuItems() {
    final items = <DropdownMenuItem<int>>[];

    Constants.STANDARD_DEFECTS.forEach((standardDefect) {
      items.add(DropdownMenuItem(
          value: standardDefect.id, child: Text(standardDefect.name)));
    });

    return items;
  }

  Widget _buildPhaseDropdownButton(bool isPhaseAdded) {
    final label = (isPhaseAdded)
        ? S.of(context).labelPhaseAdded
        : S.of(context).labelPhaseRemoved;

    final value =
        (isPhaseAdded) ? _currentAddedPhaseId : _currentRemovedPhaseId;

    return Spinner(
      label: label,
      items: getPhaseDropDownMenuItems(isPhaseAdded),
      value: value,
      onChanged: (value) {
        setState(() {
          (isPhaseAdded)
              ? _currentAddedPhaseId = value
              : _currentRemovedPhaseId = value;
        });
      },
    );
  }

  List<DropdownMenuItem<int>> getPhaseDropDownMenuItems(bool isPhaseAdded) {
    final items = <DropdownMenuItem<int>>[];
    if (!isPhaseAdded) {
      items.add(
          DropdownMenuItem(value: -1, child: Text(S.of(context).labelNone)));
    }

    Constants.PHASES.forEach((phase) {
      items.add(DropdownMenuItem(value: phase.id, child: Text(phase.name)));
    });

    return items;
  }

  Widget _buildInputDescription() {
    return InputMultiline(
      initialValue: _defectLogModel.description,
      label: S.of(context).labelDescription,
      errorText: _inputDescriptionError,
      onChanged: (value) {
        setState(() {});
        if (value.trim().isEmpty) {
          _inputDescriptionError = S.of(context).inputRequiredError;
          return S.of(context).inputRequiredError;
        } else {
          _inputDescriptionError = null;
          return null;
        }
      },
      onSaved: (value) => _defectLogModel.description = value,
    );
  }

  Widget _buildInputSolution() {
    return InputMultiline(
      initialValue: _defectLogModel.solution,
      label: S.of(context).labelSolution,
      onSaved: (value) =>
          _defectLogModel.solution = (value.isEmpty) ? null : value,
    );
  }

  Widget _buildInputStartDate() {
    return InputDate(
        initialValue: (_defectLogModel.startDate != null)
            ? DateTime.fromMillisecondsSinceEpoch(_defectLogModel.startDate)
            : null,
        isRequired: true,
        labelAndHint: S.of(context).labelStartDate,
        onChanged: (value) {
          _defectLogModel.startDate = value?.millisecondsSinceEpoch;
          setTimeForRepair();
        },
        onSaved: (DateTime value) =>
            _defectLogModel.startDate = value?.millisecondsSinceEpoch);
  }

  Widget _buildInputFinishDate() {
    return InputDate(
        initialValue: (_defectLogModel.finishDate != null)
            ? DateTime.fromMillisecondsSinceEpoch(_defectLogModel.finishDate)
            : null,
        labelAndHint: S.of(context).labelFinishDate,
        onChanged: (value) {
          _defectLogModel.finishDate = value?.millisecondsSinceEpoch;
          setTimeForRepair();
        },
        onSaved: (DateTime value) =>
            _defectLogModel.finishDate = value?.millisecondsSinceEpoch);
  }

  Widget _buildInputTimeForRepair() {
    setTimeForRepair();
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: TextFormField(
          controller: _inputTimeForRepairController,
          decoration: InputDecoration(
              labelText: S.of(context).labelTimeForRepair,
              helperText: S.of(context).helperTimeInMinutes),
          readOnly: true),
    );
  }

  void setTimeForRepair() async {
    final startDate = (_defectLogModel.startDate != null)
        ? DateTime.fromMillisecondsSinceEpoch(_defectLogModel.startDate)
        : null;

    final finishDate = (_defectLogModel.finishDate != null)
        ? DateTime.fromMillisecondsSinceEpoch(_defectLogModel.finishDate)
        : null;

    final timeInMinutes = getMinutesBetweenTwoDates(startDate, finishDate);

    setState(() {
      _defectLogModel.timeForRepair = timeInMinutes;

      _inputTimeForRepairController.text =
          (timeInMinutes != null) ? '$timeInMinutes' : '';
    });
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();
    final progressDialog =
        getProgressDialog(context, S.of(context).progressDialogSaving);

    await progressDialog.show();

    var statusCode = -1;

    _defectLogModel.defectLogChainedId =
        (_currentChainedDefectId != -1) ? _currentChainedDefectId : null;

    _defectLogModel.standardDefectsId = _currentStandardDefectId;
    _defectLogModel.phaseAddedId = _currentAddedPhaseId;

    _defectLogModel.phaseRemovedId =
        (_currentRemovedPhaseId != -1) ? _currentRemovedPhaseId : null;

    if (_defectLogModel.id == null) {
      _defectLogModel.programsId = widget.programId;
      statusCode = await _defectLogsBloc.insertDefectLog(_defectLogModel);
      await progressDialog.hide();
    } else {
      statusCode = await _defectLogsBloc.updateDefectLog(_defectLogModel);
      await progressDialog.hide();
    }

    if (statusCode == 201) {
      Navigator.pop(context);
    } else {
      await showSnackBar(context, _scaffoldKey.currentState, statusCode);
    }
  }
}
