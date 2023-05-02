import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/page_transition.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../home_layout/presentation/manager/bottom_nav_cubit/bottom_nav_cubit.dart';
import '../../../../home_layout/presentation/views/home_layout.dart';
import '../../../../home_screen/presentation/manager/home_screen_cubit.dart';
import '../../manager/camera_cubit/camera_cubit.dart';

Future selectMealType(
        {required BuildContext context, required CameraCubit cameraCubit}) =>
    showModal(
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 300),
        reverseTransitionDuration: Duration(milliseconds: 300),
      ),
      context: context,
      builder: (context) {
        return BlocBuilder<CameraCubit, CameraStates>(
          builder: (context, state) => AlertDialog(
              backgroundColor: Theme.of(context).canvasColor,
              shape: RoundedRectangleBorder(
                borderRadius: defaultBorderRadius,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  defaultText(
                      text: 'Select Meal Type',
                      style: Theme.of(context).textTheme.bodyMedium),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Center(
                      child: defaultIconButton(
                          icon: Icons.close,
                          color: Theme.of(context).iconTheme.color!,
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                  ),
                ],
              ),
              content: Container(
                width: 52.w,
                height: 40.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      crossAxisSpacing: 2.w,
                      mainAxisSpacing: 2.h,
                      children: List.generate(
                        mealsCategories.length,
                        (index) => Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            GestureDetector(
                              onTap: () {
                                cameraCubit.mealTypeSelected(index: index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: defaultBorderRadius,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  border: Border.all(
                                    color: index ==
                                            cameraCubit.selectedMealTypeIndex
                                        ? cameraCubit.mealTypeBorderColor
                                        : Theme.of(context).iconTheme.color!,
                                    width: 3,
                                  ),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      mealsCategoriesImages[index],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withOpacity(0.8),
                                ),
                                child: defaultText(
                                  text: mealsCategories[index],
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 16.sp,
                                      ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    defaultButton(
                        text: "Continue",
                        onPressed: () {
                          if (cameraCubit.selectedMealTypeIndex != -1) {
                            Navigator.pop(context);
                            BottomNavCubit.get(context)
                                .changeBottomNavScreen(0);
                            CameraCubit.get(context).uploadFullImage();
                            var homeScreenCubit = HomeScreenCubit.get(context);
                            homeScreenCubit.isCategorySelected = false;
                            homeScreenCubit.categoryOpacity = 1;
                            navigateToAndRemoveUntil(
                                nextPage: const HomeLayout(), context: context);
                          } else {
                            defaultToast(
                                msg: "Please select meal type",
                                backgroundColor: Colors.red);
                            return;
                          }
                        }),
                  ],
                ),
              )),
        );
      },
    );
