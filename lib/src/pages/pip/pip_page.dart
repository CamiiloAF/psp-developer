import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/pip_bloc.dart';
import 'package:psp_developer/src/models/pip_model.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:psp_developer/src/widgets/buttons_widget.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/inputs_widget.dart';
import 'package:tuple/tuple.dart';

class PIPPage extends StatefulWidget {
  final int programId;

  const PIPPage({this.programId});

  @override
  _PIPPageState createState() => _PIPPageState();
}

class _PIPPageState extends State<PIPPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  PIPBloc _pipBloc;
  PIPModel _pip;

  @override
  void initState() {
    super.initState();
    _pipBloc = context.read<BlocProvider>().pipBloc;
    _pipBloc.getPIP(false, widget.programId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(title: S.of(context).appBarTitleTestReports),
      body: _createBody(),
    );
  }

  Widget _createBody() {
    return StreamBuilder(
      stream: _pipBloc.pipStream,
      builder: (BuildContext context,
          AsyncSnapshot<Tuple2<int, PIPModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        _pip = snapshot.data.item2 ?? PIPModel();

        final statusCode = snapshot.data.item1;

        if (statusCode != 200) {
          showSnackBar(context, _scaffoldKey.currentState, statusCode);
        }

        return RefreshIndicator(
          onRefresh: () => _refreshPip(),
          child: _body(),
        );
      },
    );
  }

  SingleChildScrollView _body() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildInputPipDescription(),
              _buildInputPipProposals(),
              _buildInputPipComments(),
              _buildInputPipDate(),
              SubmitButton(onPressed: () => _submit())
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputPipDescription() {
    return InputMultiline(
        initialValue: _pip.description,
        label: S.of(context).labelDescription,
        onChanged: (value) => _pipBloc.validateRequiredInput(context, value),
        onSaved: (value) => _pip.description = value);
  }

  Widget _buildInputPipProposals() {
    return InputMultiline(
        initialValue: _pip.proposals,
        label: S.of(context).labelProposals,
        onChanged: (value) => _pipBloc.validateRequiredInput(context, value),
        onSaved: (value) => _pip.proposals = value);
  }

  Widget _buildInputPipComments() {
    return InputMultiline(
        initialValue: _pip.comments,
        label: S.of(context).labelComments,
        onSaved: (value) => _pip.comments = (value.isEmpty) ? null : value);
  }

  Widget _buildInputPipDate() {
    return InputDate(
        initialValue: (_pip.date != null)
            ? DateTime.fromMillisecondsSinceEpoch(_pip.date)
            : null,
        labelAndHint: S.of(context).labelFinishDate,
        isRequired: true,
        onSaved: (DateTime value) => _pip.date = value.millisecondsSinceEpoch);
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

    final progressDialog =
        getProgressDialog(context, S.of(context).progressDialogSaving);

    await progressDialog.show();

    var statusCode = -1;

    if (_pip.id == null) {
      _pip.programsId = widget.programId;

      statusCode = await _pipBloc.insertPIP(_pip);
    } else {
      statusCode = await _pipBloc.updatePIP(_pip);
    }
    await progressDialog.hide();

    if (statusCode == 201) {
      final snackbar = buildSnackbar(Text(S.of(context).messagePIPHasBeenSave));
      _scaffoldKey.currentState.showSnackBar(snackbar);
    } else {
      showSnackBar(context, _scaffoldKey.currentState, statusCode);
    }
  }

  Future<void> _refreshPip() async =>
      await _pipBloc.getPIP(true, widget.programId);
}
