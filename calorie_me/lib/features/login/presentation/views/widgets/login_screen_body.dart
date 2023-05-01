import 'package:calorie_me/core/constants/constants.dart';
import 'package:calorie_me/core/utils/page_transition.dart';
import 'package:calorie_me/features/edit_profile/presentation/views/widgets/text_form_fields_labels.dart';
import 'package:calorie_me/features/home_layout/presentation/views/home_layout.dart';
import 'package:calorie_me/features/home_screen/presentation/manager/home_screen_cubit.dart';
import 'package:calorie_me/features/login/presentation/views/widgets/dont_have_an_acc.dart';
import 'package:calorie_me/features/login/presentation/views/widgets/extra_info_dialog.dart';
import 'package:calorie_me/features/login/presentation/views/widgets/forgot_password.dart';
import 'package:calorie_me/features/login/presentation/views/widgets/login_text_form_fields_list.dart';
import 'package:calorie_me/features/login/presentation/views/widgets/continue_with_google.dart';
import 'package:calorie_me/features/login/presentation/views/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    var loginCubit = LoginCubit.get(context);

    List<Widget> extraInfoTextFormFieldsList = regTextFormFieldsList(
      context: context,
      textFormFieldsLabels: textFormFieldsLabels.sublist(4),
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
              cubit: loginCubit,
              extraInfoTextFormFieldsList: extraInfoTextFormFieldsList,
              ageController: ageController,
              weightController: weightController,
              heightController: heightController);
        }
        if (state is LoginSuccessState) {
          homeScreenCubit.getUserData();
          homeScreenCubit.getMealsList();
          navigateToAndRemoveUntil(
            context: context,
            nextPage: const HomeLayout(),
          );
        } else if (state is LoginErrorState && loginCubit.errorMessage != "") {
          defaultToast(
              msg: loginCubit.errorMessage, backgroundColor: Colors.red);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(top: 12.h, left: 6.w, right: 6.w, ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                defaultText(
                    text: "Login",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 25.sp,
                        )),
                12.ph,
                loginTextFormFieldsList(
                    context: context,
                    emailController: emailController,
                    passwordController: passwordController,
                    cubit: loginCubit),
                1.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    dontHaveAnAcc(context: context),
                    forgotPassword(context: context),
                  ],
                ),
                state is LoginLoadingState ? 12.ph : 18.ph,
                loginButton(
                    loginCubit: loginCubit,
                    emailController: emailController,
                    passwordController: passwordController,
                    context: context,
                    state: state),
                if (state is! LoginLoadingState)
                  Column(
                    children: [
                      2.5.ph,
                      Center(
                        child: defaultText(
                          text: ' or ',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: 17.sp,
                                color: Colors.grey,
                              ),
                        ),
                      ),
                      // .5.ph,
                      continueWithGoogle(context, loginCubit),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
