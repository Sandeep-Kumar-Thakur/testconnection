import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:testconnection/authfile/auth.dart';
import 'package:testconnection/login&sinuppage/loginsignpage.dart';

class SignupLoadingScreen extends StatefulWidget {
  late String signemail;
  late String signpassword;
  SignupLoadingScreen(
      {Key? key, required this.signemail, required this.signpassword})
      : super(key: key);

  @override
  _SignupLoadingScreenState createState() => _SignupLoadingScreenState(
      signemail: signemail, signpassword: signpassword);
}

class _SignupLoadingScreenState extends State<SignupLoadingScreen> {
  late String signemail;
  late String signpassword;
  _SignupLoadingScreenState(
      {required this.signemail, required this.signpassword});
  AuthResult _authResult = new AuthResult();
  Future Uploading_Data() async {
    String uid = await _authResult.CreateID(signemail, signpassword);
    print(uid);
    if (uid.isNotEmpty) {
      String name = "null", profileurl = 'null', docID;

      CollectionReference db = FirebaseFirestore.instance.collection('Profile');
      docID = db.doc(uid).collection('uid').doc().id;
      print(docID);
      var data = {
        'Name': name,
        'Profileurl': profileurl,
        'Uid': uid,
        'Email': signemail,
        'docid': docID
      };
      db.doc(uid).collection('uid').doc('userinfo').set(data);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginSignUp()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Uploading_Data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitChasingDots(
            color: Colors.cyan,
          ),
          AnimatedTextKit(animatedTexts: [TyperAnimatedText("Loading . . . .")])
        ],
      )),
    );
  }
}
