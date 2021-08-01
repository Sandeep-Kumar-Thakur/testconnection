import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testconnection/Status_uploader/Uploader.dart';
import 'package:testconnection/Status_uploader/UploaderWithoutPhoto.dart';

class Uploadstatus extends StatefulWidget {
  const Uploadstatus({Key? key}) : super(key: key);

  @override
  _UploadstatusState createState() => _UploadstatusState();
}

class _UploadstatusState extends State<Uploadstatus> {
  late File _imagefile;
  var imagevar;
  late String status = "null";

  Future GetPhoto() async {
    imagevar = await ImagePicker.platform.getImage(source: ImageSource.camera);
    setState(() {
      if (imagevar == null) {
      } else {
        print(imagevar.path);
        _imagefile = File(imagevar.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          margin: EdgeInsets.only(
              top: 10, left: MediaQuery.of(context).size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                //---------input field-------------------------
                child: TextField(
                  onChanged: (value) => {status = value},
                  maxLines: 16,
                  decoration: InputDecoration(
                      hintText: 'Write....',
                      border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //----------photo uploader container--------------
                    InkWell(
                      onTap: GetPhoto,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(50)),
                        child: imagevar != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(_imagefile),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_a_photo,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    'ADD Photo',
                                    style: TextStyle(color: Colors.blue),
                                  )
                                ],
                              ),
                      ),
                    ),
                    //----------uploader button------------------------------
                    //here we transfer data from this page to uploader page
                    InkWell(
                      onTap: () {
                        //shift control accounding to requiment
                        imagevar == null
                            ? Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UploaderWithoutPhoto(
                                          status: status,
                                        )))
                            : Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UploadingStatus(
                                          image: _imagefile,
                                          status: status,
                                          path: imagevar.path,
                                        )));
                      },
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Fire",
                                style: TextStyle(
                                    fontSize: 25, color: Colors.green),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.forward_outlined,
                                color: Colors.green,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
