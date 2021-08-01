import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthResult {
  FirebaseAuth auth = FirebaseAuth.instance;
  //create an new id============================================
  Future CreateID(email, password) async {
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    String uid = await user.user!.uid;
    return uid;
  }

  //forget password===========================================
  Future Forgetpassword(email) async {
    auth.sendPasswordResetEmail(email: email);
  }

  //Login
  Future Login(email, password) async {
    print(email + password);
    UserCredential user =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    print("hello");
    String uid = await user.user!.uid;
    print(uid);
    return uid;
  }
}
