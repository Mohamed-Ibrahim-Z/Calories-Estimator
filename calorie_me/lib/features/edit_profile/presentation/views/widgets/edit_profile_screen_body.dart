import 'package:calorie_me/features/edit_profile/presentation/views/widgets/edit_profile_photo.dart';
import 'package:calorie_me/features/register/data/model/user_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constants.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../login/presentation/manager/login_cubit/login_cubit.dart';
import '../../manager/profile_cubit/profile_cubit.dart';
import 'edit_profile_list_view.dart';

class EditProfileScreenBody extends StatelessWidget {
  const EditProfileScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileCubit = ProfileCubit.get(context);
    var loginCubit = LoginCubit.get(context);
    var currentUser = loginCubit.userLogged;
  GlobalKey key = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        title: defaultText(text: 'Edit Profile'),
      ),
      body: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, profileState) {
          if (profileState is UpdateUserDataSuccessState) {
            loginCubit.getUserData();
            defaultToast(msg: 'Profile Updated Successfully');
            Navigator.pop(context);
          } else if (profileState is UpdateUserDataErrorState &&
              loginCubit.errorMessage != "") {
            defaultToast(
                msg: loginCubit.errorMessage, backgroundColor: Colors.black);
          }
        },
        builder: (context, profileState) {
          return ConditionalBuilder(
            condition: loginCubit.userLogged != null,
            builder: (context) {
              TextEditingController usernameController =
                      TextEditingController(text: currentUser!.userName ?? ''),
                  passwordController =
                      TextEditingController(text: currentUser.password ?? ''),
                  emailController =
                      TextEditingController(text: currentUser.email),
                  ageController =
                      TextEditingController(text: currentUser.age.toString()),
                  weightController = TextEditingController(
                      text: currentUser.weight.toString()),
                  heightController = TextEditingController(
                      text: currentUser.height.toString());
              return SingleChildScrollView(
                child: Column(
                  children: [
                    editProfilePhoto(
                        profileCubit: profileCubit, currentUser: currentUser),
                    SizedBox(height: 3.h),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                      decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.circular(10)),
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
                          ),
                          SizedBox(height: 3.h),
                          if (profileState is UpdateUserDataLoadingState ||
                              profileState is UploadProfileImageLoadingState)
                            const Center(
                                child: SpinKitFadingCircle(
                              color: defaultColor,
                            )),
                          if (profileState is! UpdateUserDataLoadingState &&
                              profileState is! UploadProfileImageLoadingState)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: defaultButton(
                                  text: 'Save Changes',
                                  onPressed: () {
                                    UserModel updateUserModel = UserModel(
                                      userName: usernameController.text,
                                      password: passwordController.text,
                                      email: emailController.text,
                                      age: ageController.text,
                                      weight: weightController.text,
                                      height: heightController.text,
                                    );
                                    if (profileCubit.profileImagePath != null) {
                                      profileCubit.updateProfilePhoto(
                                          userModel: updateUserModel);
                                    } else {
                                      profileCubit.updateProfile(
                                          userModel: updateUserModel,
                                          currentUser: currentUser);
                                    }
                                  }),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            fallback: (context) => const Center(
              child: SpinKitFadingCircle(
                color: defaultColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
