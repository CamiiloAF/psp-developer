import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/widgets/buttons_widget.dart';

class NotAutorizedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PSP'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).titleNotAutorized,
              style: TextStyle(fontSize: 35.0),
            ),
            SizedBox(
              height: 50.0,
            ),
            raisedButton(context,
                buttonText: S.of(context).loginButton,
                onPress: () => Navigator.pushNamedAndRemoveUntil(
                    context, 'login', (route) => false))
          ],
        ),
      ),
    );
  }
}
