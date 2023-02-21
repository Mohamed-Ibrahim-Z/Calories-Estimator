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
    List<String> headerTexts = [
      'Username',
      'Email',
      'Weight',
      'Height',
      'Age',
      'Gender'
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.7,
      children: List.generate(
        headerTexts.length,
        (index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            defaultText(
              text: headerTexts[index],
              style: headerStyle,
            ),
            SizedBox(height: 0.5.h),
            defaultText(
              text: userInfoTexts[index],
              style: normalStyle,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
