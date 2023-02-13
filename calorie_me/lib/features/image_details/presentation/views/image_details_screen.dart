import 'package:calorie_me/constants.dart';
import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:calorie_me/features/image_details/presentation/views/widgets/image_details_body.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home_layout/presentation/manager/camera_cubit/camera_cubit.dart';

class ImageDetails extends StatelessWidget {
  const ImageDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = CameraCubit.get(context);
    return BlocBuilder<CameraCubit, CameraState>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition:
              cubit.cameraImagePath != null || cubit.galleryImagePath != null,
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: defaultText(text: 'Image Details'),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            body: imageDetailsBody(context: context, cubit: cubit),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(color: defaultColor),
          ),
        );
      },
    );
  }
}
