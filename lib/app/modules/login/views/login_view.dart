import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lab_log/utils/logo.dart';

import '../../../../utils/textStyle.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            width: double.infinity,
            child: Column(
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'LabLog',
                    style: GoogleTextStyle.superLarge(),
                  ),
                ),
                Text(
                  'by Kavarera & Denisha',
                  style: GoogleTextStyle.regularWeb(),
                )
              ],
            ),
          ),
          SizedBox(
            height: 86,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Let\'s Get Started',
                style: GoogleTextStyle.largeWeb(),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            icon: SvgPicture.asset(
              LogoGoogle,
              width: 24,
            ),
            onPressed: () {
              controller.loginWithGoogle();
            },
            label: controller.isLoading.value
                ? CircularProgressIndicator(
                    color: Colors.black,
                  )
                : Text(
                    'Sign In With UPNVY Email',
                    style: GoogleTextStyle.buttonText(),
                  ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                overlayColor: MaterialStateProperty.all(Colors.white),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
