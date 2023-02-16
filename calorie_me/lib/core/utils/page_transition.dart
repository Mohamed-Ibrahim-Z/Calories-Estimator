import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void navigateTo(
        {required nextPage,
        required BuildContext context,
        PageTransitionType pageTransitionType = PageTransitionType.rightToLeft,
        int duration = 500}) =>
    Navigator.push(
        context,
        PageTransition(
          child: nextPage,
          type: pageTransitionType,
          ctx: context,
          duration: Duration(milliseconds: duration),
        ));
