import 'package:calorie_me/features/edit_profile/presentation/views/widgets/edit_profile_photo.dart';
import 'package:calorie_me/features/edit_profile/presentation/views/widgets/text_form_fields_labels.dart';
import 'package:calorie_me/features/home_screen/presentation/manager/home_screen_cubit.dart';
import 'package:calorie_me/features/register/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../login/presentation/manager/login_cubit/login_cubit.dart';
import '../../../../profile/presentation/views/widgets/painter.dart';
import '../../manager/profile_cubit/profile_cubit.dart';
import 'edit_profile_list_view.dart';

class EditProfileScreenBody extends StatelessWidget {
  const EditProfileScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileCubit = ProfileCubit.get(context);
    var loginCubit = LoginCubit.get(context);
    var homeScreenCubit = HomeScreenCubit.get(context);
    var currentUser = homeScreenCubit.userLogged;
    TextEditingController usernameController =
            TextEditingController(text: currentUser!.userName ?? ''),
        passwordController =
            TextEditingController(text: currentUser.password ?? ''),
        emailController = TextEditingController(text: currentUser.email),
        ageController = TextEditingController(text: currentUser.age.toString()),
        weightController =
            TextEditingController(text: currentUser.weight.toString()),
        heightController =
            TextEditingController(text: currentUser.height.toString());
    return Scaffold(
      body: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is UpdateUserDataSuccessState) {
            homeScreenCubit.getUserData();
            Navigator.pop(context);
          } else if (state is UpdateUserDataErrorState &&
              loginCubit.errorMessage != "") {
            defaultToast(
                msg: loginCubit.errorMessage, backgroundColor: Colors.red);
          }
        },
        builder: (context, profileState) {
          return WillPopScope(
            onWillPop: () async {
              profileCubit.profileImagePath = null;
              return true;
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomPaint(
                    painter: profilePainter(),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 2.h),
                            child: defaultIconButton(
                                icon: Icons.arrow_back_ios_new,
                                color: Colors.black,
                                onPressed: () {
                                  profileCubit.profileImagePath = null;
                                  Navigator.pop(context);
                                }),
                          ),
                          editProfilePhoto(
                              profileCubit: profileCubit,
                              currentUser: currentUser,
                              context: context),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 5.h, left: 5.w, right: 5.w, bottom: 3.h),
                    child: Column(
                      children: [
                        editProfileListView(
                            usernameController: usernameController,
                            passwordController: passwordController,
                            emailController: emailController,
                            ageController: ageController,
                            weightController: weightController,
                            heightController: heightController,
                            loginCubit: loginCubit,
                            textFormFieldsLabels: textFormFieldsLabels),
                        profileState is UpdateUserDataLoadingState
                            ? 0.ph
                            : 3.ph,
                        if (profileState is UpdateUserDataLoadingState)
                          defaultProgressIndicator(
                            boxFit: BoxFit.contain,
                            width: 60.w,
                            height: 15.h,
                          ),
                        if (profileState is! UpdateUserDataLoadingState)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: defaultButton(
                                text: 'Save Changes',
                                onPressed: () {
                                  UserModel updateUserModel = UserModel(
                                    userName: usernameController.text,
                                    password: passwordController.text,
                                    email: emailController.text,
                                    age: int.parse(ageController.text),
                                    weight: double.parse(weightController.text),
                                    height: double.parse(heightController.text),
                                    uId: currentUser.uId,
                                    bmr: currentUser.bmr,
                                    profilePhoto: currentUser.profilePhoto,
                                    gender: currentUser.gender,
                                  );
                                  if (updateUserModel == currentUser &&
                                      profileCubit.profileImagePath == null) {
                                    defaultToast(
                                        msg: 'No Changes Made',
                                        backgroundColor: Colors.blueGrey);
                                    return;
                                  }
                                  profileCubit.updateUserInfo(
                                      updateUserModel: updateUserModel,
                                      currentUserModel: currentUser);
                                }),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
