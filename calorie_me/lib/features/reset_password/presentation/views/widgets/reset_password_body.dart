import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constants.dart';
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
        return Padding(
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
              SizedBox(height: 5.h),
              defaultText(
                  text: 'Enter your email address to reset your password'),
              SizedBox(height: 5.h),
              defaultTextFormField(
                  hintText: 'Email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  borderColor: Colors.black,
                  context: context),
              SizedBox(height: 5.h),
              if (state is ResetPasswordLoadingState)
                const SpinKitFadingCircle(
                  color: defaultColor,
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
        );
      },
    );
  }
}
