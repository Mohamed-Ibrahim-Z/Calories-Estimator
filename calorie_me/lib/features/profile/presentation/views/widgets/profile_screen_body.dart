import 'package:calorie_me/features/profile/presentation/views/widgets/profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constants.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../login/presentation/manager/login_cubit/login_cubit.dart';
import '../../manager/profile_cubit/profile_cubit.dart';
import 'edit_profile_btn.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loginCubit = LoginCubit.get(context);
    var profileCubit = ProfileCubit.get(context);
    var headerStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(letterSpacing: 1.3);
    var normalStyle = Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Colors.grey[500],
          fontSize: 17.sp,
          fontStyle: FontStyle.italic,
          letterSpacing: 1.3,
        );
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 4.5.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: profilePhoto(cubit: profileCubit,
                  userLogged: loginCubit.userLogged!)),
              SizedBox(height: 2.h),
              defaultText(
                text: 'Personal Information',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: defaultColor,
                      fontSize: 20.sp,
                      letterSpacing: 1.5,
                    ),
              ),
              SizedBox(height: 1.h),
              defaultText(
                text: 'Username',
                style: headerStyle,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w),
                child: defaultText(
                    text: loginCubit.userLogged!.userName!, style: normalStyle),
              ),
              defaultText(
                text: 'Email',
                style: headerStyle,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: defaultText(
                      text: loginCubit.userLogged!.email, style: normalStyle)),
              defaultText(text: 'Weight', style: headerStyle),
              Padding(
                padding: EdgeInsets.only(left: 2.w),
                child: defaultText(
                  text: '${loginCubit.userLogged!.weight} kg',
                  style: normalStyle,
                ),
              ),
              defaultText(text: 'Height', style: headerStyle),
              Padding(
                padding: EdgeInsets.only(left: 2.w),
                child: defaultText(
                  text: '${loginCubit.userLogged!.height} cm',
                  style: normalStyle,
                ),
              ),
              defaultText(text: 'Age', style: headerStyle),
              Padding(
                padding: EdgeInsets.only(left: 2.w),
                child: defaultText(
                  text: '${loginCubit.userLogged!.age} years',
                  style: normalStyle,
                ),
              ),
              editProfileBtn(context: context),
            ],
          ),
        );
      },
    );
  }
}
