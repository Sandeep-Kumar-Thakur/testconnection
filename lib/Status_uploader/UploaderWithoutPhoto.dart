import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:testconnection/services/allservices.dart';
import 'package:testconnection/sessionstore/sessionstore.dart';

class UploaderWithoutPhoto extends StatefulWidget {
  late String status;
  UploaderWithoutPhoto({Key? key, required this.status}) : super(key: key);

  @override
  _UploaderWithoutPhotoState createState() =>
      _UploaderWithoutPhotoState(status: status);
}

class _UploaderWithoutPhotoState extends State<UploaderWithoutPhoto> {
  late String status;
  _UploaderWithoutPhotoState({required this.status});
  late String Username;
  late String uid;
  late String userphoto;
  final date = DateTime.now();

  Future GetuserData() async {
    final _userdata = SessionStore.instance;
    Username = _userdata.NAME;
    uid = _userdata.UID;
    userphoto = _userdata.PROFILEURL;
  }

  Future UploadData(dateofpost) async {
    var data = {
      'uid': uid,
      'username': Username,
      'statusphoto': "null",
      'status': status,
      'userphoto': userphoto,
      'timeofpost': dateofpost,
      'time': DateTime.now()
    };
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Timeline');
    collectionReference.add(data);
    print("done without photo");
    Timer(Duration(seconds: 5), () => Nextpage());
  }

  Future Nextpage() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Allservices()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    GetuserData();
    UploadData(date.day.toString() +
        "-" +
        date.month.toString() +
        "-" +
        date.year.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDualRing(
          color: Colors.red,
        ),
      ),
    );
  }
}
