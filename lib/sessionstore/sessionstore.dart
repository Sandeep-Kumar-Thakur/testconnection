import 'package:flutter/foundation.dart';

class SessionStore {
  late String UID;
  late String NAME;
  late String EMAIL;
  late String PROFILEURL;

  SessionStore._privateconstructor();
  static final SessionStore instance = SessionStore._privateconstructor();

  Future Setname(String name) async {
    NAME = await name;
  }

  Future Setuid(String uid) async {
    UID = await uid;
  }

  Future Setemail(String email) async {
    EMAIL = await email;
    print(EMAIL);
  }

  Future Setprofileurl(String profileurl) async {
    PROFILEURL = await profileurl;
  }

  Future Getname() async {
    return NAME;
  }

  Future Getuid() async {
    return UID;
  }

  Future Getemail() async {
    return EMAIL;
    //print(Email);
  }

  Future Getprofileurl() async {
    return PROFILEURL;
  }
}
