import 'package:flutter/material.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/models/programs_model.dart';
import 'package:psp_developer/src/pages/programs/program_parts/base_parts_page.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';

class ProgramPartsPage extends StatelessWidget {
  // final ProgramModel program;

  // ProgramPartsPage({@required this.program});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CustomAppBar(
          bottom: TabBar(
            indicatorColor: Theme.of(context).accentColor,
            tabs: [
              Tab(
                text: S.of(context).appBarTitleBaseParts,
              ),
              Tab(
                text: S.of(context).appBarTitleReusableParts,
              ),
              Tab(
                text: S.of(context).appBarTitleNewParts,
              ),
            ],
          ),
          title: S.of(context).appBarTitleProgramParts,
        ),
        body: TabBarView(
          children: [
            // BasePartsPage(programId: program.id),
            BasePartsPage(programId: 1),
            Container(),
            Container(),
            // ModulesPage(projectId: '$projectId'),
          ],
        ),
      ),
    );
  }
}
