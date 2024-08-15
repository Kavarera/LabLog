import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_log/app/routes/app_pages.dart';
import 'package:lab_log/app/services/GoogleAuth.dart';

import '../../../data/UserData.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    Auth.signInWithSavedCredentials().then((value) {
      if (value != null) {
        if (value.email != null &&
            value.email!.endsWith("@student.upnyk.ac.id")) {
          UserData().setUserData(value.displayName, value.email);
          Get.offAllNamed(Routes.HOME, arguments: [
            {'userData': UserData()}
          ]);
        }
      }
    }).catchError((onError) {
      Get.snackbar(
        'Session Expired',
        'Your session is expired',
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: 5,
        duration: const Duration(seconds: 1),
      );
      print(onError.toString());
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void loginWithGoogle() async {
    isLoading.value = true;
    try {
      User? user = await Auth.signInWithGoogle();
      if (user != null) {
        if (user.email != null &&
            user.email!.endsWith("@student.upnyk.ac.id")) {
          UserData().setUserData(user.displayName, user.email);
          Get.offAllNamed(Routes.HOME, arguments: [
            {'userData': UserData()}
          ]);
        } else {
          Get.snackbar(
            'Invalid Email',
            'Use your campus email',
            backgroundColor: Color.fromRGBO(255, 255, 255, 1),
            borderRadius: 5,
            duration: const Duration(seconds: 1),
          );
        }
      } else {
        Get.snackbar('Error', 'Email invalid');
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Color.fromRGBO(255, 25, 25, 1),
        colorText: Colors.black,
        borderRadius: 5,
        duration: const Duration(seconds: 1),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
