import 'package:animations/animations.dart';
import 'package:calorie_me/features/login/presentation/manager/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/widgets/widgets.dart';
import '../../../../register/presentation/views/widgets/choose_gender.dart';

Future extraInfoDialog({
  required BuildContext context,
  required LoginCubit cubit,
  required List<Widget> extraInfoTextFormFieldsList,
  required TextEditingController ageController,
  required TextEditingController weightController,
  required TextEditingController heightController,
}) {
  var formKey = GlobalKey<FormState>();
  return showModal(
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            // to close the keyboard when clicking outside the text field
            FocusScope.of(context).unfocus();
          },
          child: AlertDialog(
            backgroundColor: Theme.of(context).canvasColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                defaultText(
                  text: "Extra Info",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium,
                ),
                CircleAvatar(
                  radius: 15,
                  child: Center(
                    child: defaultIconButton(
                        icon: Icons.close,
                        onPressed: () {
                          Navigator.pop(context);
                          ageController.clear();
                          weightController.clear();
                          heightController.clear();
                          cubit.gender = '';
                        }),
                  ),
                )
              ],
            ),
            content: SizedBox(
              height: 45.h,
              width: 100.w,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return extraInfoTextFormFieldsList[index];
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 2.h,
                          );
                        },
                        itemCount: extraInfoTextFormFieldsList.length,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    BlocBuilder<LoginCubit, LoginStates>(
                      builder: (context, state) {
                        return chooseGender(cubit: cubit, context: context);
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    defaultButton(
                        text: 'Save',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (cubit.gender.isNotEmpty) {
                              cubit.addNewGoogleAccount(
                                  age: int.parse(ageController.text),
                                  weight: double.parse(weightController.text),
                                  height: double.parse(heightController.text));
                              Navigator.pop(context);
                            } else {
                              defaultToast(
                                  msg: "Please Select Your Gender",
                                  backgroundColor: Colors.red);
                            }
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
