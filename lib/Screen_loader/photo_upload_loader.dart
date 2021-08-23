import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:testconnection/services/allservices.dart';
import 'package:testconnection/sessionstore/sessionstore.dart';

class PhotoloaderScreenLoader extends StatefulWidget {
  File image;
  PhotoloaderScreenLoader({Key? key, required this.image}) : super(key: key);

  @override
  _PhotoloaderScreenLoaderState createState() =>
      _PhotoloaderScreenLoaderState(image: image);
}

class _PhotoloaderScreenLoaderState extends State<PhotoloaderScreenLoader> {
  File image;
  _PhotoloaderScreenLoaderState({required this.image});
  final _data = SessionStore.instance;
  late String name;
  late String email;
  late String uid;
  final date = DateTime.now();

  //--------get data form classs--------
  Future Getdata() async {
    name = _data.NAME;
    uid = _data.UID;
    email = _data.EMAIL;
    print(name + uid + email);
  }

  //---------upload photo into fire_storage And update the url for existing data base
  Future UploadPhoto() async {
    final reference =
        firebase_storage.FirebaseStorage.instance.ref().child(uid);
    final result = await reference.putFile(image);
    final Newprofilepic = await result.ref.getDownloadURL();
    print(Newprofilepic);
    // --------database updating---------------
    CollectionReference db = FirebaseFirestore.instance.collection('Profile');

    var data = {
      'Name': name,
      'Profileurl': Newprofilepic,
      'Uid': uid,
      'Email': email,
    };
    db.doc(uid).collection('uid').doc('userinfo').set(data);
    _data.Setprofileurl(Newprofilepic);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Allservices()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Getdata();
    UploadPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitCircle(
              color: Colors.green,
            ),
            AnimatedTextKit(
                animatedTexts: [TyperAnimatedText('Updating Profile.....')])
          ],
        ),
      ),
    );
  }
}
