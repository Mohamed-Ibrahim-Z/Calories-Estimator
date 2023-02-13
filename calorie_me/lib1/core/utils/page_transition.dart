import 'package:page_transition/page_transition.dart';

PageTransition pageTransition(
        {required nextPage,
        PageTransitionType pageTransitionType = PageTransitionType.rightToLeft,
        int duration = 500}) =>
    PageTransition(
      child: nextPage,
      type: pageTransitionType,
      duration: Duration(milliseconds: duration),
    );
