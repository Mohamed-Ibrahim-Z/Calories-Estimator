import 'package:calorie_me/core/utils/page_transition.dart';
import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:calorie_me/features/home_layout/presentation/views/home_layout.dart';
import 'package:calorie_me/features/image_details/presentation/views/widgets/image_details_body.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../camera_screen/presentation/manager/camera_cubit/camera_cubit.dart';

class ImageDetailsScreen extends StatelessWidget {
  ImageDetailsScreen({Key? key}) : super(key: key);
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var cubit = CameraCubit.get(context);
    return BlocConsumer<CameraCubit, CameraStates>(
      listener: (context, state) {
        if (state is PredictImageErrorState) {
          defaultToast(
              msg: cubit.errorMessage,
              backgroundColor: Colors.red,
              toastLength: Toast.LENGTH_LONG);
          navigateToAndRemoveUntil(
              nextPage: const HomeLayout(), context: context);
        }
        if (state is DoubleTapState) {
          defaultToast(
            msg: 'Press again to exit',
            backgroundColor: Colors.blueGrey,
            textColor: Colors.white,
          );
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            bool isDoubleTap = cubit.doubleTapped();
            if (isDoubleTap) {
              navigateToAndRemoveUntil(
                  nextPage: const HomeLayout(), context: context);
            }
            return false;
          },
          child: SafeArea(
            child: Scaffold(
              body: backgroundAnimationStack(
                screenBody: CustomScrollView(
                  controller: scrollController,
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
                            builder: (context) {
                              // To wait for the table to be built before scrolling to the bottom
                              WidgetsBinding.instance.addPostFrameCallback(
                                  (_) => scrollToBottom());
                              return imageDetailsBody(
                                context: context,
                                cameraCubit: cubit,
                              );
                            },
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

  void scrollToBottom() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
