import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:calorie_me/features/home_screen/presentation/manager/home_screen_cubit.dart';
import 'package:calorie_me/features/home_screen/presentation/views/widgets/custom_percent_indicator.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../camera_screen/presentation/manager/camera_cubit/camera_cubit.dart';
import 'widgets/meals_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController? iconController;
  Animation<double>? animationOfIcon;
  AnimationController? listController;
  Animation<Offset>? evenItemOfListAnimation;
  Animation<Offset>? oddItemOfListAnimation;

  @override
  void initState() {
    super.initState();
    iconAnimation();
    listViewAnimation();
  }

  @override
  Widget build(BuildContext context) {
    var homeScreenCubit = HomeScreenCubit.get(context);

    return BlocListener<CameraCubit, CameraStates>(
      listener: (context, cameraState) {
        if (cameraState is AddMealSuccessState) {
          defaultToast(
            msg: 'Meal Added Successfully',
          );
        }
      },
      child: BlocConsumer<HomeScreenCubit, HomeScreenStates>(
        listener: (context, state) {
          if (state is DeleteMealSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                content: defaultText(text: "Meal Deleted Successfully"),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    homeScreenCubit.undoDeleteMeal();
                  },
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ConditionalBuilder(
                condition: homeScreenCubit.userLogged != null &&
                    state is! GetMealsLoadingState,
                builder: (context) {
                  var currentUser = homeScreenCubit.userLogged;
                  return customPercentIndicator(
                      animationOfIcon, context, currentUser!);
                },
                fallback: (context) => SizedBox(
                    height: 37.h, child: defaultCircularProgressIndicator()),
              ),
              SizedBox(
                height: 2.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: defaultText(
                        text: 'Meals',
                        style: Theme.of(context).textTheme.bodyMedium)),
              ),
              SizedBox(
                height: 1.h,
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: homeScreenCubit.mealsList.isNotEmpty
                        ? shaderMask(
                            homeScreenCubit: homeScreenCubit,
                            state: state,
                            listViewAnimationController: listController!,
                            evenItem: evenItemOfListAnimation!,
                            oddItem: oddItemOfListAnimation!)
                        : Center(
                            child: defaultText(
                                text: 'No Meals Added Yet',
                                style:
                                    Theme.of(context).textTheme.bodyMedium))),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    iconController!.dispose();
    listController!.dispose();
    super.dispose();
  }

  void iconAnimation() {
    iconController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    iconController!.repeat(reverse: true);
    animationOfIcon = Tween<double>(begin: 2, end: 50).animate(iconController!)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
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

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    listController!.forward();
  }
}
