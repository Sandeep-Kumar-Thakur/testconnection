import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testconnection/sessionstore/sessionstore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = FirebaseFirestore.instance.collection("Timeline");
  late String otherurl;
  late String posturl;
  late String status;
  late String dateofpost;
  late String othername;

  Widget WithStatusandPhoto() {
    return Container(
      margin: EdgeInsets.only(left: 3, right: 3, top: 6),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [Icon(Icons.visibility), Text("View")],
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget Withoutphoto() {
    return Container(
      margin: EdgeInsets.only(left: 3, right: 3, top: 6),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [Icon(Icons.visibility), Text("View")],
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget Withoutstatus() {
    return Container(
      margin: EdgeInsets.only(left: 3, right: 3, top: 6),
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

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [Icon(Icons.visibility), Text("View")],
                  )),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("SOCH soch KI BAAT ha")),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [Colors.blue.shade900, Colors.lightBlueAccent])),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: db.orderBy('time', descending: true).snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data!.docs[index];
                othername = ds['username'];
                otherurl = ds['userphoto'];
                dateofpost = ds['timeofpost'];
                posturl = ds['statusphoto'];
                status = ds['status'];

                print(othername);
                //-------main container---------------
                return posturl == 'null'
                    ? Withoutphoto()
                    : status == 'null'
                        ? Withoutstatus()
                        : WithStatusandPhoto();
              },
            );
          }),
    );
  }
}
