import 'package:flutter/cupertino.dart';
import 'package:psp_developer/src/blocs/base_parts_bloc.dart';
import 'package:psp_developer/src/models/base_parts_model.dart';
import 'package:psp_developer/src/searches/mixins/base_parts_page_and_search_mixing.dart';
import 'package:psp_developer/src/searches/search_delegate.dart';

class SearchBaseParts extends DataSearch with BasePartsPageAndSearchMixing {
  final BasePartsBloc _basePartsBloc;

  SearchBaseParts(this._basePartsBloc);

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return super.textNoResults(context);

    final baseParts = _basePartsBloc?.lastValueBasePartsController?.item2 ?? [];
    if (baseParts.isNotEmpty && baseParts != null) {
      return Container(
          child: ListView(
        children: baseParts
            .where((basePart) => _areItemContainQuery(basePart, query))
            .map((basePart) {
          return buildItemList(context, basePart,
              closeSearch: () => close(context, null));
        }).toList(),
      ));
    } else {
      return super.textNoResults(context);
    }
  }

  bool _areItemContainQuery(BasePartModel basePart, String query) {
    return '${basePart.id}'.contains(query.toLowerCase()) ||
            '${basePart.plannedLinesAdded}'
                .toLowerCase()
                .contains(query.toLowerCase())
        ? true
        : false;
  }
}
