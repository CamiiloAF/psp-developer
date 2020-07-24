import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/programs_bloc.dart';
import 'package:psp_developer/src/models/programs_model.dart';
import 'package:psp_developer/src/pages/programs/program_parts/base_parts_page.dart';
import 'package:psp_developer/src/pages/programs/program_parts/new_parts_page.dart';
import 'package:psp_developer/src/pages/programs/program_parts/reusable_parts_page.dart';
import 'package:psp_developer/src/pages/programs/program_planning_time/program_planning_page.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/providers/models/added_new_parts_model.dart';
import 'package:psp_developer/src/utils/token_handler.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/not_authorized_screen.dart';

class ProgramPartsPage extends StatefulWidget {
  final ProgramModel program;

  ProgramPartsPage({@required this.program});

  @override
  _ProgramPartsPageState createState() => _ProgramPartsPageState();
}

class _ProgramPartsPageState extends State<ProgramPartsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ProgramsBloc _programsBloc;

  @override
  void initState() {
    _programsBloc = context.read<BlocProvider>().programsBloc;
    _programsBloc.getProgramsByOrganization(widget.program.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!TokenHandler.existToken()) return NotAuthorizedScreen();

    return DefaultTabController(
      length: 3,
      child: ChangeNotifierProvider(
        create: (BuildContext context) => AddedNewPartsModel(),
        builder: (ctx, child) => buildScaffold(ctx, _programsBloc),
      ),
    );
  }

  Scaffold buildScaffold(BuildContext ctx, ProgramsBloc programsBloc) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          moreActions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed:
                  (Provider.of<AddedNewPartsModel>(ctx).addedNewParts.isEmpty)
                      ? null
                      : () => _goToPlanningTimes(context),
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
                BasePartsPage(programId: widget.program.id),
                ReusablePartsPage(programId: widget.program.id),
                NewPartsPage(programId: widget.program.id),
              ],
            );
          },
        ));
  }

  void _goToPlanningTimes(BuildContext context) =>
      Navigator.pushNamed(context, ProgramPlanningPage.ROUTE_NAME,
          arguments: widget.program);
}
