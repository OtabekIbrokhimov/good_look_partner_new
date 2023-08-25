import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:flutter/material.dart';

const kSemiBoldWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AssetRes.fnProductSansMedium,
  fontSize: 23,
);

const kSemiBoldTextStyle = TextStyle(
  color: ColorRes.neroDark,
  fontFamily: AssetRes.fnProductSansMedium,
  fontSize: 20,
);

const kSemiBoldThemeTextStyle = TextStyle(
  color: ColorRes.themeColor,
  fontFamily: AssetRes.fnProductSansMedium,
  fontSize: 18,
);
const kMediumWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AssetRes.fnProductSansMedium,
  fontSize: 20,
);

const kMediumTextStyle = TextStyle(
  color: ColorRes.neroDark,
  fontFamily: AssetRes.fnProductSansMedium,
  fontSize: 20,
);

const kMediumThemeTextStyle = TextStyle(
  color: ColorRes.themeColor,
  fontFamily: AssetRes.fnProductSansMedium,
  fontSize: 20,
);

const kBoldWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AssetRes.fnProductSansBold,
  fontSize: 23,
);

const kBoldThemeTextStyle = TextStyle(
  color: ColorRes.themeColor,
  fontFamily: AssetRes.fnProductSansBold,
  fontSize: 23,
);

const kBlackWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AssetRes.fnProductSansBlack,
  fontSize: 22,
);

const kRegularWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AssetRes.fnProductSansRegular,
  fontSize: 16,
);

const kRegularTextStyle = TextStyle(
  color: ColorRes.neroDark,
  fontFamily: AssetRes.fnProductSansRegular,
  fontSize: 16,
);

const kRegularEmpressTextStyle = TextStyle(
  color: ColorRes.empress,
  fontFamily: AssetRes.fnProductSansRegular,
  fontSize: 16,
);
const kRegularThemeTextStyle = TextStyle(
  color: ColorRes.themeColor,
  fontFamily: AssetRes.fnProductSansRegular,
  fontSize: 16,
);

const kLightWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AssetRes.fnProductSansLight,
  fontSize: 14,
);
const kLightTextStyle = TextStyle(
  color: ColorRes.neroDark,
  fontFamily: AssetRes.fnProductSansLight,
  fontSize: 16,
);

const kThinWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AssetRes.fnProductSansThin,
  fontSize: 14,
);

const kBlackButtonTextStyle = TextStyle(
  color: ColorRes.black,
  fontFamily: AssetRes.fnProductSansRegular,
  fontSize: 14,
);

const kThemeButtonTextStyle = TextStyle(
  color: ColorRes.themeColor,
  fontFamily: AssetRes.fnProductSansRegular,
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
  backgroundColor: MaterialStateProperty.all(ColorRes.themeColor),
  shape: MaterialStateProperty.all(
    const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  ),
  overlayColor: MaterialStateProperty.all(ColorRes.transparent),
);
