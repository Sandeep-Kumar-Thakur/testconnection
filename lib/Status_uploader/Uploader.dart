import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:testconnection/services/allservices.dart';
import 'package:testconnection/sessionstore/sessionstore.dart';

class UploadingStatus extends StatefulWidget {
  late String status;
  late File image;
  late String path;
  UploadingStatus(
      {Key? key, required this.status, required this.image, required this.path})
      : super(key: key);

  @override
  _UploadingStatusState createState() =>
      _UploadingStatusState(status: status, image: image, path: path);
}

class _UploadingStatusState extends State<UploadingStatus> {
  late String status;
  late File image;
  late String path;
  _UploadingStatusState(
      {required this.status, required this.image, required this.path});

  late String Username;
  late String uid;
  late String userphoto;
  final date = DateTime.now();

  Future ReadyToUpload(dateofpost) async {
    print(dateofpost);

    // -----uploading photo-----------------
    final ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('image')
        .child('${DateTime.now()}');

    final result = await ref.putFile(image);
    //-----------download url of photo----------------
    final fileurl = await result.ref.getDownloadURL();
    print(fileurl);
    //---------set all data in var data
    var data = {
      'uid': uid,
      'username': Username,
      'status': status,
      'statusphoto': fileurl,
      'userphoto': userphoto,
      'timeofpost': dateofpost,
      'time': DateTime.now()
    };
    //---------upload status into firebase------------
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Timeline');
    collectionReference.add(data);
//--------navigate the control to all service---------------
    print("done");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Allservices()));
  }

//----fetching data from classes----------
  Future GetuserData() async {
    final _userdata = SessionStore.instance;
    Username = _userdata.NAME;
    uid = _userdata.UID;
    userphoto = _userdata.PROFILEURL;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    GetuserData();

    ReadyToUpload(
      date.day.toString() +
          "-" +
          date.month.toString() +
          "-" +
          date.year.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.blue,
        ),
      ),
    );
  }
}
