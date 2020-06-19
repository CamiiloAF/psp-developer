import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/modules_bloc.dart';
import 'package:psp_developer/src/models/modules_model.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/utils/searchs/search_modules.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';
import 'package:psp_developer/src/widgets/not_autorized_screen.dart';
import 'package:tuple/tuple.dart';

class ModulesPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (!isValidToken()) return NotAutorizedScreen();

    final int projectId = ModalRoute.of(context).settings.arguments;

    final modulesBloc = Provider.of<BlocProvider>(context).modulesBloc;
    modulesBloc.getModules(false, '$projectId');

    return Scaffold(
        key: _scaffoldKey,
        body: _body(modulesBloc, '$projectId'),
        appBar: CustomAppBar(
          title: S.of(context).appBarTitleModules,
          searchDelegate: SearchModules(modulesBloc, projectId),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  Widget _body(ModulesBloc modulesBloc, String projectId) {
    return StreamBuilder(
      stream: modulesBloc.modulesStream,
      builder: (BuildContext context,
          AsyncSnapshot<Tuple2<int, List<ModuleModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final modules = snapshot.data.item2 ?? [];

        final statusCode = snapshot.data.item1;

        if (statusCode != 200) {
          showSnackBar(context, _scaffoldKey.currentState, statusCode);
        }

        if (modules.isEmpty) {
          return RefreshIndicator(
            onRefresh: () => _refreshModules(context, modulesBloc, projectId),
            child: ListView(
              children: [
                Center(child: Text(S.of(context).thereIsNoInformation)),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => _refreshModules(context, modulesBloc, projectId),
          child: _buildListView(modules),
        );
      },
    );
  }

  ListView _buildListView(List<ModuleModel> modules) {
    return ListView.separated(
        itemCount: modules.length,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, i) => _buildItemList(modules, i, context),
        separatorBuilder: (BuildContext context, int index) => Divider(
              thickness: 1.0,
            ));
  }

  Widget _buildItemList(
      List<ModuleModel> modules, int i, BuildContext context) {
    return CustomListTile(
      title: modules[i].name,
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () =>
          {Navigator.pushNamed(context, 'programs', arguments: modules[i].id)},
      subtitle: modules[i].description,
    );
  }

  Future<void> _refreshModules(
      BuildContext context, ModulesBloc modulesBloc, String projectId) async {
    await modulesBloc.getModules(true, projectId);
  }
}
