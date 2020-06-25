import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psp_developer/src/blocs/programs_bloc.dart';
import 'package:psp_developer/src/models/programs_model.dart';
import 'package:psp_developer/src/utils/searchs/search_delegate.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';

class SearchPrograms extends DataSearch {
  final ProgramsBloc _programsBloc;

  SearchPrograms(this._programsBloc);

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return super.textNoResults(context);

    final programs =
        _programsBloc?.lastValueProgramsByModuleIdController?.item2 ?? [];
    if (programs.isNotEmpty && programs != null) {
      return Container(
          child: ListView(
        children: programs
            .where((program) => _areItemContainQuery(program, query))
            .map((program) {
          return CustomListTile(
            title: program.name,
            onTap: () {
              close(context, null);
              Navigator.pushNamed(context, 'testReports',
                  arguments: program.id);
            },
            subtitle: program.description,
          );
        }).toList(),
      ));
    } else {
      return super.textNoResults(context);
    }
  }

  bool _areItemContainQuery(ProgramModel program, String query) {
    return program.name.toLowerCase().contains(query.toLowerCase()) ||
            program.description.toLowerCase().contains(query.toLowerCase())
        ? true
        : false;
  }
}
