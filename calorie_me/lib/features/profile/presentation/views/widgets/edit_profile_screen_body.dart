import 'package:calorie_me/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:calorie_me/features/profile/presentation/views/widgets/profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/widgets/widgets.dart';
import '../../../../login/presentation/manager/login_cubit/login_cubit.dart';
import '../../../../register/presentation/views/widgets/reg_text_form_fields_list.dart';

class EditProfileScreenBody extends StatelessWidget {
  const EditProfileScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ProfileCubit.get(context);
    var loginCubit = LoginCubit.get(context);
    var currentUser = LoginCubit.get(context).userLogged;
    TextEditingController usernameController =
        TextEditingController(text: currentUser!.userName ?? '');
    TextEditingController passwordController =
        TextEditingController(text: currentUser.password ?? '');
    TextEditingController emailController =
        TextEditingController(text: currentUser.email);
    TextEditingController ageController =
        TextEditingController(text: currentUser.age.toString());
    TextEditingController weightController =
        TextEditingController(text: currentUser.weight.toString());
    TextEditingController heightController =
        TextEditingController(text: currentUser.height.toString());
    return Scaffold(
      appBar: AppBar(
        title: defaultText(text: 'Edit Profile'),
      ),
      body: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is UpdateUserDataSuccessState) {
            loginCubit.getUserData();
            defaultToast(msg: 'Profile Updated Successfully');
            Navigator.pop(context);
          } else if (state is UpdateUserDataErrorState &&
              loginCubit.errorMessage != "") {
            defaultToast(
                msg: loginCubit.errorMessage, backgroundColor: Colors.red);
            // to avoid showing the same error message twice
            loginCubit.errorMessage = "";
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        profilePhoto(cubit: cubit, userLogged: currentUser),
                        CircleAvatar(
                            child: defaultIconButton(
                                icon: Icons.camera_alt_outlined,
                                onPressed: () {
                                  cubit.changeProfilePhoto();
                                }))
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h),
                  textFormFieldsListView(
                      textFormFieldsList: regTextFormFieldsList(
                          context: context,
                          usernameController: usernameController,
                          passwordController: passwordController,
                          emailController: emailController,
                          ageController: ageController,
                          weightController: weightController,
                          heightController: heightController,
                          cubit: loginCubit)),
                  SizedBox(height: 3.h),
                  if (state is UpdateUserDataLoadingState)
                    const Center(child: CircularProgressIndicator()),
                  if (state is! UpdateUserDataLoadingState)
                    defaultButton(
                        text: 'Save',
                        onPressed: () {
                          if (cubit.profileImagePath != null) {
                            cubit.updateProfilePhoto();
                          }
                          cubit.updateProfile(
                              username: usernameController.text,
                              password: passwordController.text,
                              email: emailController.text,
                              age: ageController.text,
                              weight: weightController.text,
                              height: heightController.text,
                              userLogged: currentUser);
                        }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
