import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../constants.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../manager/camera_cubit/camera_cubit.dart';

Future chooseImageDialog({required context,required CameraCubit cubit})=>showDialog(
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
            leading: const CircleAvatar(
              radius: 23,
              backgroundColor: defaultColor,
              child: Icon(
                Icons.camera_alt,
                size: 25,
                color: Colors.white,
              ),
            ),
            title: defaultText(
                text: 'Camera',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(
                  fontStyle: FontStyle.italic,
                )),
            onTap: () {
              Navigator.pop(context);
              cubit.pickImageFromCamera();
            },
          ),
          SizedBox(height: 1.h),
          ListTile(
            leading: const CircleAvatar(
              radius: 23,
              backgroundColor: defaultColor,
              child: Icon(
                Icons.image,
                size: 25,
                color: Colors.white,
              ),
            ),
            title: defaultText(
                text: 'Gallery',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(
                  fontStyle: FontStyle.italic,
                )),
            onTap: () {
              Navigator.pop(context);
              cubit.pickImageFromGallery();
            },
          ),
        ],
      ),
    );
  },
);