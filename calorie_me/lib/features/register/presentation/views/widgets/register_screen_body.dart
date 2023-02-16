import 'package:calorie_me/features/register/presentation/manager/register_cubit/register_cubit.dart';
import 'package:calorie_me/features/register/presentation/views/widgets/choose_gender.dart';
import 'package:calorie_me/features/register/presentation/views/widgets/row_below_reg_btn.dart';
import 'package:calorie_me/features/register/presentation/views/widgets/reg_text_form_fields_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/utils/page_transition.dart';
import '../../../../../core/widgets/widgets.dart';
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
    var cubit = RegisterCubit.get(context);
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          defaultToast(msg: 'Register Successfully');
          navigateTo(
              context: context,
              nextPage: const LoginScreen(),
              pageTransitionType: PageTransitionType.fade);
          cubit.clearGender();
          if (!cubit.isPass) {
            cubit.changePasswordVisibility();
          }
        } else if (state is RegisterErrorState) {
          defaultToast(
              msg: cubit.errorMessage,
              backgroundColor: Colors.red,
              toastLength: Toast.LENGTH_LONG);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logoImage(),
                  SizedBox(height: 4.h),
                  textFormFieldsListView(
                    textFormFieldsList: regTextFormFieldsList(
                        context: context,
                        usernameController: usernameController,
                        emailController: emailController,
                        passwordController: passwordController,
                        ageController: ageController,
                        weightController: weightController,
                        heightController: heightController,
                        cubit: cubit),
                  ),
                  SizedBox(height: 1.h),
                  chooseGender(cubit: cubit, context: context),
                  SizedBox(height: 1.h),
                  if (state is RegisterLoadingState)
                    const Center(child: CircularProgressIndicator()),
                  if (state is! RegisterLoadingState)
                    defaultButton(
                        text: 'Register',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (cubit.gender.isNotEmpty) {
                              cubit.userRegister(
                                userName: usernameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                age: ageController.text,
                                weight: weightController.text,
                                height: heightController.text,
                              );
                            } else {
                              defaultToast(
                                  msg: 'Please Select Your Gender',
                                  backgroundColor: Colors.red);
                            }
                          }
                        }),
                  SizedBox(height: 1.h),
                  rowBelowRegBtn(context, cubit),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
