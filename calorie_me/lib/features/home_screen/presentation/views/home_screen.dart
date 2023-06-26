import 'package:calorie_me/core/constants/constants.dart';
import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:calorie_me/features/edit_profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:calorie_me/features/home_screen/presentation/manager/home_screen_cubit.dart';
import 'package:calorie_me/features/home_screen/presentation/views/widgets/header.dart';
import 'package:calorie_me/features/home_screen/presentation/views/widgets/horizontal_calendar.dart';
import 'package:calorie_me/features/home_screen/presentation/views/widgets/meal_container.dart';
import 'package:calorie_me/features/home_screen/presentation/views/widgets/middle_bar.dart';
import 'package:calorie_me/features/home_screen/presentation/views/widgets/painter.dart';
import 'package:calorie_me/features/home_screen/presentation/views/widgets/undo_meal_snack_bar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../image_details/presentation/manager/camera_cubit/camera_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController? listController;
  Animation<Offset>? evenItemOfListAnimation;
  Animation<Offset>? oddItemOfListAnimation;
  ScrollController calendarScrollController = ScrollController();
  bool isScreenBuilt = false;

  @override
  void initState() {
    super.initState();
    listViewAnimation();
  }

  @override
  Widget build(BuildContext context) {
    var homeScreenCubit = HomeScreenCubit.get(context);
    return BlocBuilder<CameraCubit, CameraStates>(
      builder: (context, cameraState) {
        return BlocConsumer<HomeScreenCubit, HomeScreenStates>(
          listener: (context, state) {
            if (state is DeleteMealSuccessState) {
              undoMealSnackBar(
                  homeScreenCubit: homeScreenCubit, context: context);
            }
          },
          builder: (context, state) {
            return ConditionalBuilder(
              condition: homeScreenCubit.userLogged != null &&
                  state is! GetUserDataLoadingState &&
                  state is! GetMealsLoadingState,
              builder: (context) {
                var currentUser = homeScreenCubit.userLogged;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomPaint(
                        painter: Painter(),
                        child: Column(
                          children: [
                            header(
                                context: context,
                                currentUser: currentUser!,
                                profileCubit: ProfileCubit.get(context)),
                            3.ph,
                            middleBar(
                                context: context, currentUser: currentUser),

                          ],
                        ),
                      ),
                      5.ph,
                      Builder(builder: (context) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (!isScreenBuilt) {
                            scrollToRight();
                          }
                        });
                        return horizontalCalendar(
                            homeScreenCubit: homeScreenCubit,
                            calendarScrollController: calendarScrollController);
                      }),
                      3.ph,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: defaultText(
                                text: 'Daily Meals',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 20.sp,
                                    ))),
                      ),
                      1.ph,
                      state is ChangeSelectedDateLoadingState ||
                              cameraState is UploadImageLoadingState
                          ? defaultProgressIndicator(
                              boxFit: BoxFit.cover,
                              width: 47.w,
                              height: 15.h,
                            )
                          : mealContainer(
                              context: context,
                              homeScreenCubit: homeScreenCubit,
                              screenState: state,
                              listController: listController!,
                              evenItem: evenItemOfListAnimation!,
                              oddItem: oddItemOfListAnimation!),
                      3.ph,
                    ],
                  ),
                );
              },
              fallback: (context) => defaultProgressIndicator(
                boxFit: BoxFit.contain,
                height: 80.h,
                width: 80.w,
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    listController!.dispose();
    super.dispose();
  }

  void listViewAnimation() {
    listController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    evenItemOfListAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(listController!);
    oddItemOfListAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(listController!);
  }

  void scrollToRight() {
    if (calendarScrollController.hasClients) {
      calendarScrollController.animateTo(
        6 * 11.w,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      isScreenBuilt = true;
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    listController!.forward();
  }
}
