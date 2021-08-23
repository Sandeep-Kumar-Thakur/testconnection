import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testconnection/authfile/auth.dart';
import 'package:testconnection/profile/profiledatahandler.dart';

class LoginPageLoader extends StatefulWidget {
  late String email;
  late String password;

  LoginPageLoader({Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  _LoginPageLoaderState createState() =>
      _LoginPageLoaderState(email: email, password: password);
}

class _LoginPageLoaderState extends State<LoginPageLoader> {
  late String email;
  late String password;
  _LoginPageLoaderState({required this.email, required this.password});
  AuthResult _authResult = new AuthResult();

  Future CheckAuth() async {
    String uid = await _authResult.Login(email, password);
    print(uid);
    if (uid != null) {
      final SharedPreferences session = await SharedPreferences.getInstance();
      session.setString('userid', uid);
      dynamic user = await session.getString('userid');
      print("here :: " + user);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => ProfileDataHandler()));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Please enter valid credentials'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Ok'))
                ],
              ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CheckAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitHourGlass(
              color: Colors.cyan,
            ),
            AnimatedTextKit(
                animatedTexts: [TyperAnimatedText('Checking . . . ')])
          ],
        ),
      ),
    );
  }
}
