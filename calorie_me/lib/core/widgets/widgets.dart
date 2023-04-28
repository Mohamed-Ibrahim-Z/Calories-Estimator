import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rive/rive.dart';

import '../constants/constants.dart';

Widget defaultText(
        {required String text,
        TextStyle? style,
        TextAlign? textAlign,
        int maxLines = 2,
        Key? textKey}) =>
    Text(
      text,
      key: textKey,
      textAlign: textAlign,
      style: style,
      maxLines: maxLines,
    );

Widget defaultIconButton(
        {required IconData icon,
        required Function() onPressed,
        Color? color,
        double? iconSize}) =>
    IconButton(
        padding: EdgeInsets.zero,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Icon(
          icon,
          color: color,
          size: iconSize,
        ),
        // color: Colors.white,
        onPressed: () {
          onPressed();
        });

Widget defaultButton({
  required String text,
  required Function() onPressed,
  Color textColor = Colors.black,
}) =>
    MaterialButton(
      onPressed: onPressed,
      color: defaultColor,
      textColor: textColor,
      minWidth: 80.w,
      height: 7.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: defaultText(text: text, style: TextStyle(fontSize: 17.sp)),
    );

Widget defaultTextFormField({
  Widget? prefixIcon,
  Widget? suffixIcon,
  bool isPassword = false,
  required String hintText,
  required controller,
  required TextInputType keyboardType,
  String? validationString,
  required BuildContext context,
  Color borderColor = Colors.grey,
  bool enableEditing = true,
  Function(String)? onFieldSubmitted,
}) =>
    TextFormField(
      style: Theme.of(context).textTheme.bodySmall,
      obscureText: isPassword,
      keyboardType: keyboardType,
      enabled: enableEditing,
      onFieldSubmitted: (value) {
        onFieldSubmitted!(value);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: enableEditing
            ? Colors.transparent
            : Theme.of(context).disabledColor,
        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).disabledColor,
            ),
        prefixIcon: prefixIcon,
        prefixIconColor: Theme.of(context).iconTheme.color,
        suffixIconColor: Theme.of(context).iconTheme.color,
        suffixIcon: suffixIcon,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: defaultBorderRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: defaultBorderRadius,
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: defaultBorderRadius,
          borderSide: BorderSide(color: borderColor),
        ),
      ),
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return '$validationString must not be empty';
        }
        return null;
      },
    );

Widget logoImage() => Image.asset(
      logoImagePath,
      width: 67.w,
    );

Future<bool?> defaultToast(
    {required String msg,
    Color textColor = Colors.white,
    double fontSize = 16,
    Color backgroundColor = Colors.deepOrange,
    Toast toastLength = Toast.LENGTH_SHORT}) {
  Fluttertoast.cancel();
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: toastLength,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: fontSize,
  );
}

Widget textFormFieldsListView({
  required List<Widget> textFormFieldsList,
  required List<String> textFormFieldsLabels,
  required List<IconData> textFormFieldsIcons,
  required BuildContext context,
}) {
  return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  textFormFieldsIcons[index],
                  size: 19.sp,
                  color: Color(0xFF696969),
                ),
                SizedBox(
                  width: 2.w,
                ),
                defaultText(
                  text: textFormFieldsLabels[index],
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF696969),
                      ),
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            textFormFieldsList[index],
          ],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 3.5.h);
      },
      itemCount: textFormFieldsList.length);
}

Widget backgroundAnimationStack({required Widget screenBody}) => Stack(
      children: [
        const RiveAnimation.asset(
          shapesRivePath,
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 15,
              sigmaY: 15,
            ),
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
        ),
        screenBody
      ],
    );

Widget defaultCircularProgressIndicator() => Center(
      child: SpinKitFadingCircle(
        color: defaultColor,
      ),
    );
