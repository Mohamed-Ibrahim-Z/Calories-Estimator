import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../camera_screen/presentation/manager/camera_cubit/camera_cubit.dart';

Future chooseImageDialog({required context, required CameraCubit cubit}) =>
    showModal(
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 300),
        reverseTransitionDuration: Duration(milliseconds: 300),
      ),
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).canvasColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: defaultText(
              text: 'Choose an option',
              style: Theme.of(context).textTheme.bodyLarge),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 23,
                  backgroundColor: defaultColor,
                  child: Icon(
                    Icons.camera_alt,
                    size: 25,
                    color: Colors.black,
                  ),
                ),
                title: defaultText(
                    text: 'Camera',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontStyle: FontStyle.italic,
                        )),
                onTap: () {
                  Navigator.pop(context);
                  cubit.pickImage(isCamera: true);
                },
              ),
              1.ph,
              ListTile(
                leading: CircleAvatar(
                  radius: 23,
                  backgroundColor: defaultColor,
                  child: Icon(
                    Icons.image,
                    size: 25,
                    color: Colors.black,
                  ),
                ),
                title: defaultText(
                    text: 'Gallery',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontStyle: FontStyle.italic,
                        )),
                onTap: () {
                  Navigator.pop(context);
                  cubit.pickImage(isCamera: false);
                },
              ),
            ],
          ),
        );
      },
    );
