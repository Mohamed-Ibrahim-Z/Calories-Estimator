import 'package:calorie_me/constants.dart';
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
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
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
              top: 71.h,
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
                    cubit.pickPhotoFromCamera(value);
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
                    cubit.pickImageFromGallery();
                  },
                  iconSize: 24.sp,
                ),
              ),
            ),
            // Photo text
            Positioned(
              top: 73.h,
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
              top: 54.h,
              left: 0,
              child: Container(
                height: 1.h,
                width: 100.w,
                color: Colors.grey,
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
                  height: 55.h,
                  width: 100.h,
                ),
              ),
            ),
            // Credit Card Zone
            Positioned(
              top: 54.h,
              right: 0,
              left: 0,
              child: Showcase(
                key: creditCardKey,
                description: "Put your Credit Card in this zone",
                showArrow: true,
                tooltipBackgroundColor: defaultColor,
                textColor: Colors.white,
                scaleAnimationCurve: Curves.easeInOut,
                child: SizedBox(
                  height: 17.h,
                  width: 100.w,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
