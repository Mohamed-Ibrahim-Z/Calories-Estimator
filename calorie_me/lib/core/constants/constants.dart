import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(213, 251, 215, 1),
  100: Color.fromRGBO(213, 251, 215, 1),
  200: Color.fromRGBO(213, 251, 215, 1),
  300: Color.fromRGBO(213, 251, 215, 1),
  400: Color.fromRGBO(213, 251, 215, 1),
  500: Color.fromRGBO(213, 251, 215, 1),
  600: Color.fromRGBO(213, 251, 215, 1),
  700: Color.fromRGBO(213, 251, 215, 1),
  800: Color.fromRGBO(213, 251, 215, 1),
  900: Color.fromRGBO(213, 251, 215, 1),
};
MaterialColor defaultColor = MaterialColor(0xd5fbd758, color);
Color backgroundColor = Color(0xFFFAF8F1);
const logoImagePath = 'assets/images/logo.png';
const googleImagePath = 'assets/images/Google.png';
const shapesRivePath = 'assets/shapes.riv';

String defaultMaleProfilePhoto =
    'https://www.pngitem.com/pimgs/m/419-4196791_transparent-confused-man-png-default-profile-png-download.png';
String defaultFemaleProfilePhoto =
    'https://simg.nicepng.com/png/small/249-2492113_work-profile-user-default-female-suit-comments-default.png';
dynamic isGoogleAccount = false;
dynamic loggedUserID = '';
const baseUrl = 'http://calorieme.francecentral.cloudapp.azure.com:5000';
dynamic caloriesConsumed = 0;
dynamic caloriesRemaining = 0;
bool newVersion = false;
int mealIndex = -1;
BorderRadius defaultBorderRadius = BorderRadius.circular(10);
List<String> loginTextFormFieldsLabels = [
  "Email",
  "Password",
];
List<IconData> registerTextFormFieldsIcons = [
  Icons.person_outline,
  Icons.email_outlined,
  Icons.lock_outline,
  Icons.calendar_month,
  Icons.line_weight_outlined,
  Icons.height_outlined,
];
List<IconData> profileInfoIcons = [
  Icons.line_weight_outlined,
  Icons.height_outlined,
  Icons.calendar_month,
  Icons.person_add,
];
List<String> mealsCategories = [
  "Breakfast",
  "Lunch",
  "Dinner",
];
List<String> mealsCategoriesImages = [
  "https://media.istockphoto.com/id/533645537/photo/breakfast-with-bacon-eggs-pancakes-and-toast.jpg?s=612x612&w=0&k=20&c=TumrEwImmLi4TIVeirgynvTpHhyvt9LeiDXLci45NWg=",
  "https://s3-ap-south-1.amazonaws.com/betterbutterbucket-silver/chitra-sendhil1453210035569e39b33b9db.jpeg",
  "https://c.ndtvimg.com/2022-03/jcliv9dg_shahi-paneer_625x300_15_March_22.jpg?im=FaceCrop,algorithm=dnn,width=620,height=350"
];

extension EmptyPadding on num {
  SizedBox get ph => SizedBox(height: toDouble().h);

  SizedBox get pw => SizedBox(width: toDouble().w);
}
