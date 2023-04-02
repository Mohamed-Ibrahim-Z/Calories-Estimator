import 'package:calorie_me/features/profile/presentation/views/widgets/personal_info.dart';
import 'package:calorie_me/features/profile/presentation/views/widgets/profile_photo.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constants.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../edit_profile/presentation/manager/profile_cubit/profile_cubit.dart';
import '../../../../login/presentation/manager/login_cubit/login_cubit.dart';
import '../../../../edit_profile/presentation/views/widgets/edit_profile_btn.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loginCubit = LoginCubit.get(context);
    var profileCubit = ProfileCubit.get(context);

    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: loginCubit.userLogged != null,
          builder: (context) {
            var currentUser = loginCubit.userLogged!;
            List<String> userInfoTexts = [
              currentUser.userName!,
              currentUser.email,
              '${currentUser.weight} kg',
              '${currentUser.height} cm',
              '${currentUser.age} years',
              '${currentUser.gender}',
            ];
            return Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 4.5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: profilePhoto(
                          cubit: profileCubit, userLogged: currentUser)),
                  defaultText(
                    text: 'Personal Information',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
            );
          },
          fallback: (context) => defaultCircularProgressIndicator(),
        );
      },
    );
  }
}
