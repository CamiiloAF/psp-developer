import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/utils/token_handler.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/inputs_widget.dart';
import 'package:psp_developer/src/widgets/not_authorized_screen.dart';

class ProjectModuleDetailPage extends StatelessWidget {
  static const ROUTE_NAME = 'project-module-detail';

  @override
  Widget build(BuildContext context) {
    if (!TokenHandler.existToken()) return NotAuthorizedScreen();

    final dynamic model = ModalRoute.of(context).settings.arguments;
    final s = S.of(context);

    return Scaffold(
        appBar: CustomAppBar(title: S.of(context).appBarTitleProjects),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                InputForm.buildReadOnlyInput(s.labelName, model.name),
                InputForm.buildReadOnlyInput(
                    s.labelDescription, model.description),
                InputDate.buildDisableInputDate(
                    model.planningDate, s.labelPlanningDate),
                InputDate.buildDisableInputDate(
                    model.startDate, s.labelStartDate),
                InputDate.buildDisableInputDate(
                    model.finishDate, s.labelFinishDate),
              ],
            ),
          ),
        ));
  }
}
