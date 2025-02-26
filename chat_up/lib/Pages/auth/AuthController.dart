import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/model/user_model.dart';
import 'repository/AuthRepository.dart';

final authControllerProvider = Provider(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return AuthController(
      authRepository: authRepository,
      ref: ref,
    );
  },
);

final userInfoAuthProvider = FutureProvider(
  (ref) {
    final authCredential = ref.watch(authControllerProvider);
    return authCredential.getCurrentUserInfo();
  },
);

class AuthController {
  final AuthRepository authRepository;
  final Ref ref;
  AuthController({
    required this.ref,
    required this.authRepository,
  });
  void updateUserPresence() {
    return authRepository.updateUserPresence();
  }

  Future<UserModel?> getCurrentUserInfo() => authRepository.getCurrentUserInfo();

  void saveUserInfoToFirestore({
    required String userName,
    // required var profileImage,
    required BuildContext context,
    required bool mounted,
  }) {
    authRepository.saveUserInfoToFirestore(
      userName: userName,
      // profileImage: profileImage,
      ref: ref,
      context: context,
      mounted: mounted,
    );
  }

  void verifySmsCode({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async {
    authRepository.verifySmsCode(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: mounted);
  }

  void sendSmsCode(
      {required BuildContext context, required String phoneNumber}) async {
    authRepository.sendSmsCode(context: context, phoneNumber: phoneNumber);
  }
}
