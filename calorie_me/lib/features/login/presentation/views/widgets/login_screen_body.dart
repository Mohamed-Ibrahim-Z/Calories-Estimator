import 'package:calorie_me/core/utils/page_transition.dart';
import 'package:calorie_me/features/home_layout/presentation/views/home_layout.dart';
import 'package:calorie_me/features/home_screen/presentation/manager/home_screen_cubit.dart';
import 'package:calorie_me/features/login/presentation/views/widgets/extra_info_dialog.dart';
import 'package:calorie_me/features/login/presentation/views/widgets/login_text_form_fields_list.dart';
import 'package:calorie_me/features/login/presentation/views/widgets/row_below_login_btn.dart';
import 'package:calorie_me/features/reset_password/presentation/views/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../register/presentation/views/widgets/reg_text_form_fields_list.dart';
import '../../manager/login_cubit/login_cubit.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController(),
        passwordController = TextEditingController(),
        ageController = TextEditingController(),
        weightController = TextEditingController(),
        heightController = TextEditingController();
    var cubit = LoginCubit.get(context);

    List<Widget> extraInfoTextFormFieldsList = regTextFormFieldsList(
      context: context,
      ageController: ageController,
      weightController: weightController,
      heightController: heightController,
    ).sublist(3);
    var homeScreenCubit = HomeScreenCubit.get(context);
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is NewGoogleAccountState) {
          extraInfoDialog(
              context: context,
              cubit: cubit,
              extraInfoTextFormFieldsList: extraInfoTextFormFieldsList,
              ageController: ageController,
              weightController: weightController,
              heightController: heightController);
        }
        if (state is LoginSuccessState) {
          homeScreenCubit.getUserData();
          homeScreenCubit.getMealsList();
          navigateTo(
              context: context,
              nextPage: const HomeLayout(),
              pageTransitionType: PageTransitionType.rightToLeft);
          defaultToast(msg: 'Login Successfully');
        } else if (state is LoginErrorState && cubit.errorMessage != "") {
          defaultToast(msg: cubit.errorMessage, backgroundColor: Colors.red);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(top: 10.h, left: 5.w, right: 5.w, bottom: 5.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                logoImage(),
                SizedBox(
                  height: 5.h,
                ),
                textFormFieldsListView(
                    context: context,
                    textFormFieldsList: loginTextFormFieldsList(
                        context: context,
                        emailController: emailController,
                        passwordController: passwordController,
                        cubit: cubit)),
                SizedBox(
                  height: 1.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(color: Colors.black)),
                      ),
                      onPressed: () {
                        navigateTo(
                            nextPage: const ResetPasswordScreen(),
                            context: context);
                      },
                      child: defaultText(
                          text: 'Forgot Password?',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 17.sp,
                                  ))),
                ),
                SizedBox(
                  height: 3.h,
                ),
                if (state is LoginLoadingState)
                  defaultCircularProgressIndicator(),
                if (state is! LoginLoadingState)
                  defaultButton(
                      text: 'Login',
                      onPressed: () {
                        cubit.userLogin(
                            email: emailController.text,
                            password: passwordController.text);
                      }),
                SizedBox(
                  height: 1.h,
                ),
                rowBelowLoginBtn(context, cubit),
              ],
            ),
          ),
        );
      },
    );
  }
}
