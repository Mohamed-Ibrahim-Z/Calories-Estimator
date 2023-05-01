import 'package:calorie_me/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../login/presentation/manager/login_cubit/login_cubit.dart';

class ResetPasswordBody extends StatelessWidget {
  const ResetPasswordBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var resetPassCubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is ResetPasswordSuccessState) {
          defaultToast(msg: 'Check your email to reset your password');
          emailController.clear();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(top: 7.h, left: 5.w, right: 5.w, bottom: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                defaultIconButton(
                  icon: Icons.arrow_back,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                5.ph,
                defaultText(
                    text: 'Enter your email address to reset your password'),
                5.ph,
                defaultTextFormField(
                    hintText: 'Email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    borderColor: Colors.black,
                    context: context),
                5.ph,
                if (state is ResetPasswordLoadingState)
                  defaultProgressIndicator(
                    boxFit: BoxFit.contain,
                    width: 50.w,
                    height: 35.h,
                  ),
                if (state is! ResetPasswordLoadingState)
                  defaultButton(
                    text: 'Reset Password',
                    onPressed: () {
                      resetPassCubit.resetPassword(email: emailController.text);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
