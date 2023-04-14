import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:animations/animations.dart';
import 'package:calorie_me/core/constants/constants.dart';
import 'package:calorie_me/core/utils/page_transition.dart';
import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:calorie_me/features/camera_screen/presentation/views/camera_screen.dart';
import 'package:calorie_me/features/home_layout/presentation/views/widgets/choose_image_dialog.dart';
import 'package:calorie_me/features/home_layout/presentation/views/widgets/home_app_bar.dart';
import 'package:calorie_me/features/home_layout/presentation/views/widgets/shimmer_home_app_bar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../camera_screen/presentation/manager/camera_cubit/camera_cubit.dart';
import '../../../edit_profile/presentation/manager/profile_cubit/profile_cubit.dart';
import '../../../home_screen/presentation/manager/home_screen_cubit.dart';
import '../../../image_details/presentation/views/image_details_screen.dart';
import '../manager/bottom_nav_cubit/bottom_nav_cubit.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavCubit, BottomNavStates>(
      listener: (context, state) {
        if (state is BottomNavDoubleTapState) {
          defaultToast(
              msg: 'Tap again to exit', backgroundColor: Colors.blueGrey);
        }
      },
      builder: (context, bottomNavState) {
        var bottomNavCubit = BottomNavCubit.get(context);
        var profileCubit = ProfileCubit.get(context);
        var homeScreenCubit = HomeScreenCubit.get(context);
        var cameraCubit = CameraCubit.get(context);
        return SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: BlocBuilder<HomeScreenCubit, HomeScreenStates>(
                builder: (context, homeState) {
                  return ConditionalBuilder(
                    condition: homeScreenCubit.userLogged != null &&
                        homeScreenCubit.userLogged!.profilePhoto != null,
                    builder: (context) {
                      return homeAppBar(
                          context: context,
                          homeScreenCubit: homeScreenCubit,
                          profileCubit: profileCubit);
                    },
                    fallback: (context) {
                      return shimmerHomeAppBar();
                    },
                  );
                },
              ),
            ),
            resizeToAvoidBottomInset: false,
            body: WillPopScope(
              onWillPop: () async {
                return bottomNavCubit.doubleTapped();
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
            floatingActionButton: BlocListener<CameraCubit, CameraStates>(
              listener: (context, state) {
                if (state is ImagePickedSuccessState) {
                  navigateToAndRemoveUntil(
                      nextPage: ImageDetailsScreen(), context: context);
                  !newVersion
                      ? cameraCubit.cutImage()
                      : cameraCubit.predictImage();
                }
              },
              child: FloatingActionButton(
                backgroundColor: defaultColor,
                child: const Icon(Icons.camera_alt, size: 30),
                onPressed: () {
                  cameraCubit.clearTableRowsAndMealModel();
                  if (!newVersion) {
                    navigateTo(
                        nextPage: const CameraScreen(), context: context);
                  } else {
                    chooseImageDialog(
                        context: context, cubit: CameraCubit.get(context));
                  }
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
                icons: bottomNavCubit.bottomNavIcons,
                gapLocation: GapLocation.center,
                notchSmoothness: NotchSmoothness.smoothEdge,
                activeIndex: bottomNavCubit.currentIndex,
                onTap: (index) {
                  bottomNavCubit.changeBottomNavScreen(index);
                }),
          ),
        );
      },
    );
  }
}
