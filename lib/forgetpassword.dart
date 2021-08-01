import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testconnection/authfile/auth.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool autoval = false;
  late String email;
  AuthResult _authResult = new AuthResult();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
            child: Column(
              children: [
                AnimatedTextKit(animatedTexts: [
                  TyperAnimatedText('This will Send mail on your email',
                      textStyle: GoogleFonts.alike(fontSize: 20))
                ]),
                SizedBox(
                  height: 40,
                ),
                Form(
                  key: _key,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Container(
                    width: 300,
                    child: TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        String pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regExp = new RegExp(pattern);
                        if (!regExp.hasMatch(value!)) {
                          return "Enter valid Email Address";
                        }
                      },
                      decoration: InputDecoration(
                          hintText: 'Enter your mail',
                          border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                MaterialButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      print('hi');
                      // _authResult.Forgetpassword(email);

                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.success,
                          text: 'Link send on your E-mail',
                          onConfirmBtnTap: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
                      print("heelo");
                    } else {}
                  },
                  color: Colors.lightGreen,
                  child: Text('Forget Password'),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
