import 'package:calorie_me/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/widgets/widgets.dart';
import '../../../../register/data/model/user_model.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
    required this.currentUser,
  });

  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90.w,
          alignment: Alignment.center,
          child: FittedBox(
            child: defaultText(
              text: currentUser.userName!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                color: Colors.black,
                fontSize: 20.sp,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
        1.ph,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: FittedBox(
            child: defaultText(
              text: currentUser.email,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                fontSize: 17.sp,
                color: Colors.black54,
                fontFamily: GoogleFonts.roboto()
                    .fontFamily,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
