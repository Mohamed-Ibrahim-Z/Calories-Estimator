import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:calorie_me/features/home_screen/presentation/views/widgets/custom_percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'widgets/meals_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    iconAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        customPercentIndicator(_animation, context),
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
            padding: EdgeInsets.only(top: 1.5.h),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: shaderMask(),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  void iconAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    controller!.repeat(reverse: true);
    _animation = Tween<double>(begin: 2, end: 50).animate(controller!)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
  }
}
