import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/modules_bloc.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/searches/mixings/modules_page_and_search_mixing.dart';
import 'package:psp_developer/src/searches/search_modules.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:psp_developer/src/widgets/common_list_of_models.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/not_autorized_screen.dart';

class ModulesPage extends StatefulWidget {
  @override
  _ModulesPageState createState() => _ModulesPageState();
}

class _ModulesPageState extends State<ModulesPage>
    with ModulesPageAndSearchMixing {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ModulesBloc _modulesBloc;
  int projectId;

  @override
  void initState() {
    _modulesBloc = context.read<BlocProvider>().modulesBloc;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    projectId = ModalRoute.of(context).settings.arguments;
    if (_modulesBloc.lastValueModulesController == null) {
      _modulesBloc.getModules(false, '$projectId');
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _modulesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isValidToken()) return NotAutorizedScreen();

    return Scaffold(
        key: _scaffoldKey,
        body: _body(),
        appBar: CustomAppBar(
          title: S.of(context).appBarTitleModules,
          searchDelegate: SearchModules(_modulesBloc, projectId),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  Widget _body() => CommonListOfModels(
        stream: _modulesBloc.modulesStream,
        onRefresh: _onRefreshModules,
        scaffoldKey: _scaffoldKey,
        buildItemList: (items, index) =>
            buildItemList(context, items[index], projectId),
      );

  Future<void> _onRefreshModules() async =>
      await _modulesBloc.getModules(true, '$projectId');
}
