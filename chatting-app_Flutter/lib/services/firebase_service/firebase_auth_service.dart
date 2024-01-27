import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter_app_challenge/components/custom_snack_bar.dart';
import 'package:flash_chat_flutter_app_challenge/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter_app_challenge/constants.dart';
import 'firebase_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthService {
  final _auth = FirebaseAuth.instance;
  final BuildContext context;

  FirebaseAuthService({required this.context});

  User? getCurrentAuthUser() {
    User? user = _auth.currentUser;
    // print(user);
    if (user != null) {
      _updateSharedPref(true, user.email.toString());
    }
    return user;
    // var token = await _auth.currentUser?.getIdToken();
    // print(token);
    // _auth.currentUser?.updatePhotoURL('new/link/');
    // String? photo = _auth.currentUser?.photoURL;
    // print(photo);
    // await _auth.currentUser?.updateDisplayName('Test 1');
    // print(_auth.currentUser?.displayName);
    // MultiFactorSession? multiFactorSession =
    //     await _auth.currentUser?.multiFactor.getSession();
    // print(multiFactorSession?.id);
  }

  Future<void> _updateSharedPref(
      bool loggedUserStatus, String loggedUserEmail) async {
    loggedUserEmail = removeSpecialChar(loggedUserEmail);

    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool(kLoggedUserStatusKey, loggedUserStatus);
    await sharedPref.setString(kLoggedUserEmailKey, loggedUserEmail);

    setLoggedUserStatus(loggedUserStatus);
    setLoggedUserEmail(loggedUserEmail);
    // loggedUserData[kLoggedUserStatusKey] = loggedUserStatus;
    // loggedUserData[kLoggedUserEmailKey] = loggedUserEmail;
  }

  // void _updateSharedPref(bool loggedUserStatus, String loggedUserUid, String loggedUserName, String loggedUserEmail) async {
  //   final SharedPreferences sharedPref = await SharedPreferences.getInstance();
  //   await sharedPref.setBool(kLoggedUserStatusKey, loggedUserStatus);
  //   await sharedPref.setStringList(kLoggedUserDataKey, [loggedUserUid, loggedUserName, loggedUserEmail]);
  // }

  Future<void> logoutUser() async {
    await _auth.signOut();
    _updateSharedPref(false, '');
  }

  Future<User?> createUserWithPassword(
      {required String userEmail, required String userPassword}) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);

      final User? user = result.user;
      await _updateSharedPref(true, userEmail);

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == kErrorWeakPassword) {
        CustomSnackBar.showSnackBar(
            context, 'Password must have 6 character !!!');
      } else if (e.code == kErrorEmailAlreadyExist) {
        CustomSnackBar.showSnackBar(
            context, 'The account already exists for $userEmail');
      }
    } catch (e) {
      CustomSnackBar.showSnackBar(context, e.toString());
      print(e);
    }

    return null;
  }

  Future<User?> loginUserWithPassword(
      {required String userEmail, required String userPassword}) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);

      final User? user = result.user;
      await _updateSharedPref(true, userEmail);

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == kErrorWrongPassword) {
        CustomSnackBar.showSnackBar(context, 'Incorrect Email / Password !!!');
        print('Incorrect Email / Password !!!');
      } else if (e.code == kErrorUserNotFound) {
        CustomSnackBar.showSnackBar(
            context, '$userEmail user does not exist !!!');
        print('$userEmail user does not exist !!!');
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  // void showSnackBar(String msg) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(msg),
  //     width: (MediaQuery.of(context).size.width * 0.9),
  //     duration: Duration(milliseconds: 1500),
  //     behavior: SnackBarBehavior.floating,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(15.0),
  //     ),
  //   ));
  // }
}
