import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:testconnection/sessionstore/sessionstore.dart';

class UserNameCheck extends StatefulWidget {
  const UserNameCheck({Key? key}) : super(key: key);

  @override
  _UserNameCheckState createState() => _UserNameCheckState();
}

class _UserNameCheckState extends State<UserNameCheck> {
  String name = "null";
  late String uid;
  late String email;
  late String profileurl;
  SessionStore _sessionStore = SessionStore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedTextKit(repeatForever: true, animatedTexts: [
            TyperAnimatedText("Enter your lucky name",
                speed: Duration(milliseconds: 100))
          ]),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                decoration: InputDecoration(hintText: 'here..'),
              )),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              if (name == "null") {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("Please enter Your name"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OKAY'))
                          ],
                        ));
              } else {
                uid = _sessionStore.UID;
                profileurl = _sessionStore.PROFILEURL;
                email = _sessionStore.EMAIL;
                print(uid);
                print(profileurl);
                print(email);
                var data = {
                  'Name': name,
                  'Profileurl': profileurl,
                  'Uid': uid,
                  'Email': email,
                };
                CollectionReference db =
                    FirebaseFirestore.instance.collection('Profile');
                // String docID;
                //docID =
                db.doc(uid).collection('uid').doc('userinfo').set(data);
                _sessionStore.Setname(name);
                //print(docID);
                //db.doc(uid).collection('uid').add(data);
              }
            },
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(100)),
              child: Icon(
                Icons.check,
                color: Colors.green,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
