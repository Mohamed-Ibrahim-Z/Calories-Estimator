import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:animations/animations.dart';
import 'package:calorie_me/constants.dart';
import 'package:calorie_me/core/utils/page_transition.dart';
import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:calorie_me/features/home_layout/presentation/views/widgets/choose_image_dialog.dart';
import 'package:calorie_me/features/home_layout/presentation/views/widgets/home_app_bar.dart';
import 'package:calorie_me/features/home_layout/presentation/views/widgets/shimmer_home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../edit_profile/presentation/manager/profile_cubit/profile_cubit.dart';
import '../../../image_details/presentation/views/image_details_screen.dart';
import '../../../login/presentation/manager/login_cubit/login_cubit.dart';
import '../manager/bottom_nav_cubit/bottom_nav_cubit.dart';
import '../manager/camera_cubit/camera_cubit.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavStates>(
      builder: (context, bottomNavState) {
        var bottomNavCubit = BottomNavCubit.get(context);
        var loginCubit = LoginCubit.get(context);
        var profileCubit = ProfileCubit.get(context);
        var cameraCubit = CameraCubit.get(context);
        return BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, loginState) {
            // TODO: implement listener
          },
          builder: (context, loginState) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(9.h),
                child: loginCubit.userLogged != null
                    ? homeAppBar(
                        context: context,
                        loginCubit: loginCubit,
                        profileCubit: profileCubit)
                    : shimmerHomeAppBar(),
              ),
              resizeToAvoidBottomInset: false,
              body: WillPopScope(
                onWillPop: () async {
                  bool isDoubleTapped = bottomNavCubit.doubleTapped();
                  if (bottomNavCubit.currentIndex != 0) {
                    bottomNavCubit.changeBottomNavScreen(0);
                  } else if (isDoubleTapped) {
                    return true;
                  } else {
                    defaultToast(
                        msg: 'Double Tap To Exit',
                        backgroundColor: Colors.grey[600]!);
                  }
                  return false;
                },
                child: PageTransitionSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation, secondaryAnimation) {
                    return FadeThroughTransition(
                      fillColor: Colors.transparent,
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      child: child,
                    );
                  },
                  child: bottomNavCubit.screens[bottomNavCubit.currentIndex],
                ),
              ),
              floatingActionButton: BlocListener<CameraCubit, CameraState>(
                listener: (context, state) {
                  if (state is CameraImagePickedSuccessState ||
                      state is GalleryImagePickedSuccessState) {
                    navigateTo(
                        nextPage: const ImageDetails(), context: context);
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
                  backgroundColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor,
                  iconSize: 25,
                  activeColor: defaultColor,
                  icons: bottomNavCubit.bottomNavIcons,
                  gapLocation: GapLocation.center,
                  notchSmoothness: NotchSmoothness.smoothEdge,
                  activeIndex: bottomNavCubit.currentIndex,
                  onTap: (index) {
                    bottomNavCubit.changeBottomNavScreen(index);
                  }),
            );
          },
        );
      },
    );
  }
}
