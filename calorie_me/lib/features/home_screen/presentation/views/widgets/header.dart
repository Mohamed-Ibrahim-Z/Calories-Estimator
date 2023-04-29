import 'package:calorie_me/features/edit_profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:calorie_me/features/register/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/widgets/widgets.dart';
import '../../../../profile/presentation/views/widgets/profile_photo.dart';

Widget header(
        {required BuildContext context,
        required UserModel currentUser,
        required ProfileCubit profileCubit}) =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              defaultText(
                  text: "CalorieMe",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black)),
              SizedBox(
                height: .5.h,
              ),
              defaultText(
                  text: "Hello, ${currentUser.userName!}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 17.sp,color: Colors.black)),
            ],
          ),
          profilePhoto(
              cubit: ProfileCubit.get(context),
              currentUser: currentUser,
              context: context),
        ],
      ),
    );
