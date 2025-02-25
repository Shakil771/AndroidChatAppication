import 'package:chat_up/core/helper/ShowAlertDialog.dart';
import 'package:chat_up/core/helper/ShowLoadingDialog.dart';
import 'package:chat_up/core/model/user_model.dart';
// import 'package:chat_up/core/repository/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../routes/Routes.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
    realtime: FirebaseDatabase.instance,
  );
});

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseDatabase realtime;

  AuthRepository({
    required this.realtime,
    required this.auth,
    required this.firestore,
  });

  void updateUserPresence() async {
    Map<String, dynamic> online = {
      'active': true,
      'lastSeen': DateTime.now().microsecondsSinceEpoch,
    };
    Map<String, dynamic> ofline = {
      'active': false,
      'lastSeen': DateTime.now().microsecondsSinceEpoch,
    };
    final connectedRef = realtime.ref('.info/connected');

    connectedRef.onValue.listen(
      (event) async {
        final isConnected = event.snapshot.value as bool? ?? false;
        if (isConnected) {
          await realtime.ref().child(auth.currentUser!.uid).update(online);
        } else {
          realtime
              .ref()
              .child(auth.currentUser!.uid)
              .onDisconnect()
              .update(online,);
        }
      },
    );
  }

  Future<UserModel?> getCurrentUserInfo() async {
    UserModel? user;
    final userInfo =
        await firestore.collection("user").doc(auth.currentUser?.uid).get();
    if (userInfo.data() == null) return user;
    user = UserModel.fromMap(userInfo.data()!);
    return user;
  }

  void saveUserInfoToFirestore({
    required String userName,
    // required var profileImage,
    required Ref ref,
    required BuildContext context,
    required bool mounted,
  }) async {
    try {
      showLoadingDialog(context: context, message: "Saving user info ...");
      String uid = auth.currentUser!.uid;
      // String profileImageUrl = profileImageUrl is String ? profileImage : '';
      // if (profileImage != null && profileImage is! String) {
      //   profileImageUrl = await ref
      //       .read(firebaseStorageRepositoryProvider)
      //       .storeFileToFirebase('profileImage/$uid', profileImage);
      // }
      UserModel user = UserModel(
        userName: userName,
        uid: uid,
        // profileImageUrl: profileImageUrl,
        active: true,
        lastSeen: DateTime.now().microsecondsSinceEpoch,
        phoneNumber: auth.currentUser!.phoneNumber!,
        groupId: [],
      );
      firestore.collection('users').doc(uid).set(user.toMap());
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.home,
        (route) => false,
      );
    } catch (e) {
      Navigator.pop(context);
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void verifySmsCode({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async {
    try {
      showLoadingDialog(context: context, message: "Verifying code ...");
      final credential = PhoneAuthProvider.credential(
          verificationId: smsCodeId, smsCode: smsCode);
      await auth.signInWithCredential(credential);
      UserModel? user = await getCurrentUserInfo();

      if (!mounted) return;

      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.userInfo,
        (route) => false,
        // arguments: user?.profileImageUrl
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void sendSmsCode(
      {required BuildContext context, required String phoneNumber}) async {
    try {
      showLoadingDialog(
          context: context,
          message: "Sending a verification code to $phoneNumber");
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            showAlertDialog(context: context, message: e.toString());
          },
          codeSent: (smsCodeId, resendSmsCodeId) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.verification, (route) => false,
                arguments: {
                  "phoneNumber": phoneNumber,
                  "smsCodeId": smsCodeId,
                });
          },
          codeAutoRetrievalTimeout: (String smsCodeId) {});
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showAlertDialog(context: context, message: e.toString());
    }
  }
}
