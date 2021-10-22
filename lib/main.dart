import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testconnection/authfile/auth.dart';
import 'package:testconnection/login&sinuppage/loginsignpage.dart';
import 'package:testconnection/profile/profiledatahandler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Future<SharedPreferences> _session = SharedPreferences.getInstance();
  // final SharedPreferences session = await _session;

  // var userid = session.getString('userid');
  // print(userid.toString() + ": here");
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Myhomepage()
      // userid == null ? Myapp() : ProfileDataHandler(),
      ));
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginSignUp(),
    );
  }
}

class Myhomepage extends StatefulWidget {
  const Myhomepage({Key? key}) : super(key: key);

  @override
  _MyhomepageState createState() => _MyhomepageState();
}

var userid;

class _MyhomepageState extends State<Myhomepage> with TickerProviderStateMixin {
  Future Getdata() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    userid = sharedPreferences.getString('userid');
    print(userid);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Getdata();
    Timer(Duration(seconds: 3), () {
      userid == null
          ? Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginSignUp()))
          : Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ProfileDataHandler()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.red, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),

      child: Center(
          child: Text(
        "Welcome",
        style: GoogleFonts.alike(
            color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900),
      )),
    ));
  }
}
