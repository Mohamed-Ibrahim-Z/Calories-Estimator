import 'package:calorie_me/features/camera_screen/presentation/manager/camera_cubit/camera_cubit.dart';
import 'package:calorie_me/features/camera_screen/presentation/views/widgets/camera_screen_body.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<CameraDescription> cameras = [];
  CameraController? cameraController;

  @override
  void initState() {
    startCamera();
    super.initState();
  }

  @override
  void dispose() {
    cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = CameraCubit.get(context);
    return cameraController != null
        ? Scaffold(
            body: ShowCaseWidget(
              builder: Builder(
                builder: (context) => CameraScreenBody(
                  cameraController: cameraController!,
                  cubit: cubit,
                ),
              ),
            ),
          )
        : Container();
  }

  void startCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.medium,
        enableAudio: false);
    await cameraController!.initialize();
    await cameraController!.setFlashMode(FlashMode.off);
    setState(() {});
  }
}
