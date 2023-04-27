import 'package:flutter/material.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};
MaterialColor defaultColor = MaterialColor(0xFFC58940, color);

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
// const baseUrl = 'http://192.168.1.10:5000';
dynamic caloriesConsumed = 0;
dynamic caloriesRemaining = 0;
bool newVersion = false;
int mealIndex = -1;
BorderRadius defaultBorderRadius = BorderRadius.circular(10);