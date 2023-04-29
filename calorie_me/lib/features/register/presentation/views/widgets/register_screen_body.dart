import 'package:calorie_me/features/register/presentation/manager/register_cubit/register_cubit.dart';
import 'package:calorie_me/features/register/presentation/views/widgets/choose_gender.dart';
import 'package:calorie_me/features/register/presentation/views/widgets/register_button.dart';
import 'package:calorie_me/features/register/presentation/views/widgets/row_below_reg_btn.dart';
import 'package:calorie_me/features/register/presentation/views/widgets/reg_text_form_fields_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/page_transition.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../edit_profile/presentation/views/widgets/text_form_fields_labels.dart';
import '../../../../login/presentation/views/login_screen.dart';

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController weightController = TextEditingController();
    TextEditingController heightController = TextEditingController();
    var registerCubit = RegisterCubit.get(context);
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          defaultToast(msg: 'Register Successfully');
          navigateTo(
              context: context,
              nextPage: const LoginScreen(),
              pageTransitionType: PageTransitionType.fade);
          registerCubit.clearGender();
          if (!registerCubit.isPass) {
            registerCubit.changePasswordVisibility();
          }
        } else if (state is RegisterErrorState) {
          defaultToast(
              msg: registerCubit.errorMessage,
              backgroundColor: Colors.black,
              toastLength: Toast.LENGTH_LONG);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 2.w, top: 5.h),
                  child: defaultIconButton(
                      icon: Icons.arrow_back_ios_new,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: defaultText(
                      text: "Register",
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                  child: Column(
                    children: [
                      textFormFieldsListView(
                        context: context,
                        textFormFieldsLabels: textFormFieldsLabels,
                        textFormFieldsIcons: registerTextFormFieldsIcons,
                        textFormFieldsList: regTextFormFieldsList(
                            context: context,
                            textFormFieldsLabels: textFormFieldsLabels,
                            usernameController: usernameController,
                            emailController: emailController,
                            passwordController: passwordController,
                            ageController: ageController,
                            weightController: weightController,
                            heightController: heightController,
                            cubit: registerCubit),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Icon(
                            Icons.person_add_sharp,
                            size: 19.sp,
                            color: Color(0xFF696969),
                          ),
                          SizedBox(width: 2.w),
                          defaultText(
                            text: "Gender",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF696969),
                                    ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      chooseGender(cubit: registerCubit, context: context),
                      SizedBox(height: 4.h),
                      if (state is RegisterLoadingState)
                        Center(
                            child: SpinKitFadingCircle(
                          color: defaultColor,
                        )),
                      if (state is! RegisterLoadingState)
                        registerButton(
                            registerCubit: registerCubit,
                            usernameController: usernameController,
                            emailController: emailController,
                            passwordController: passwordController,
                            ageController: ageController,
                            weightController: weightController,
                            heightController: heightController,
                            formKey: formKey),
                      SizedBox(height: 1.h),
                      rowBelowRegBtn(context, registerCubit),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
