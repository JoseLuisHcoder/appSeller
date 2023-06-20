import 'package:flutter/material.dart';

const Color kBgLoadingColor = Color.fromARGB(255, 30, 95, 154);

const Color kGreen = Color(0xFF7CB518);
const Color kGreen100 = Color(0xFFDEECC5);
// const Color kSecondary = Color(0xFFF86C5E);
// const Color kSecondary100 = Color(0xFFFDDAD7);
// const Color kPrimary = Color(0xFFFFD400);
// const Color kPrimary100 = Color(0xFFFFF4BF);

const Color kPrimary = Color(0xFFF55800);
const Color kPrimary100 = Color(0xFFFFF2EB);
const Color kSecondary = Color(0xFFFFAA00);
const Color kSecondary100 = Color(0xFFFFF2EB);
const Color kSecondary200 = Color(0xFFFFE7B8);
const Color kSecondary400 = Color(0xFFFFBE3D);

const Color kBlue = Color(0xFF00BBF9);
const Color kTextColor = Color(0xFF525252);
const Color kSuccess = Color.fromRGBO(76, 175, 80, 1);
const Color kError = Color.fromARGB(255, 255, 0, 0);
const Color kWhite = Colors.white;
const Color kBlack = Colors.black;

const Color kGrey100 = Color.fromRGBO(245, 245, 245, 1);
const Color kGrey200 = Color.fromRGBO(238, 238, 238, 1);
const Color kGrey400 = Color.fromRGBO(189, 189, 189, 1);
const Color kGrey500 = Color.fromRGBO(158, 158, 158, 1);
const Color kGrey600 = Color.fromRGBO(117, 117, 117, 1);
const Color kGrey800 = Color.fromRGBO(66, 66, 66, 1);
const Color kGrey900 = Color.fromRGBO(33, 33, 33, 1);

const Color kBgColor = kPrimary100;
const Color btnBgPrimary = kPrimary;
const Color btnPrimary = kWhite;

const Color appBarBackgroundColor = Colors.transparent;
const Color kAppBar = Color(0xFF525252);
// const Color kAppBar = kSecondary200;
const Color kAppBarText = kTextColor;
const Color kIconAppbar = kTextColor;
// const Color kAppBar = kSecondary200;

// Favorite icon
const Color icoFavEnabled = kPrimary;
const Color icoFavDisabled = kGrey200;

//Home promo card
const Color bgPromoCardUp = kWhite;
const Gradient bgPromoCardMidle = LinearGradient(
  colors: [Color(0xFFFFD37A), Color.fromARGB(255, 252, 239, 212)],
  begin: Alignment.centerLeft,
  end: Alignment.bottomCenter,
);

//Search
const Color kSearchIcon = kTextColor;
const Color kSearchBorder = kTextColor;
const Color kSearchBtn = kSecondary;

const Color bgPromoCardDown = kWhite;
const Color promoCardUp = kTextColor;
const Color promoCardMiddle = kTextColor;
const Color promoCardDown = kTextColor;

//Navigation
const Color bottomNavigationBarSelected = kPrimary;
const Color bottomNavigationBarUnSelected = kGrey800;
const Color itemBottomNavigationBarBackground = kSecondary200;
const Color kSearchIconSelected = Color.fromRGBO(189, 189, 189, 1);

// Promotion MoreOffers
const Color kBgPromotionBar = kPrimary100;
const Color kPromotionBar = kPrimary;

const String appFontFamily = 'Poppins';

ThemeData solarTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: kPrimary,
    secondary: kSecondary,
  ),
  // primaryColor: kPrimary,
  scaffoldBackgroundColor: kWhite,
  textTheme: const TextTheme(
    labelMedium: TextStyle(
        color: kGreen,
        fontSize: 12,
        fontWeight: FontWeight.w300,
        fontFamily: appFontFamily),
    titleLarge: TextStyle(
        color: kTextColor,
        fontSize: 22,
        fontWeight: FontWeight.w500,
        fontFamily: appFontFamily),
    bodyLarge: TextStyle(
        color: kTextColor,
        fontSize: 18,
        fontWeight: FontWeight.w400,
        fontFamily: appFontFamily),
    bodyMedium: TextStyle(
        color: kTextColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: appFontFamily),
    displayLarge: TextStyle(
        fontSize: 72.0, fontWeight: FontWeight.bold, fontFamily: appFontFamily),
  ),
  appBarTheme: const AppBarTheme(backgroundColor: appBarBackgroundColor),
);
