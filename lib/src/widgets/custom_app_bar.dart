import 'package:flutter/material.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/repositories/session_repository.dart';
import 'package:psp_developer/src/utils/utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final SearchDelegate searchDelegate;
  final String title;
  final PreferredSizeWidget bottom;
  final List<Widget> moreActions;

  final _sessionProvider = SessionRepository();

  final _optionSettingsIndex = 1;
  final _optionLogOutIndex = 2;

  CustomAppBar(
      {this.searchDelegate,
      @required this.title,
      this.bottom,
      this.moreActions = const []});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: appBarActions(context),
      bottom: bottom,
    );
  }

  List<Widget> appBarActions(BuildContext context) {
    return [
      if (moreActions.isNotEmpty) ...moreActions,
      (searchDelegate != null)
          ? IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: searchDelegate);
              })
          : Container(),
      PopupMenuButton(
          onSelected: (value) {
            onItemMenuSelected(value, context);
          },
          itemBuilder: (context) => getPopUpMenuOptions(context)
              .map((option) => (option.isNotEmpty)
                  ? PopupMenuItem<String>(value: option, child: Text(option))
                  : null)
              .toList())
    ];
  }

  List<String> getPopUpMenuOptions(BuildContext context) => [
        '',
        S.of(context).optionSettings,
        S.of(context).optionLogOut,
      ];

  void onItemMenuSelected(String value, BuildContext context) {
    final options = getPopUpMenuOptions(context);

    if (value == options[_optionSettingsIndex]) {
    } else if (value == options[_optionLogOutIndex]) {
      doLogout(context);
    }
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0));

  void doLogout(BuildContext context) async {
    final progressDialog =
        getProgressDialog(context, S.of(context).progressDialogLoading);

    await progressDialog.show();

    await Navigator.pushNamedAndRemoveUntil(context, 'login', (r) => false);
    await _sessionProvider.logOut();

    await progressDialog.hide();
  }
}
