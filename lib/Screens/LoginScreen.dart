import 'package:agri_farmers_app/Controllers/LoginController.dart';
import 'package:agri_farmers_app/MyColors.dart';
import 'package:agri_farmers_app/ReusableWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  ReusableWidget reusableWidget = ReusableWidget();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Center(
                    child: Image(
                      image: const AssetImage('images/login_logo.jpg'),
                      height: Get.height * 0.4,
                    ),
                  ),
                  TextFormField(
                    controller: controller.emailTextController,
                    decoration: InputDecoration(
                      enabledBorder: reusableWidget.borderStyle(),
                      focusedBorder: reusableWidget.borderStyle(),
                      label: Text(
                        'Email',
                        style: reusableWidget.textBoxTextSyle(),
                      ),
                    ),
                  ),
                  reusableWidget.textBoxSpace(),
                  Obx(
                    () => TextFormField(
                      obscureText: controller.passwordHide.value,
                      controller: controller.passwordTextController,
                      decoration: InputDecoration(
                        enabledBorder: reusableWidget.borderStyle(),
                        focusedBorder: reusableWidget.borderStyle(),
                        label: Text(
                          'Password',
                          style: reusableWidget.textBoxTextSyle(),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.passwordHide.isTrue
                                ? controller.passwordHide.value = false
                                : controller.passwordHide.value = true;
                            controller.update();
                          },
                          icon: Icon(
                            controller.passwordHide.isTrue
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                  ),
                  reusableWidget.textBoxSpace(),
                  MaterialButton(
                    elevation: 0,
                    height: 50,
                    color: MyColors.deepGreen,
                    minWidth: Get.width,
                    onPressed: () {
                      controller.login();
                    },
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
