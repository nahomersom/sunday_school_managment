import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/login_response.dart';

class FirbaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      // await InternetAddress.lookup('example.com');
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print("userrrrrrrr/n");
      print(result.user);
      if (result.user != null) {
        return result.user!;
      } else {
        throw Exception("invalid login");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw Exception('network request failed please try agnain');
      } else {
        throw Exception('invalid email or password please try again');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<LoginResponse> signInWithPhone(String phone) async {
    User? user;
    String? verificationId;
    String status = "";
    FirebaseAuthException? exception;
    return await _auth
        .verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!

        // Sign the user in (or link) with the auto-generated credential
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        status = "authenticated";
        user = userCredential.user;
      },
      verificationFailed: (FirebaseAuthException e) {
        status = "verification-failed";
        exception = e;
      },
      codeSent: (String verificationId, int? resendToken) {
        print("code-sent");

        status = "code-sent";
        verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("here");
        print(status);
      },
    )
        .then((_) {
      print("then-----------${status}");

      return LoginResponse(
          status: status,
          user: user,
          exception: exception,
          verificationId: verificationId);
    });
  }

  Future<PhoneAuthCredential?> verifySmsCode(
      String verificationId, smsCode) async {
    return PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
  }

  Future<String?> signUpWithEmailAndPassword(
      String email, String password) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return result.user?.uid;
  }

  Future<void> signOut() async {
    try {
      await SharedPreferences.getInstance().then((value) => value.clear());
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
