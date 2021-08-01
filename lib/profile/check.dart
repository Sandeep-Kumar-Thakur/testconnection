import 'package:flutter/material.dart';
import 'package:testconnection/sessionstore/sessionstore.dart';

class checkdata extends StatefulWidget {
  const checkdata({Key? key}) : super(key: key);

  @override
  _checkdataState createState() => _checkdataState();
}

class _checkdataState extends State<checkdata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () async {
            final _session = SessionStore.instance;
            late String email;
            email = await _session.EMAIL;
            print("here : " + email);
          },
          child: Text('press'),
        ),
      ),
    );
  }
}
