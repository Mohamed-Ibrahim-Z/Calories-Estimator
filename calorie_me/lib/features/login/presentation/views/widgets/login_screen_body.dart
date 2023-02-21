import 'package:calorie_me/constants.dart';
import 'package:calorie_me/core/utils/page_transition.dart';
import 'package:calorie_me/features/home_layout/presentation/views/home_layout.dart';
import 'package:calorie_me/features/login/presentation/views/widgets/login_text_form_fields_list.dart';
import 'package:calorie_me/features/login/presentation/views/widgets/row_below_login_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../manager/login_cubit/login_cubit.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var cubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          cubit.getUserData();
          navigateTo(
              context: context,
              nextPage: const HomeLayout(),
              pageTransitionType: PageTransitionType.rightToLeft);
          defaultToast(msg: 'Login Successfully');
        } else if (state is LoginErrorState && cubit.errorMessage != "") {
          defaultToast(msg: cubit.errorMessage, backgroundColor: Colors.black);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(top: 10.h, left: 5.w, right: 5.w, bottom: 5.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logoImage(),
                SizedBox(height: 6.h),
                textFormFieldsListView(
                    context: context,
                    textFormFieldsList: loginTextFormFieldsList(
                        context: context,
                        emailController: emailController,
                        passwordController: passwordController,
                        cubit: cubit)),
                SizedBox(height: 6.h),
                if (state is LoginLoadingState)
                  const Center(
                      child: SpinKitFadingCircle(
                    color: defaultColor,
                  )),
                if (state is! LoginLoadingState)
                  defaultButton(
                      text: 'Login',
                      onPressed: () {
                        cubit.userLogin(
                            email: emailController.text,
                            password: passwordController.text);
                      }),
                SizedBox(height: 3.h),
                rowBelowLoginBtn(context),
              ],
            ),
          ),
        );
      },
    );
  }
}