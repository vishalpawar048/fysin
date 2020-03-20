import 'package:flutter_scaffold/blocks/auth_block.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Auth extends StatelessWidget {
  returnToPage(context) async {
    return await Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    AuthBlock auth = Provider.of<AuthBlock>(context);
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.pink[100],
        body: Center(
          child: auth.isLoggedIn
              ? null
              : Container(
                  margin: const EdgeInsets.only(bottom: 1.0),
                  width: 250.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: Color(0xffffffff),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.google,
                            color: Color(0xffCE107C),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Sign in with Google',
                            style:
                                TextStyle(color: Colors.black, fontSize: 18.0),
                          ),
                        ],
                      ),
                      onPressed: () => auth.login(context),
                    ),
                  )),
        ),
      ),
    );
  }
}
