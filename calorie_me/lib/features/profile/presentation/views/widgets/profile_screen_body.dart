import 'package:calorie_me/core/constants/constants.dart';
import 'package:calorie_me/features/home_screen/presentation/manager/home_screen_cubit.dart';
import 'package:calorie_me/features/profile/presentation/views/widgets/init_user_info_texts.dart';
import 'package:calorie_me/features/profile/presentation/views/widgets/painter.dart';
import 'package:calorie_me/features/profile/presentation/views/widgets/personal_info.dart';
import 'package:calorie_me/features/profile/presentation/views/widgets/profile_info.dart';
import 'package:calorie_me/features/profile/presentation/views/widgets/profile_photo.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../edit_profile/presentation/manager/profile_cubit/profile_cubit.dart';
import '../../../../edit_profile/presentation/views/widgets/edit_profile_btn.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeScreenCubit = HomeScreenCubit.get(context);
    var profileCubit = ProfileCubit.get(context);

    return BlocBuilder<HomeScreenCubit, HomeScreenStates>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: homeScreenCubit.userLogged != null,
          builder: (context) {
            var currentUser = homeScreenCubit.userLogged!;
            List<String> userInfoTexts =
                initUserInfoTexts(currentUser: currentUser);
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomPaint(
                    painter: profilePainter(),
                    child: Padding(
                      padding: EdgeInsets.only(top: 6.h, bottom: 2.h),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 3.w),
                            child: defaultIconButton(
                                icon: Icons.arrow_back_ios_new,
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 6.h,
                              bottom: 1.h,
                            ),
                            child: Column(
                              children: [
                                Center(
                                    child: profilePhoto(
                                  cubit: profileCubit,
                                  currentUser: currentUser,
                                  context: context,
                                  endRadius: 13.0.h,
                                  radius: 18.w,
                                  isProfileScreen: true,
                                )),
                                3.ph,
                                ProfileInfo(currentUser: currentUser),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        5.ph,
                        PersonalInfo(userInfoTexts: userInfoTexts),
                        7.ph,
                        editProfileBtn(context: context),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          fallback: (context) => defaultProgressIndicator(),
        );
      },
    );
  }
}
