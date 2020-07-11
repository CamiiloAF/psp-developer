import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/reusable_parts_bloc.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/searches/mixins/reusable_parts_page_and_search_mixing.dart';
import 'package:psp_developer/src/searches/search_reusable_parts.dart';
import 'package:psp_developer/src/utils/token_handler.dart';
import 'package:psp_developer/src/widgets/common_list_of_models.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/drawer_program_items.dart';
import 'package:psp_developer/src/widgets/not_autorized_screen.dart';

class ReusablePartsPage extends StatefulWidget {
  static const ROUTE_NAME = 'reusable-parts';

  @override
  _ReusablePartsPageState createState() => _ReusablePartsPageState();
}

class _ReusablePartsPageState extends State<ReusablePartsPage>
    with ReusablePartsPageAndSearchMixing {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ReusablePartsBloc _reusablePartsBloc;
  int _programId;

  @override
  void initState() {
    _reusablePartsBloc = context.read<BlocProvider>().reusablePartsBloc;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _programId = ModalRoute.of(context).settings.arguments;
    if (_reusablePartsBloc.lastValueReusablePartsController == null) {
      _reusablePartsBloc.getReusableParts(false, _programId);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _reusablePartsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!TokenHandler.existToken()) return NotAutorizedScreen();

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: S.of(context).appBarTitleReusableParts,
        searchDelegate: SearchReusableParts(_reusablePartsBloc),
      ),
      drawer: DrawerProgramItems(programId: _programId),
      body: _body(),
    );
  }

  Widget _body() => CommonListOfModels(
        stream: _reusablePartsBloc.reusablePartsStream,
        onRefresh: _onRefreshReusableParts,
        scaffoldKey: _scaffoldKey,
        buildItemList: (items, index) => buildItemList(context, items[index]),
      );

  Future<void> _onRefreshReusableParts() async =>
      await _reusablePartsBloc.getReusableParts(true, _programId);
}
