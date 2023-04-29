import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/utils/page_transition.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../register/presentation/views/register_screen.dart';

Widget dontHaveAnAcc({required BuildContext context}) => defaultTextButton(
    context: context,
    child: defaultText(
        text: 'Don\'t have an account? ',
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 15.sp,
            )),
    onPressed: () {
      navigateTo(nextPage: RegisterScreen(), context: context);
    });
