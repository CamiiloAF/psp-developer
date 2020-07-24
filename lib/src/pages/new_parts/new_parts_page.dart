import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/new_parts_bloc.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/searches/mixins/new_parts_page_and_search_mixing.dart';
import 'package:psp_developer/src/searches/search_new_parts.dart';
import 'package:psp_developer/src/utils/token_handler.dart';
import 'package:psp_developer/src/widgets/common_list_of_models.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/drawer_program_items.dart';
import 'package:psp_developer/src/widgets/not_authorized_screen.dart';

class NewPartsPage extends StatefulWidget {
  static const ROUTE_NAME = 'new-parts';
  @override
  _NewPartsPageState createState() => _NewPartsPageState();
}

class _NewPartsPageState extends State<NewPartsPage>
    with NewPartsPageAndSearchMixing {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  NewPartsBloc _newPartsBloc;
  int _programId;

  @override
  void initState() {
    _newPartsBloc = context.read<BlocProvider>().newPartsBloc;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _programId = ModalRoute.of(context).settings.arguments;
    if (_newPartsBloc.lastValueNewPartsController == null) {
      _newPartsBloc.getNewParts(false, _programId);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _newPartsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!TokenHandler.existToken()) return NotAuthorizedScreen();

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: S.of(context).appBarTitleNewParts,
        searchDelegate: SearchNewParts(_newPartsBloc),
      ),
      drawer: DrawerProgramItems(programId: _programId, scaffoldKey: _scaffoldKey,),
      body: _body(),
    );
  }

  Widget _body() => CommonListOfModels(
        stream: _newPartsBloc.newPartsStream,
        onRefresh: _onRefreshNewParts,
        scaffoldKey: _scaffoldKey,
        buildItemList: (items, index) => buildItemList(context, items[index]),
      );

  Future<void> _onRefreshNewParts() async =>
      await _newPartsBloc.getNewParts(true, _programId);
}
