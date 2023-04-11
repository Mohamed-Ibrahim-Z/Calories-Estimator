import 'package:calorie_me/core/constants/constants.dart';
import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:calorie_me/features/home_screen/presentation/manager/home_screen_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeScreenCubit = HomeScreenCubit.get(context);
    return BlocBuilder<HomeScreenCubit, HomeScreenStates>(
        builder: (context, state) {
      return ConditionalBuilder(
          condition: homeScreenCubit.userLogged != null &&
              state is! GetMealsLoadingState,
          builder: (context) {
            // draw line chart for calories consumed and calories remaining for current day
            return LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 0),
                      FlSpot(1, 0),
                      FlSpot(2, 0),
                      FlSpot(3, 0),
                      FlSpot(4, 0),
                      FlSpot(5, 5),
                      FlSpot(6, 0),
                      FlSpot(7, 0),
                      FlSpot(8, 0),
                      FlSpot(9, 0),
                      FlSpot(10, 0),
                      FlSpot(11, 0),
                      FlSpot(12, 0),
                      FlSpot(13, 0),
                      FlSpot(14, 0),
                      FlSpot(15, 0),
                      FlSpot(16, 0),
                      FlSpot(17, 0),
                      FlSpot(18, 0),
                      FlSpot(19, 0),
                      FlSpot(20, 0),
                      FlSpot(21, 0),
                      FlSpot(22, 0),
                      FlSpot(23, 0),
                    ],
                    isCurved: true,
                    barWidth: 5,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: false,
                    ),
                    belowBarData: BarAreaData(
                      show: true,

                    ),
                  ),
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 0),
                      FlSpot(1, 0),
                      FlSpot(2, 0),
                      FlSpot(3, 0),
                      FlSpot(4, 0),
                      FlSpot(5, 0),
                      FlSpot(6, 0),
                      FlSpot(7, 0),
                      FlSpot(8, 0),
                      FlSpot(9, 0),
                      FlSpot(10, 0),
                      FlSpot(11, 0),
                      FlSpot(12, 0),
                      FlSpot(13, 0),
                      FlSpot(14, 0),
                      FlSpot(15, 0),
                      FlSpot(16, 0),
                      FlSpot(17, 0),
                      FlSpot(18, 0),
                      FlSpot(19, 0),
            ],
              ),
            ],
          ),
            );
          },
          fallback: (context) => defaultCircularProgressIndicator());
    });
  }
}
