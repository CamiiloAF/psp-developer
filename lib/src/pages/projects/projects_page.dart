import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/projects_bloc.dart';
import 'package:psp_developer/src/models/projects_model.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/shared_preferences/shared_preferences.dart';
import 'package:psp_developer/src/utils/constants.dart';
import 'package:psp_developer/src/utils/searchs/search_projects.dart';
import 'package:psp_developer/src/utils/theme/theme_changer.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/not_autorized_screen.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';
import 'package:tuple/tuple.dart';

class ProjectsPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (!isValidToken()) return NotAutorizedScreen();

    final projectsBloc = Provider.of<BlocProvider>(context).projectsBloc;
    projectsBloc.getProjects(false);

    Constants.token = Preferences().token;

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
          title: S.of(context).appBarTitleProjects,
          searchDelegate: SearchProjects(projectsBloc)),
      body: _body(projectsBloc),
      drawer: CustomDrawerMenu(),
    );
  }

  Widget _body(ProjectsBloc projectsBloc) {
    return StreamBuilder(
      stream: projectsBloc.projectStream,
      builder: (BuildContext context,
          AsyncSnapshot<Tuple2<int, List<ProjectModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final projects = snapshot.data.item2 ?? [];

        final statusCode = snapshot.data.item1;

        if (statusCode != 200) {
          showSnackBar(context, _scaffoldKey.currentState, statusCode);
        }

        if (projects.isEmpty) {
          return RefreshIndicator(
            onRefresh: () => _refreshProjects(context, projectsBloc),
            child: ListView(
              children: [
                Center(
                  child: Text(S.of(context).thereIsNoInformation),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => _refreshProjects(context, projectsBloc),
          child: _buildListView(projects),
        );
      },
    );
  }

  ListView _buildListView(List<ProjectModel> projects) {
    return ListView.separated(
        itemCount: projects.length,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, i) => _buildItemList(projects, i, context),
        separatorBuilder: (BuildContext context, int index) => Divider(
              thickness: 1.0,
            ));
  }

  Widget _buildItemList(
      List<ProjectModel> projects, int i, BuildContext context) {
    return CustomListTile(
      title: projects[i].name,
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () =>
          Navigator.pushNamed(context, 'modules', arguments: projects[i].id),
      subtitle: projects[i].description,
    );
  }

  Future<void> _refreshProjects(
      BuildContext context, ProjectsBloc projectsBloc) async {
    await projectsBloc.getProjects(true);
  }
}

class CustomDrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    return Drawer(
      child: Container(
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Container(
                width: double.infinity,
                height: 200,
                child: CircleAvatar(
                  child: Text(
                    'FH',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ),
            ),
            CustomListTile(title: 'Usuarios libres', onTap: () {}),
            Divider(),
            ListTile(
              leading: Icon(Icons.brightness_4),
              title: Text(S.of(context).darkMode),
              trailing: Switch.adaptive(
                  value: appTheme.isDarkTheme,
                  activeColor: appTheme.currentTheme.accentColor,
                  onChanged: (value) => appTheme.isDarkTheme = value),
            ),
          ],
        ),
      ),
    );
  }
}
