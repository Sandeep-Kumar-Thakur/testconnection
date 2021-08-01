import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testconnection/login&sinuppage/loginsignpage.dart';
import 'package:testconnection/services/changeprofile.dart';
import 'package:testconnection/sessionstore/sessionstore.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  _ProfilepageState createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  late String name;
  late String email;
  late String profileurl;
  late String uid;
  final db = FirebaseFirestore.instance.collection("Timeline");
  late String otherurl;
  late String posturl;
  late String status;
  late String dateofpost;
  late String othername;

  final _userdata = SessionStore.instance;
  late String Newprofilepic;

  Future GetData() async {
    name = _userdata.NAME;
    email = _userdata.EMAIL;
    profileurl = _userdata.PROFILEURL;
    uid = _userdata.UID;
  }

  Widget WithStatusandPhoto() {
    return Container(
      child: Column(
        children: [
          //-----row that contain other details----------------
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 3, top: 4, bottom: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(otherurl)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(othername)
                    ],
                  ),
                ),
                //--------date of post
                Container(
                    margin: EdgeInsets.only(right: 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: Colors.grey.shade500,
                        ),
                        Text(
                          dateofpost,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
          //--------imaege
          Container(
            child: SizedBox(
              width: 400,
              child: Image.network(posturl),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 3, left: 5, right: 5),
            child: Row(
              children: [
                Text(status),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Withoutphoto() {
    return Container(
      child: Column(
        children: [
          //-----row that contain other details----------------
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 3, top: 4, bottom: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(otherurl)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(othername)
                    ],
                  ),
                ),

                //--------date of post
                Container(
                    margin: EdgeInsets.only(right: 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: Colors.grey.shade500,
                        ),
                        Text(
                          dateofpost,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          //--------imaege
          Text(status),
          //--------delete post button
        ],
      ),
    );
  }

  Widget Withoutstatus() {
    return Container(
      child: Column(
        children: [
          //-----row that contain other details----------------
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 3, top: 4, bottom: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(otherurl)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(othername)
                    ],
                  ),
                ),
                //--------date of post
                Container(
                    margin: EdgeInsets.only(right: 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: Colors.grey.shade500,
                        ),
                        Text(
                          dateofpost,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
          //--------imaege
          Container(
            child: SizedBox(
              width: 400,
              child: Image.network(posturl),
            ),
          ),
        ],
      ),
    );
  }

  // void Getphoto() async {
  //   file = await ImagePicker.platform.getImage(source: ImageSource.camera);
  //   setState(() async {
  //     if (file == null) {
  //     } else {
  //       imagefile = File(file.path);
  //     }
  //   });
  // }

  Future UploadnewPhoto() async {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            //------profile data format---------
            children: [
          SafeArea(
            child: Container(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.lightBlue.shade300,
                          Colors.blue.shade900
                        ]),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              color: Colors.black,
                              offset: Offset(0, 1))
                        ]),
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01),
                    width: MediaQuery.of(context).size.width * 0.98,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(75)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(75),
                            child: profileurl != 'null'
                                ? Image.network(profileurl)
                                : Image.asset(
                                    'assets/profile.jpg',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          width: 190,
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: GoogleFonts.alike(
                                    color: Colors.white,
                                    fontSize: 20,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black38,
                                          offset: Offset(0, 4),
                                          blurRadius: 5)
                                    ]),
                              ),
                              Text(
                                email,
                                style: GoogleFonts.alike(
                                    color: Colors.white,
                                    fontSize: 14,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black38,
                                          offset: Offset(0, 4),
                                          blurRadius: 5)
                                    ]),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.01,
                        ),
                        width: MediaQuery.of(context).size.width * 0.98,
                        height: 200,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: db
                                .where('uid', isEqualTo: uid)
                                .orderBy('time')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return const Text("loading");
                              return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot ds =
                                      snapshot.data!.docs[index];
                                  othername = ds['username'];
                                  otherurl = ds['userphoto'];
                                  dateofpost = ds['timeofpost'];
                                  posturl = ds['statusphoto'];
                                  status = ds['status'];
                                  bool photopresent = true;
                                  if (posturl == "null") {
                                    photopresent = false;
                                  }

                                  print(othername);
                                  //-------main container---------------
                                  return Container(
                                    margin: EdgeInsets.only(
                                        left: 3, right: 3, top: 6),
                                    padding: EdgeInsets.only(bottom: 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade400,
                                              spreadRadius: 2,
                                              blurRadius: 4,
                                              offset: Offset(1, 1))
                                        ]),
                                    child: Column(
                                      children: [
                                        posturl == 'null'
                                            ? Withoutphoto()
                                            : status == 'null'
                                                ? Withoutstatus()
                                                : WithStatusandPhoto(),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Visibility(
                                                  visible: photopresent,
                                                  child: TextButton(
                                                      onPressed: () {},
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                              Icons.visibility),
                                                          Text("View")
                                                        ],
                                                      )),
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      var id = db
                                                          .doc(ds.id)
                                                          .delete();
                                                      print(id);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.delete),
                                                        Text("Delete"),
                                                      ],
                                                    )),
                                              ],
                                            ))
                                      ],
                                    ),
                                  );
                                },
                              );
                            })),
                  )
                  //-----------logout Button
                  // MaterialButton(
                  //   onPressed: () async {
                  //     Future<SharedPreferences> _ref =
                  //         SharedPreferences.getInstance();
                  //     final ref = await _ref;
                  //     ref.clear().then((value) => Navigator.pushReplacement(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => LoginSignUp())));
                  //   },
                  //   child: Text('hello'),
                  //)
                ],
              ),
            ),
          ),
          //---------photo uploader button-------------
          Positioned(
              left: 130,
              top: 150,
              child: InkWell(
                onTap: () async {
                  // PopupOptionMenu();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ChangePhoto()));
                  //------------------
                  // print("photo");
                  // Getphoto();
                  // print("photoupload");
                  // firebase_storage.Reference reference = firebase_storage
                  //     .FirebaseStorage.instance
                  //     .ref()
                  //     .child('profile');
                  // UploadTask uploadTask = reference.putFile(imagefile);
                  // TaskSnapshot _snapshot = await uploadTask.snapshot;
                  // Newprofilepic =
                  //     await _snapshot.ref.getDownloadURL().toString();
                  // print(Newprofilepic);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.white, width: 3)),
                  child: Icon(Icons.add),
                ),
              )),
        ]));
  }
}
