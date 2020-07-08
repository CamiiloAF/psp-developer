import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/programs_bloc.dart';
import 'package:psp_developer/src/models/programs_model.dart';
import 'package:psp_developer/src/pages/programs/program_parts/base_parts_page.dart';
import 'package:psp_developer/src/pages/programs/program_parts/new_parts_page.dart';
import 'package:psp_developer/src/pages/programs/program_parts/reusable_parts_page.dart';
import 'package:psp_developer/src/pages/time_logs/time_logs_page.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/providers/models/added_new_parts_model.dart';
import 'package:psp_developer/src/utils/token_handler.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/not_autorized_screen.dart';

class ProgramPartsPage extends StatelessWidget {
  final ProgramModel program;

  ProgramPartsPage({@required this.program});
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (!TokenHandler.existToken()) return NotAutorizedScreen();

    final programsBloc = Provider.of<BlocProvider>(context).programsBloc;
    programsBloc.getProgramsByOrganization(program.id);

    return DefaultTabController(
      length: 3,
      child: ChangeNotifierProvider(
        create: (BuildContext context) => AddedNewPartsModel(),
        builder: (ctx, child) => buildScaffold(ctx, programsBloc),
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context, ProgramsBloc programsBloc) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          moreActions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: (Provider.of<AddedNewPartsModel>(context)
                      .addedNewParts
                      .isEmpty)
                  ? null
                  : () => updateProgramWithProgramParts(context),
            )
          ],
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
                BasePartsPage(programId: program.id),
                ReusablePartsPage(programId: program.id),
                NewPartsPage(programId: program.id),
              ],
            );
          },
        ));
  }

  void updateProgramWithProgramParts(BuildContext context) async {
    final progressDialog =
        getProgressDialog(context, S.of(context).progressDialogSaving);

    await progressDialog.show();

    var statusCode = -1;

    final blocProvider = Provider.of<BlocProvider>(context, listen: false);
    final baseParts = blocProvider.basePartsBloc.addedBaseParts;
    final reusableParts = blocProvider.reusablePartsBloc.addedReusableParts;
    final newParts = blocProvider.newPartsBloc.addedNewParts;

    program
      ..baseParts = baseParts
      ..reusableParts = reusableParts
      ..newParts = newParts;

    statusCode =
        await blocProvider.programsBloc.updateProgramWithProgramParts(program);

    await progressDialog.hide();

    if (statusCode == 204) {
      await Navigator.pushReplacementNamed(context, TimeLogsPage.ROUTE_NAME,
          arguments: program.id);
    } else {
      await showSnackBar(context, _scaffoldKey.currentState, statusCode);
    }
  }
}
