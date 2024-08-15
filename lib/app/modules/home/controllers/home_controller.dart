import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lab_log/app/data/KelasResponse.dart';
import 'package:lab_log/app/data/UserData.dart';
import 'package:lab_log/app/routes/app_pages.dart';
import 'package:lab_log/app/services/DataService.dart';
import 'package:lab_log/app/services/GoogleAuth.dart';

class HomeController extends GetxController {
  UserData _userData = UserData();
  var isTokenCheckerActive = false.obs;
  DataService _dataService = DataService();

  var kelasResponse = KelasResponse().obs;

  @override
  void onInit() {
    super.onInit();
    if (UserData().displayName == null) {
      loadData();
    }
    //for gettin practicum data
    _getPracticumData();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _getPracticumData() {
    //event listener for updating changes, so UI Automatically updated
    try {
      if (UserData().displayName != null) {
        _dataService
            .getDataStream(UserData().email!.split('@')[0])
            .listen((event) {
          if (event.snapshot.value != null) {
            try {
              Map<dynamic, dynamic> values =
                  event.snapshot.value as Map<dynamic, dynamic>;
              kelasResponse.value = KelasResponse.fromSnapshot(values);
            } catch (e) {
              print(e);
            }
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _relogin() async {
    Auth.signInWithSavedCredentials().then((value) {
      if (value != null) {
        if (value.email != null &&
            value.email!.endsWith("@student.upnyk.ac.id")) {
          _userData.setUserData(value.displayName, value.email);
          isTokenCheckerActive.value = false;
          _getPracticumData();
        }
      } else {
        isTokenCheckerActive.value = false;
        Get.snackbar(
          'Session Expired',
          'Your session is expired',
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: 5,
          duration: const Duration(seconds: 1),
        );
        Get.offAllNamed(Routes.LOGIN);
      }
    });
  }

  void loadData() async {
    try {
      if (Get.arguments == null) {
        isTokenCheckerActive.value = true;
        await _relogin();
      } else {
        _userData = Get.arguments[0]['userData'];
      }
    } catch (e) {
      print(e);
    }
  }

  String? getDisplayName() {
    if (_userData.displayName != null) {
      return _userData.displayName!;
    } else {
      Get.offAllNamed(Routes.LOGIN);
      return null;
    }
  }

  void signOut() async {
    await Auth.googleSignOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
