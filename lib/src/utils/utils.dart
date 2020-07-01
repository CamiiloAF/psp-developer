import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/shared_preferences/shared_preferences.dart';

ProgressDialog getProgressDialog(BuildContext context, String message) {
  final progressDialog = ProgressDialog(context,
      type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);

  progressDialog.style(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    messageTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).textTheme.bodyText1.color),
    message: message,
  );

  return progressDialog;
}

void showAlertDialog(BuildContext context, {String message, String title}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(S.of(context).dialogButtonOk),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}

String getRequestResponseMessage(BuildContext context, int statusCode) {
  switch (statusCode) {
    //7 = no connection
    case 7:
      return S.of(context).messageNotConnection;
      break;
    case 204:
      return S.of(context).message204Update;
      break;
    case 400:
      return S.of(context).message400;
      break;
    case 401:
      return S.of(context).message401;
      break;
    case 403:
      return S.of(context).message403;
      break;
    case 404:
      return S.of(context).message404;
      break;

    default:
      return S.of(context).messageUnexpectedError;
  }
}

void showSnackBar(
    BuildContext context, ScaffoldState scaffoldState, int statusCode,
    {bool allow404Message = false}) async {
  if (allow404Message || statusCode != 404) {
    final snackBar =
        buildSnackbar(Text(getRequestResponseMessage(context, statusCode)));

    scaffoldState.showSnackBar(snackBar);
  }
}

SnackBar buildSnackbar(Widget content) => SnackBar(
      content: content,
      duration: Duration(milliseconds: 1500),
    );

bool isValidToken() {
  final token = Preferences().token;

  if (token == null || token.isEmpty) return false;
  return true;
}

int getMinutesBetweenTwoDates(DateTime startDate, DateTime finishDate) =>
    (startDate != null && finishDate != null)
        ? finishDate.difference(startDate).inMinutes
        : null;

bool isNullOrEmpty(List list) => list == null || list.isEmpty;