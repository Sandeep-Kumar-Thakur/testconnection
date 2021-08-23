import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testconnection/Screen_loader/SignupLOADING.dart';
import 'package:testconnection/Screen_loader/loginLOADER.dart';
import 'package:testconnection/authfile/auth.dart';
import 'package:testconnection/forgetpassword.dart';
import 'package:testconnection/profile/profiledatahandler.dart';

class LoginSignUp extends StatefulWidget {
  const LoginSignUp({Key? key}) : super(key: key);

  @override
  _LoginSignUpState createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  GlobalKey<FormState> _keylogin = new GlobalKey();
  GlobalKey<FormState> _keySign = new GlobalKey();

  AuthResult _authResult = new AuthResult();

  bool visible = true;
  Icon visibleIcon = Icon(Icons.visibility);
  late String email;
  late String password;
  bool autovallogin = false;
  bool autovalsign = false;
  late String signemail, signpassword, signpasswordcheck;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FlipCard(
          key: cardKey,
          flipOnTouch: false,
//=================login container=================================================================
          front: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [
//===============designing part===============================
              Positioned(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(200))),
                ),
                bottom: 0,
                right: 0,
              ),
              Positioned(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(200))),
                ),
                bottom: 0,
                right: 200,
              ),
              Positioned(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(200))),
                ),
                bottom: 0,
                right: 100,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(200),
                    ),
                    color: Colors.red.shade600),
              ),
              Container(
                margin: EdgeInsets.only(left: 100),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.red.shade900,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(200),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(left: 200),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.red.shade900,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(200),
                    )),
              ),
//===================design part over====================

//====================content part=========================
              //======container contain every think==========
              Center(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
//=================login lable------------
                    Container(
                        margin: EdgeInsets.only(top: 60),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText("LOGIN",
                                textStyle:
                                    GoogleFonts.inconsolata(fontSize: 40))
                          ],
                          totalRepeatCount: 100,
                        )),
                    SizedBox(
                      height: 60,
                    ),
//==================================textfield============================
                    Form(
                      key: _keylogin,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50))),
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Column(
                            children: [
                              TextFormField(
                                onChanged: (value) {
                                  email = value;
                                },
                                validator: (value) {
                                  String pattern =
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  RegExp regExp = new RegExp(pattern);
                                  if (!regExp.hasMatch(value!)) {
                                    return 'Enter correct email';
                                  }
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "Em@il",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(50)))),
                              ),
                              TextFormField(
                                onChanged: (value) {
                                  password = value;
                                },
                                validator: (value) {
                                  String pattern1 = r'^(?=.*?[a-z0-9]).{5,}$';

                                  RegExp regExp = new RegExp(pattern1);
                                  if (!regExp.hasMatch(value!)) {
                                    return 'Your Password must have 5 character';
                                  }
                                },
                                obscureText: visible,
                                decoration: InputDecoration(
                                    suffixIcon: InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (visible == true) {
                                              visible = !visible;
                                              visibleIcon =
                                                  Icon(Icons.visibility_off);
                                            } else {
                                              visible = !visible;
                                              visibleIcon =
                                                  Icon(Icons.visibility);
                                            }
                                          });
                                        },
                                        child: visibleIcon),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Password',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(50)))),
                              ),
//============================forget password inkwell=====================================================
                              Container(
                                margin: EdgeInsets.only(left: 100),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgetPassword()));
                                    },
                                    child: Text('Forget Password')),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              )),
//============================login button===========================================
              Center(
                child: Container(
                    margin: EdgeInsets.only(top: 45, left: 220),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        gradient: LinearGradient(
                            colors: [Colors.red, Colors.blue],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 45,
                      ),
                      onPressed: () async {
                        print("yes");
                        if (_keylogin.currentState!.validate()) {
                          print("s yes");
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPageLoader(
                                        email: email,
                                        password: password,
                                      )));
                        }
                      },
                    )),
              ),
//================================registration button===========================================
              Positioned(
                  bottom: 120,
                  left: 0,
                  child: InkWell(
                    onTap: () {
                      cardKey.currentState!.toggleCard();
                    },
                    child: Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 0.5,
                                spreadRadius: 1,
                                offset: Offset(1, 1))
                          ]),
                      child: Center(
                        child: Text(
                          "Registration?",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ))
            ]),
          ),

//=============================sigup container=============================================================
          back: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [
//===============designing part===============================
              Positioned(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(200))),
                ),
                bottom: 0,
                right: 0,
              ),
              Positioned(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(200))),
                ),
                bottom: 0,
                right: 200,
              ),
              Positioned(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(200))),
                ),
                bottom: 0,
                right: 100,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(200),
                    ),
                    color: Colors.red.shade600),
              ),
              Container(
                margin: EdgeInsets.only(left: 100),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.red.shade900,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(200),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(left: 200),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.red.shade900,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(200),
                    )),
              ),
//===================design part over====================

//====================content part=========================
              //======container contain every think==========
              Center(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
//=================Signup lable------------
                    Container(
                        margin: EdgeInsets.only(top: 60),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText("SIGN UP",
                                textStyle:
                                    GoogleFonts.inconsolata(fontSize: 40)),
                          ],
                          totalRepeatCount: 100,
                        )),

                    SizedBox(
                      height: 60,
                    ),
                    //==================================textfield============================
                    Form(
                      key: _keySign,
                      autovalidate: autovalsign,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50))),
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                  String pattern =
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  RegExp regExp = new RegExp(pattern);
                                  if (!regExp.hasMatch(value!)) {
                                    return 'Enter correct email';
                                  } else {
                                    signemail = value;
                                    print(signemail);
                                  }
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "Em@il",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(50)))),
                              ),
                              TextFormField(
                                validator: (value) {
                                  String pattern1 = r'^(?=.*?[a-z0-9]).{5,}$';

                                  RegExp regExp = new RegExp(pattern1);
                                  if (!regExp.hasMatch(value!)) {
                                    return 'Your Password must have 5 character';
                                  } else {
                                    signpasswordcheck = value;
                                  }
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Password',
                                    border: OutlineInputBorder()),
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value != signpasswordcheck) {
                                    return "Password is not matched";
                                  } else {
                                    signpassword = value!;
                                    print(signpassword);
                                  }
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Re - Password',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(50)))),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              )),
//============================Signup button===========================================
              Center(
                child: Container(
                    margin: EdgeInsets.only(top: 108, left: 180),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        gradient: LinearGradient(
                            colors: [Colors.red, Colors.blue],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(
                        Icons.check,
                        size: 45,
                      ),
//=========================write your details in firebase=================
                      onPressed: () async {
                        if (_keySign.currentState!.validate()) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupLoadingScreen(
                                      signemail: signemail,
                                      signpassword: signpassword)));
                        } else {
                          autovalsign = true;
                        }
                      },
                    )),
              ),
//================================Login button===========================================
              Positioned(
                  bottom: 120,
                  left: 0,
                  child: InkWell(
                    onTap: () {
                      cardKey.currentState!.toggleCard();
                    },
                    child: Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 0.5,
                                spreadRadius: 1,
                                offset: Offset(1, 1))
                          ]),
                      child: Center(
                        child: Text(
                          "Login?",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ))
            ]),
          ),
          direction: FlipDirection.HORIZONTAL,
        ),
      ),
    );
  }
}
