import 'package:calorie_me/core/utils/page_transition.dart';
import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:calorie_me/features/home_layout/presentation/views/home_layout.dart';
import 'package:calorie_me/features/image_details/presentation/views/widgets/image_details_body.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../camera_screen/presentation/manager/camera_cubit/camera_cubit.dart';

class ImageDetailsScreen extends StatelessWidget {
  const ImageDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = CameraCubit.get(context);
    return BlocConsumer<CameraCubit, CameraStates>(
      listener: (context, state) {
        if (state is PredictImageErrorState) {
          defaultToast(msg: cubit.errorMessage, backgroundColor: Colors.red);
          navigateToAndRemoveUntil(nextPage: HomeLayout(), context: context);
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            defaultToast(
                msg: 'Please use the back button to go back',
                backgroundColor: Colors.grey[600]!);
            return false;
          },
          child: SafeArea(
            child: Scaffold(
              body: backgroundAnimationStack(
                screenBody: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: cubit.cameraHeight,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.file(
                          cubit.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          ConditionalBuilder(
                            condition: cubit.tableRows.isNotEmpty,
                            builder: (context) => imageDetailsBody(
                              context: context,
                              cameraCubit: cubit,
                            ),
                            fallback: (context) => Padding(
                              padding: EdgeInsets.only(top: 7.h),
                              child: defaultCircularProgressIndicator(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
