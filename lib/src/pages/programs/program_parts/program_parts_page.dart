import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/programs_bloc.dart';
import 'package:psp_developer/src/models/programs_model.dart';
import 'package:psp_developer/src/pages/programs/program_parts/base_parts_page.dart';
import 'package:psp_developer/src/pages/programs/program_parts/new_parts_page.dart';
import 'package:psp_developer/src/pages/programs/program_parts/reusable_parts_page.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/shared_preferences/shared_preferences.dart';
import 'package:psp_developer/src/utils/constants.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';

class ProgramPartsPage extends StatelessWidget {
  // final ProgramModel program;

  // ProgramPartsPage({@required this.program});
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Constants.token = Preferences().token;

    final programsBloc = Provider.of<BlocProvider>(context).programsBloc;
    programsBloc.getProgramsByOrganization(1);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          key: _scaffoldKey,
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
          body: StreamBuilder(
            stream: programsBloc.programsByOrganizationStream,
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              final statusCode = snapshot.data.item1;

              if (statusCode != 200) {
                showSnackBar(context, _scaffoldKey.currentState, statusCode);
              }

              return TabBarView(
                children: [
                  // BasePartsPage(programId: program.id),
                  BasePartsPage(programId: 1),
                  ReusablePartsPage(programId: 1),
                  NewPartsPage(programId: 1),
                  // ModulesPage(projectId: '$projectId'),
                ],
              );
            },
          )),
    );
  }

  Future<void> _refreshPrograms(
      BuildContext context, ProgramsBloc programsBloc) async {
    //TODO : Cambiar ese 1 por el id del programa actual
    await programsBloc.getProgramsByOrganization(1);
  }
}
