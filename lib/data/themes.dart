import 'package:flutter/material.dart';

const Color kBgLoadingColor = Color.fromARGB(255, 30, 95, 154);
const Color appBarBackgroundColor = Colors.transparent;
const Color kAppBar = Color(0xFF525252);
const Color kIconAppbar = Colors.white;
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

const Color btnBgPrimary = kPrimary;
const Color btnPrimary = kWhite;

// Favorite icon
const Color icoFavActive = Color.fromARGB(255, 242, 82, 68);
const Color icoFavDisabled = kGrey200;

//Home promo card
const Color bgPromoCardUp = kSecondary200;
const Color bgPromoCardMidle = kSecondary400;
const Color bgPromoCardDown = kSecondary200;
const Color promoCardUp = kTextColor;
const Color promoCardMiddle = kTextColor;
const Color promoCardDown = kTextColor;

//Navigation
const Color bottomNavigationBarSelected = kPrimary;
const Color itemBottomNavigationBarBackground = Colors.white;
const Color kSearchIconSelected = Color.fromRGBO(189, 189, 189, 1);

// Promotion MoreOffers
const Color kBgPromotionBar = kPrimary100;
const Color kPromotionBar = kPrimary;

ThemeData solarTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: kPrimary,
    secondary: kSecondary,
  ),
  // primaryColor: kPrimary,
  scaffoldBackgroundColor: kWhite,
  fontFamily: 'Lucida Sans Unicode',
  textTheme: const TextTheme(
    labelMedium:
        TextStyle(color: kGreen, fontSize: 12, fontWeight: FontWeight.w300),
    titleLarge:
        TextStyle(color: kTextColor, fontSize: 22, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(
      color: kTextColor,
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium:
        TextStyle(color: kTextColor, fontSize: 14, fontWeight: FontWeight.w400),
    displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
  appBarTheme: const AppBarTheme(backgroundColor: appBarBackgroundColor),
);
