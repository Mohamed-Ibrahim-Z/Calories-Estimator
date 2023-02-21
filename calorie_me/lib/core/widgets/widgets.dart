import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants.dart';

Widget splashScreen({required Widget nextScreen}) => AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(logoImagePath),
          SizedBox(height: 6.h),
          SpinKitFadingCircle(
            color: Colors.white,
            size: 36.0.sp,
          ),
        ],
      ),
      nextScreen: nextScreen,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(seconds: 1),
      backgroundColor: defaultColor,
      splashIconSize: 700,
      curve: Curves.easeInOut,
      duration: 2000,
    );

Widget defaultText(
        {required String text,
        TextStyle? style,
        TextAlign? textAlign,
        int maxLines = 1}) =>
    Text(
      text,
      textAlign: textAlign,
      style: style,
      maxLines: maxLines,
    );

Widget defaultIconButton(
        {required IconData icon, required Function() onPressed}) =>
    IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Icon(icon),
        color: Colors.white,
        onPressed: () {
          onPressed();
        });

Widget defaultButton({
  required String text,
  required Function() onPressed,
}) =>
    MaterialButton(
      onPressed: onPressed,
      color: defaultColor,
      textColor: Colors.white,
      minWidth: 100.w,
      height: 7.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: defaultText(text: text, style: TextStyle(fontSize: 18.sp)),
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
}) =>
    TextFormField(
      style: Theme.of(context).textTheme.bodySmall,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic,
            ),
        prefixIcon: prefixIcon,
        prefixIconColor: Theme.of(context).iconTheme.color,
        suffixIconColor: Theme.of(context).iconTheme.color,
        suffixIcon: suffixIcon,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.grey),
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
      color: defaultColor,
    );

Future<bool?> defaultToast(
    {required String msg,
    Color textColor = Colors.white,
    double fontSize = 16,
    Color backgroundColor = defaultColor,
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

Widget textFormFieldsListView(
    {required List<Widget> textFormFieldsList, required BuildContext context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 8,
          blurRadius: 7,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return textFormFieldsList[index];
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 3.h);
        },
        itemCount: textFormFieldsList.length),
  );
}
