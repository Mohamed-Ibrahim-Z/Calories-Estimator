import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:calorie_me/constants.dart';
import 'package:calorie_me/core/utils/page_transition.dart';
import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:calorie_me/features/home_layout/presentation/views/widgets/choose_image_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../image_details/presentation/views/image_details_screen.dart';
import '../manager/bottom_nav_cubit/bottom_nav_cubit.dart';
import '../manager/camera_cubit/camera_cubit.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavStates>(
      builder: (context, state) {
        var cubit = BottomNavCubit.get(context);
        var cameraCubit = CameraCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
            leading: Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/85039719?v=4'),
              ),
            ),
            title: Padding(
              padding: EdgeInsets.only(top: 1.h),
              child: const Text(
                'Hello Hema!',
              ),
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: cubit.screens[cubit.currentIndex],
          floatingActionButton: BlocListener<CameraCubit, CameraState>(
            listener: (context, state) {
              if (state is CameraImagePickedSuccessState ||
                  state is GalleryImagePickedSuccessState) {
                pageTransition(nextPage: const ImageDetails());
              }
            },
            child: FloatingActionButton(
              backgroundColor: defaultColor,
              child: const Icon(Icons.camera_alt, size: 30),
              onPressed: () {
                chooseImageDialog(context: context, cubit: cameraCubit);
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
              borderColor: Colors.grey[300],
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              iconSize: 25,
              activeColor: defaultColor,
              icons: bottomNavIcons,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.smoothEdge,
              activeIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavScreen(index);
              }),
        );
      },
    );
  }
}
