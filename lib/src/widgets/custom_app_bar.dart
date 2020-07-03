import 'package:flutter/material.dart';
import 'package:psp_developer/src/widgets/custom_popup_menu.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final SearchDelegate searchDelegate;
  final String title;
  final PreferredSizeWidget bottom;
  final List<Widget> moreActions;

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
      CustomPopupMenu()
    ];
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0));
}
