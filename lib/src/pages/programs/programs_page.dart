import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/programs_bloc.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/searches/mixins/programs_page_and_search_mixing.dart';
import 'package:psp_developer/src/searches/search_programs.dart';
import 'package:psp_developer/src/utils/token_handler.dart';
import 'package:psp_developer/src/widgets/common_list_of_models.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/not_autorized_screen.dart';

class ProgramsPage extends StatefulWidget {
  static const ROUTE_NAME = 'programs';
  @override
  _ProgramsPageState createState() => _ProgramsPageState();
}

class _ProgramsPageState extends State<ProgramsPage>
    with ProgramsPageAndSearchMixing {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ProgramsBloc _programsBloc;
  int _moduleId;

  @override
  void initState() {
    _programsBloc = context.read<BlocProvider>().programsBloc;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _moduleId = ModalRoute.of(context).settings.arguments;
    if (_programsBloc.lastValueProgramsByModuleIdController == null) {
      _programsBloc.getPrograms(false, _moduleId);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _programsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!TokenHandler.existToken()) return NotAutorizedScreen();

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: S.of(context).appBarTitlePrograms,
        searchDelegate: SearchPrograms(_programsBloc, _moduleId),
      ),
      body: _body(),
    );
  }

  Widget _body() => CommonListOfModels(
        stream: _programsBloc.programsByModuleIdStream,
        onRefresh: _onRefreshPrograms,
        scaffoldKey: _scaffoldKey,
        buildItemList: (items, index) =>
            buildItemList(context, items[index], _moduleId),
      );

  Future<void> _onRefreshPrograms() async =>
      await _programsBloc.getPrograms(true, _moduleId);
}
