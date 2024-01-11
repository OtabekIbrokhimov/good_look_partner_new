import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class AppLogo extends StatelessWidget {
  final Color? textColor;
  final double? textSize;

  const AppLogo({
    Key? key,
    this.textColor,
    this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      child: Image(
        image: const AssetImage("images/logo.png"),
        width: Get.width*0.8,
      ),
    );
  }
}

class TextWithTextFieldWidget extends StatelessWidget {
  final String title;
  final bool? isPassword;
  final TextEditingController controller;

  const TextWithTextFieldWidget({
    Key? key,
    required this.title,
    this.isPassword,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: kRegularWhiteTextStyle,
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorRes.white.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: ColorRes.smokeWhite,
              width: 0.5,
            ),
          ),
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(border: InputBorder.none),
            style: kRegularWhiteTextStyle.copyWith(),
            textCapitalization: TextCapitalization.sentences,
            obscureText: isPassword ?? false,
            enableSuggestions: isPassword != null ? !isPassword! : true,
            autocorrect: isPassword != null ? !isPassword! : true,
          ),
        ),
      ],
    );
  }
}

class TextWithTextFieldSmokeWhiteWidget extends StatelessWidget {
  final String title;
  final bool? isPassword;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final bool enable;
  const TextWithTextFieldSmokeWhiteWidget({
    Key? key,
    required this.title,
    this.isPassword,
    this.controller,
    this.textInputType = TextInputType.text,  this.enable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.isEmpty
            ? const SizedBox()
            : Text(
                title,
                style: kLightWhiteTextStyle.copyWith(
                  color: ColorRes.black,
                  fontSize: 16,
                ),
              ),
        Container(
          decoration: BoxDecoration(
            color: ColorRes.smokeWhite,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: ColorRes.smokeWhite,
              width: 0.5,
            ),
          ),
          height: 55,
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            enabled: enable,
            controller: controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            style: kRegularTextStyle.copyWith(
              fontSize: 15,
              color: ColorRes.charcoal50,
            ),
            keyboardType: textInputType,
            textCapitalization: TextCapitalization.sentences,
            obscureText: isPassword ?? false,
            enableSuggestions: isPassword != null ? !isPassword! : true,
            autocorrect: isPassword != null ? !isPassword! : true,
          ),
        ),
      ],
    );
  }
}

class OpenClosedStatusWidget extends StatelessWidget {
  final Color? bgDisable;
  final bool salonIsOpen;

  const OpenClosedStatusWidget({
    Key? key,
    this.bgDisable,
    required this.salonIsOpen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: salonIsOpen
            ? ColorRes.themeColor
            : bgDisable ?? ColorRes.smokeWhite,
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      child: Text(
        (salonIsOpen
                ? AppLocalizations.of(context)!.open
                : AppLocalizations.of(context)!.closed)
            .toUpperCase(),
        style: kLightWhiteTextStyle.copyWith(
          color: salonIsOpen ? ColorRes.white : ColorRes.empress,
          fontSize: 12,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class TitleWithSeeAllWidget extends StatelessWidget {
  final String title;
  final Function()? onTap;

  const TitleWithSeeAllWidget({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Text(
            title,
            style: kSemiBoldTextStyle,
          ),
          const Spacer(),
          CustomCircularInkWell(
            onTap: onTap,
            child: Text(
              AppLocalizations.of(context)!.seeAll,
              style: kRegularEmpressTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCircularInkWell extends StatelessWidget {
  final Widget? child;
  final Function()? onTap;

  const CustomCircularInkWell({Key? key, this.child, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStateProperty.all(ColorRes.transparent),
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      child: child,
    );
  }
}

class ToolBarWidget extends StatelessWidget {
  final String title;

  const ToolBarWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorRes.smokeWhite,
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 15),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCircularInkWell(
              onTap: () {
                Get.back();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Image(
                  image: AssetImage(AssetRes.icBack),
                  color: ColorRes.black,
                  height: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                title,
                style: kBoldThemeTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ToggleButton extends StatefulWidget {
  final Function(bool isActive)? onToggleChange;
  final bool? isActive;

  const ToggleButton({Key? key, this.onToggleChange, this.isActive})
      : super(key: key);

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool buttonIsActive = false;

  @override
  void initState() {
    buttonIsActive = widget.isActive ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: CupertinoSwitch(
        value: buttonIsActive,
        activeColor: ColorRes.themeColor,
        onChanged: (value) {
          buttonIsActive = value;
          widget.onToggleChange?.call(buttonIsActive);
          setState(() {});
        },
      ),
    );
  }
}

class CloseButtonWidget extends StatelessWidget {
  final Function()? onTap;

  const CloseButtonWidget({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: () {
        onTap?.call();
        Get.back();
      },
      child: Container(
        height: 35,
        width: 35,
        decoration: const BoxDecoration(
          color: ColorRes.lavender,
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        padding: const EdgeInsets.all(5),
        child: const Icon(
          Icons.close_rounded,
          color: ColorRes.themeColor,
        ),
      ),
    );
  }
}
Widget loadingImage(context, child, loadingProgress) {
  if (loadingProgress == null) {
    return child;
  }
  return const LoadingImage();
}


Widget errorBuilderForImage(context, error, stackTrace, {String name = '',bool isSalonImage = false, double fontSize = 50}) {

  return isSalonImage?ImageNotFoundSalon(name: name): ImageNotFound(name: name,fontsize: fontSize,);
}

class ImageNotFound extends StatelessWidget {
  final Color? color;
  final Color? tintcolor;
  final String name;
  final double fontsize;
  const ImageNotFound({
    super.key,
    this.color,
    this.tintcolor, required this.name,  this.fontsize = 50
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color:ColorRes.fountainBlue,
      child: Center(
        child: Text(
          name.isNotEmpty?name[0].toUpperCase():' '.toUpperCase(),
          style: kBoldThemeTextStyle.copyWith(
            color: tintcolor ?? ColorRes.smokeWhite1,
            fontSize: fontsize,
          ),
        ),
      ),
    );
  }
}
class ImageNotFoundSalon extends StatelessWidget {
  final String name;
  const ImageNotFoundSalon({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color:ColorRes.fountainBlue,
      child: Center(
        child: Text(
          name.isNotEmpty?name.toUpperCase():"",
          style: kBoldThemeTextStyle.copyWith(
            color:  ColorRes.greyD9,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}

class ImageNotFoundOval extends StatelessWidget {
  final Color? color;
  final Color? tintcolor;
  final double? fontSize;

  const ImageNotFoundOval({
    super.key,
    this.color,
    this.tintcolor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        color: color ?? ColorRes.smokeWhite,
        child: Center(
          child: Text(
            ':-('.toUpperCase(),
            style: kBoldThemeTextStyle.copyWith(
              color: tintcolor ?? ColorRes.smokeWhite1,
              fontSize: fontSize ?? 50,
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingImage extends StatelessWidget {
  final Color? color;

  const LoadingImage({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? ColorRes.smokeWhite,
      child: Center(
        child: Text(
          '...'.toUpperCase(),
          style: kBoldThemeTextStyle.copyWith(
            color: ColorRes.smokeWhite1,
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}

class DataNotFound extends StatelessWidget {
  const DataNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Image(
            image: AssetImage(AssetRes.icNoData),
            height: 275,
          ),
        )
        // Text(
        //   ':-('.toUpperCase(),
        //   style: kBoldThemeTextStyle.copyWith(
        //     color: ColorRes.smokeWhite1,
        //     fontSize: 50,
        //   ),
        // ),
      ],
    );
  }
}

class LoadingData extends StatelessWidget {
  final Color? color;

  const LoadingData({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? ColorRes.smokeWhite,
      child: const Center(
        child: CircularProgressIndicator(
          color: ColorRes.themeColor,
        ),
      ),
    );
  }
}
