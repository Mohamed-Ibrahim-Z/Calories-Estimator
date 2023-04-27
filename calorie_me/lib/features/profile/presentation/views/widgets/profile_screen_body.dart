import 'package:calorie_me/features/home_screen/presentation/manager/home_screen_cubit.dart';
import 'package:calorie_me/features/profile/presentation/views/widgets/init_user_info_texts.dart';
import 'package:calorie_me/features/profile/presentation/views/widgets/personal_info.dart';
import 'package:calorie_me/features/profile/presentation/views/widgets/profile_photo.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../edit_profile/presentation/manager/profile_cubit/profile_cubit.dart';
import '../../../../edit_profile/presentation/views/widgets/edit_profile_btn.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({Key? key}) : super(key: key);

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> profilePhotoAnimation, personalInfoAnimation;

  @override
  void initState() {
    super.initState();
    animateProfileScreen();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

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
              child: Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 4.5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SlideTransition(
                      position: profilePhotoAnimation,
                      child: Center(
                          child: profilePhoto(
                              cubit: profileCubit,
                              currentUser: currentUser,
                              context: context)),
                    ),
                    SlideTransition(
                      position: personalInfoAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          defaultText(
                            text: 'Personal Information',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: defaultColor,
                                  fontSize: 20.sp,
                                  letterSpacing: 1.5,
                                ),
                          ),
                          SizedBox(height: 2.h),
                          PersonalInfo(userInfoTexts: userInfoTexts),
                          editProfileBtn(context: context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          fallback: (context) => defaultCircularProgressIndicator(),
        );
      },
    );
  }

  void animateProfileScreen() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    profilePhotoAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    personalInfoAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }
}
