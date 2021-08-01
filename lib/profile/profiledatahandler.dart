import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testconnection/profile/User_check.dart';
import 'package:testconnection/services/allservices.dart';
import 'package:testconnection/services/homepage.dart';
import 'package:testconnection/sessionstore/sessionstore.dart';

class ProfileDataHandler extends StatefulWidget {
  ProfileDataHandler({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileDataHandlerState createState() => _ProfileDataHandlerState();
}

class _ProfileDataHandlerState extends State<ProfileDataHandler> {
  late String userid;
//========firebase instance================================
  final db = FirebaseFirestore.instance.collection("Profile");
//=============Session instance===========================
  final datastore = SessionStore.instance;
//======session store variable==========
  var uid;

//===========namecheck bool===========
  bool name_avialable = false;

  void Dataloaded() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  Future Getsession() async {
    final SharedPreferences session = await SharedPreferences.getInstance();
    setState(() {
      uid = session.getString('userid');
      print("sec here :: " + uid);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Getsession();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => name_avialable == false
                    ? UserNameCheck()
                    : Allservices())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: db.doc(uid).collection('uid').snapshots(),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];
            String uid = ds['Uid'];
            String name = ds['Name'];
            String email = ds['Email'];
            String profileurl = ds['Profileurl'];
            if (name == "null") {
            } else {
              name_avialable = true;
            }
//=====================store data into class for future reference===================
            datastore.Setuid(uid);
            datastore.Setname(name);
            datastore.Setemail(email);
            datastore.Setprofileurl(profileurl);
            print(uid);
            return Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.4,
              ),
              child: SpinKitCubeGrid(
                color: Colors.blue,
              ),
            );
          },
        );
      },
    ));
  }
}
