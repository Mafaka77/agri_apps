import 'package:agri_farmers_app/MyColors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

class ReusableWidget {
  textBoxDecoration(String label) {
    return InputDecoration(
      isDense: true,
      errorBorder: errorBorderStyle(),
      focusedErrorBorder: errorBorderStyle(),
      enabledBorder: borderStyle(),
      focusedBorder: borderStyle(),
      label: Text(
        label,
        style: textBoxTextSyle(),
      ),
    );
  }

  dropDownDecoration(String label) {
    return DropDownDecoratorProps(
      baseStyle: textBoxTextSyle(),
      dropdownSearchDecoration: InputDecoration(
        errorBorder: errorBorderStyle(),
        focusedErrorBorder: errorBorderStyle(),
        enabledBorder: borderStyle(),
        focusedBorder: borderStyle(),
        contentPadding: const EdgeInsets.all(10),
        labelText: label,
        labelStyle: textBoxTextSyle(),
      ),
    );
  }

  labelTextStyle() {
    return TextStyle(fontSize: 12, color: MyColors.deepGreen);
  }

  Widget textBoxSpace() {
    return const SizedBox(
      height: 10,
    );
  }

  textBoxTextSyle() {
    return const TextStyle(
      fontSize: 13,
    );
  }

  borderStyle() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: MyColors.deepGreen),
    );
  }

  errorBorderStyle() {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    );
  }

  textHeadingStyle() {
    return TextStyle(
        fontSize: 30, fontWeight: FontWeight.bold, color: MyColors.deepGreen);
  }

  rawSnackBar(String message, Icon icon) {
    return Get.rawSnackbar(
      message: message,
      icon: icon,
      backgroundColor: Colors.black,
      snackPosition: SnackPosition.TOP,
      borderRadius: 10,
      snackStyle: SnackStyle.FLOATING,
      shouldIconPulse: true,
      barBlur: 20,
      margin: const EdgeInsets.only(
        top: 30,
        left: 40,
        right: 40,
      ),
      isDismissible: true,
      duration: const Duration(milliseconds: 3000),
    );
  }

  loader(BuildContext context) {
    Loader.show(context,
        // isSafeAreaOverlay: false,
        // isBottomBarOverlay: false,
        // overlayFromBottom: Get.height * 0.48,
        // overlayFromTop: Get.height * 0.48,
        overlayColor: Colors.transparent,
        progressIndicator: const CupertinoActivityIndicator(
          color: Colors.black,
          radius: 12,
        ),
        themeData: Theme.of(context).copyWith(
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.green)));
  }

  twoLine() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 3,
          color: MyColors.deepGreen,
        ),
        Container(
          width: 40,
          height: 3,
          color: Colors.grey,
        )
      ],
    );
  }
}
