import 'package:calorie_me/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/widgets/widgets.dart';

class PersonalInfo extends StatelessWidget {
  List<String> userInfoTexts = [];

  PersonalInfo({Key? key, required this.userInfoTexts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var headerStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(letterSpacing: 1.3);
    var normalStyle = Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Colors.grey[500],
          fontSize: 17.sp,
          fontStyle: FontStyle.italic,
          letterSpacing: 1.3,
          overflow: TextOverflow.ellipsis,
        );
    List<String> headerTexts = ['Weight', 'Height', 'Age', 'Gender'];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 16 / 9,
      crossAxisSpacing: 3.w,
      mainAxisSpacing: 1.5.h,
      padding: EdgeInsets.zero,
      children: List.generate(
        headerTexts.length,
        (index) => Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: defaultBorderRadius,
            color: Color(0xFFFAF8F1),
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(profileInfoIcons[index]),
                  1.5.pw,
                  defaultText(
                    text: headerTexts[index],
                    style: headerStyle,
                  ),
                ],
              ),
              1.ph,
              defaultText(
                text: userInfoTexts[index],
                style: normalStyle,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
