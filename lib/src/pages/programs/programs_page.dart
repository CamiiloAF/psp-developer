import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/programs_bloc.dart';
import 'package:psp_developer/src/models/programs_model.dart';
import 'package:psp_developer/src/pages/programs/program_parts/program_parts_page.dart';
import 'package:psp_developer/src/pages/time_logs/time_logs_page.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/utils/searchs/search_programs.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';
import 'package:psp_developer/src/widgets/not_autorized_screen.dart';
import 'package:tuple/tuple.dart';

class ProgramsPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (!isValidToken()) return NotAutorizedScreen();

    final int moduleId = ModalRoute.of(context).settings.arguments;
    final programsBloc = Provider.of<BlocProvider>(context).programsBloc;

    programsBloc.getPrograms(false, moduleId);

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: S.of(context).appBarTitlePrograms,
        searchDelegate: SearchPrograms(programsBloc),
      ),
      body: _body(programsBloc, moduleId),
    );
  }

  Widget _body(ProgramsBloc programsBloc, int moduleId) {
    return StreamBuilder(
      stream: programsBloc.programsByModuleIdStream,
      builder: (BuildContext context,
          AsyncSnapshot<Tuple2<int, List<ProgramModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final programs = snapshot.data.item2 ?? [];

        final statusCode = snapshot.data.item1;

        if (statusCode != 200) {
          showSnackBar(context, _scaffoldKey.currentState, statusCode);
        }

        if (programs.isEmpty) {
          return RefreshIndicator(
            onRefresh: () => _refreshPrograms(context, programsBloc, moduleId),
            child: ListView(
              children: [
                Center(child: Text(S.of(context).thereIsNoInformation)),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => _refreshPrograms(context, programsBloc, moduleId),
          child: _buildListView(programs),
        );
      },
    );
  }

  ListView _buildListView(List<ProgramModel> programs) {
    return ListView.separated(
        itemCount: programs.length,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, i) => _buildItemList(programs, i, context),
        separatorBuilder: (BuildContext context, int index) => Divider(
              thickness: 1.0,
            ));
  }

  Widget _buildItemList(
      List<ProgramModel> programs, int i, BuildContext context) {
    return CustomListTile(
      title: programs[i].name,
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () => onTapItemList(context, programs[i]),
      subtitle: programs[i].description,
    );
  }

  Future<void> _refreshPrograms(
      BuildContext context, ProgramsBloc programsBloc, int moduleId) async {
    await programsBloc.getPrograms(true, moduleId);
  }
}

void onTapItemList(BuildContext context, ProgramModel program) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => (program.totalLines == null)
              ? ProgramPartsPage(program: program)
              : TimeLogsPage(
                  programId: program.id,
                )));
}
