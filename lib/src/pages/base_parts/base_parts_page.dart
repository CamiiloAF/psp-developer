import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/base_parts_bloc.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/searches/mixins/base_parts_page_and_search_mixing.dart';
import 'package:psp_developer/src/searches/search_base_parts.dart';
import 'package:psp_developer/src/utils/token_handler.dart';
import 'package:psp_developer/src/widgets/common_list_of_models.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/drawer_program_items.dart';
import 'package:psp_developer/src/widgets/not_autorized_screen.dart';

class BasePartsPage extends StatefulWidget {
  static const ROUTE_NAME = 'base-parts';

  @override
  _BasePartsPageState createState() => _BasePartsPageState();
}

class _BasePartsPageState extends State<BasePartsPage>
    with BasePartsPageAndSearchMixing {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  BasePartsBloc _basePartsBloc;
  int _programId;

  @override
  void initState() {
    _basePartsBloc = context.read<BlocProvider>().basePartsBloc;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _programId = ModalRoute.of(context).settings.arguments;
    if (_basePartsBloc.lastValueBasePartsController == null) {
      _basePartsBloc.getBaseParts(false, _programId);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _basePartsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!TokenHandler.existToken()) return NotAutorizedScreen();

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: S.of(context).appBarTitleBaseParts,
        searchDelegate: SearchBaseParts(_basePartsBloc),
      ),
      drawer: DrawerProgramItems(programId: _programId),
      body: _body(),
    );
  }

  Widget _body() => CommonListOfModels(
        stream: _basePartsBloc.basePartsStream,
        onRefresh: _onRefreshBaseParts,
        scaffoldKey: _scaffoldKey,
        buildItemList: (items, index) => buildItemList(context, items[index]),
      );

  Future<void> _onRefreshBaseParts() async =>
      await _basePartsBloc.getBaseParts(true, _programId);
}
