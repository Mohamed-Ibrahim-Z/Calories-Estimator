import 'package:calorie_me/core/constants/constants.dart';
import 'package:calorie_me/features/camera_screen/presentation/manager/camera_cubit/camera_cubit.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../../../../core/widgets/widgets.dart';

class CameraScreenBody extends StatelessWidget {
  final CameraController cameraController;
  final CameraCubit cubit;

  const CameraScreenBody(
      {Key? key, required this.cameraController, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey dishKey = GlobalKey();
    GlobalKey creditCardKey = GlobalKey();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(context).startShowCase([dishKey, creditCardKey]);
    });
    return BlocConsumer<CameraCubit, CameraStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Stack(
          children: [
            // camera preview
            Positioned(
              height: cubit.cameraHeight,
              width: 100.w,
              child: CameraPreview(
                cameraController,
              ),
            ),
            // flash button
            Positioned(
              top: 6.h,
              left: 45.w,
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.5),
                radius: 24,
                child: defaultIconButton(
                    icon: cubit.flashIcon,
                    color: Colors.white,
                    iconSize: 24.sp,
                    onPressed: () {
                      cubit.toggleFlash(cameraController);
                    }),
              ),
            ),
            // black background
            Positioned(
              top: cubit.cameraHeight,
              left: 0,
              child: Container(
                height: 60.h,
                width: 100.w,
                color: Colors.black,
              ),
            ),
            // camera button
            Positioned(
              top: 81.h,
              left: 40.w,
              child: GestureDetector(
                onTap: () {
                  cameraController.takePicture().then((value) {
                    cubit.pickPhotoFromCameraPreview(value);
                  });
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.5),
                  radius: 4.7.h,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 4.h,
                  ),
                ),
              ),
            ),
            // close button
            Positioned(
              top: 83.h,
              left: 9.w,
              child: CircleAvatar(
                backgroundColor: Colors.grey.withOpacity(0.5),
                radius: 24,
                child: defaultIconButton(
                    icon: Icons.close,
                    color: Colors.white,
                    iconSize: 22.sp,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ),
            // gallery button
            Positioned(
              top: 82.h,
              right: 9.w,
              child: CircleAvatar(
                backgroundColor: Colors.grey.withOpacity(0.5),
                radius: 28,
                child: defaultIconButton(
                  icon: Icons.image,
                  color: Colors.white,
                  onPressed: () {
                    cubit.pickImage(isCamera: false);
                  },
                  iconSize: 24.sp,
                ),
              ),
            ),
            // Photo text
            Positioned(
              top: 74.h,
              left: 41.w,
              child: defaultText(
                  text: "Photo",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold)),
            ),
            // Horizontal line
            Positioned(
              top: (3 / 4) * cubit.cameraHeight,
              left: 0,
              right: 0,
              child: Container(
                height: .5.h,
                color: Colors.red,
              ),
            ),
            // Dish Zone
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Showcase(
                key: dishKey,
                description: "Put your dish in this zone",
                tooltipBackgroundColor: defaultColor,
                textColor: Colors.white,
                showArrow: true,
                scaleAnimationCurve: Curves.easeInOut,
                child: SizedBox(
                  height: 54.5.h,
                  width: 100.w,
                ),
              ),
            ),
            // Credit Card Zone
            Positioned(
              top: 57.h,
              left: 32.w,
              height: 12.h,
              width: 36.w,
              child: Showcase(
                key: creditCardKey,
                description: "Put your Credit Card in this zone",
                showArrow: true,
                targetPadding: EdgeInsets.zero,
                tooltipBackgroundColor: defaultColor,
                scaleAnimationCurve: Curves.easeInOut,
                child: Container(
                  height: 12.h,
                  width: 36.w,
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 3,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
