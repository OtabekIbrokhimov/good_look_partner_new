import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:flutter/material.dart';

const kSemiBoldWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AssetRes.fnGTWalsheimProMedium,
  fontSize: 23,
);

const kSemiBoldTextStyle = TextStyle(
  color: ColorRes.neroDark,
  fontFamily: AssetRes.fnGTWalsheimProMedium,
  fontSize: 20,
);

const kSemiBoldThemeTextStyle = TextStyle(
  color: ColorRes.themeColor,
  fontFamily: AssetRes.fnGTWalsheimProMedium,
  fontSize: 18,
);
const kMediumWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AssetRes.fnGTWalsheimProMedium,
  fontSize: 20,
);

const kMediumTextStyle = TextStyle(
  color: ColorRes.neroDark,
  fontFamily: AssetRes.fnGTWalsheimProMedium,
  fontSize: 20,
);

const kMediumThemeTextStyle = TextStyle(
  color: ColorRes.themeColor,
  fontFamily: AssetRes.fnGTWalsheimProMedium,
  fontSize: 20,
);

const kBoldWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AssetRes.fnGTWalsheimProBold,
  fontSize: 23,
);

const kBoldThemeTextStyle = TextStyle(
  color: ColorRes.themeColor,
  fontFamily: AssetRes.fnGTWalsheimProBold,
  fontSize: 23,
);

const kBlackWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AssetRes.fnGTWalsheimProBlack,
  fontSize: 22,
);

const kRegularWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AssetRes.fnGTWalsheimProRegular,
  fontSize: 16,
);

const kRegularTextStyle = TextStyle(
  color: ColorRes.black,
  fontFamily: AssetRes.fnGTWalsheimProRegular,
  fontSize: 16,
);

const kRegularEmpressTextStyle = TextStyle(
  color: ColorRes.empress,
  fontFamily: AssetRes.fnGTWalsheimProRegular,
  fontSize: 16,
);
const kRegularThemeTextStyle = TextStyle(
  color: ColorRes.themeColor,
  fontFamily: AssetRes.fnGTWalsheimProRegular,
  fontSize: 16,
);

const kLightWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AssetRes.fnGTWalsheimProLight,
  fontSize: 14,
);
const kLightTextStyle = TextStyle(
  color: ColorRes.neroDark,
  fontFamily: AssetRes.fnGTWalsheimProLight,
  fontSize: 16,
);

const kThinWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AssetRes.fnGTWalsheimProThin,
  fontSize: 14,
);

const kBlackButtonTextStyle = TextStyle(
  color: ColorRes.black,
  fontFamily: AssetRes.fnGTWalsheimProRegular,
  fontSize: 14,
);

const kThemeButtonTextStyle = TextStyle(
  color: ColorRes.themeColor,
  fontFamily: AssetRes.fnGTWalsheimProRegular,
  fontSize: 18,
);

ButtonStyle kButtonWhiteStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(ColorRes.white),
  shape: MaterialStateProperty.all(
    const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  ),
  overlayColor: MaterialStateProperty.all(ColorRes.transparent),
);

ButtonStyle kButtonThemeStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(ColorRes.black),
  shape: MaterialStateProperty.all(
    const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  ),
  overlayColor: MaterialStateProperty.all(ColorRes.black),
);