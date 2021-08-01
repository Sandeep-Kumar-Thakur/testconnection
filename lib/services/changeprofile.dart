import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testconnection/services/allservices.dart';
import 'package:testconnection/sessionstore/sessionstore.dart';

class ChangePhoto extends StatefulWidget {
  const ChangePhoto({Key? key}) : super(key: key);

  @override
  _ChangePhotoState createState() => _ChangePhotoState();
}

class _ChangePhotoState extends State<ChangePhoto> {
  var file;
  late File imagefile;
  final _data = SessionStore.instance;
  late String name;
  late String email;
  late String uid;
  final date = DateTime.now();

  Future Getphoto() async {
    file = await ImagePicker.platform.getImage(source: ImageSource.camera);
    setState(() {
      if (file == null) {
      } else {
        imagefile = File(file.path);
      }
    });
  }

  Future Getdata() async {
    name = _data.NAME;
    uid = _data.UID;
    email = _data.EMAIL;
    print(name + uid + email);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  Getphoto();
                },
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(175),
                      border: Border.all(color: Colors.red, width: 3)),
                  child: file != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(150),
                          child: Image.file(imagefile))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                              size: 100,
                            )
                          ],
                        ),
                ),
              ),
              //---------uploader button-----------
              SizedBox(
                height: 20,
              ),
              IconButton(
                  iconSize: 50,
                  splashColor: Colors.green,
                  onPressed: () async {
                    //-----upload photo------------------
                    print("photo");

                    print("photoupload");
                    firebase_storage.Reference reference = firebase_storage
                        .FirebaseStorage.instance
                        .ref()
                        .child(uid);
                    UploadTask uploadTask = reference.putFile(imagefile);
                    TaskSnapshot _snapshot = await uploadTask.snapshot;
                    String Newprofilepic = await _snapshot.ref.getDownloadURL();
                    print(Newprofilepic);
                    // --------database updating---------------
                    CollectionReference db =
                        FirebaseFirestore.instance.collection('Profile');

                    var data = {
                      'Name': name,
                      'Profileurl': Newprofilepic,
                      'Uid': uid,
                      'Email': email,
                    };
                    db.doc(uid).collection('uid').doc('userinfo').set(data);
                    _data.Setprofileurl(Newprofilepic);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Allservices()));
                  },
                  icon: Icon(
                    Icons.check,
                    color: Colors.green,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
