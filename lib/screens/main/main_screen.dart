import 'package:cutfx_salon/bloc/main/main_screen_bloc.dart';
import 'package:cutfx_salon/bloc/main/main_screen_state.dart';
import 'package:cutfx_salon/screens/booking/bookings_screen.dart';
import 'package:cutfx_salon/screens/message/message_screen.dart';
import 'package:cutfx_salon/screens/notification/notification_screen.dart';
import 'package:cutfx_salon/screens/requests/request_screen.dart';
import 'package:cutfx_salon/screens/salon/salon_details_screen.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController pageController =
        PageController(initialPage: 0, keepPage: true);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return BlocProvider(
      create: (context) => MainScreenBloc(),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  BookingsScreen(),
                  RequestScreen(),
                  MessageScreen(),
                  NotificationScreen(),
                  SalonDetailsScreen()
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: ColorRes.black.withOpacity(0.1),
                    blurRadius: 10,
                  )
                ],
                color: ColorRes.white,
              ),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SafeArea(
                top: false,
                child: BlocBuilder<MainScreenBloc, MainScreenState>(
                  builder: (context, state) {
                    int selectedIndex = 0;
                    MainScreenBloc mainScreenBloc =
                        context.read<MainScreenBloc>();
                    if (state is MenuChangeMainScreenState) {
                      selectedIndex = state.selectedIndex;
                      pageController.jumpToPage(selectedIndex);
                    }
                    return Row(
                      children: [
                        const Spacer(),
                        BottomMenuItem(
                          image: AssetRes.icBooking,
                          imageSize: 26,
                          menuIsSelected: selectedIndex == 0,
                          title: AppLocalizations.of(context)!.bookings,
                          nonSelectedImageSize: 26,
                          onTap: () {
                            mainScreenBloc.onMenuClickEvent(0);
                          },
                        ),
                        const Spacer(),
                        BottomMenuItem(
                          image: AssetRes.icRequests,
                          imageSize: 26,
                          menuIsSelected: selectedIndex == 1,
                          title: AppLocalizations.of(context)!.requests,
                          onTap: () {
                            mainScreenBloc.onMenuClickEvent(1);
                          },
                          nonSelectedImageSize: 26,
                        ),
                        const Spacer(),
                        BottomMenuItem(
                          image: AssetRes.icMessage,
                          imageSize: 20,
                          menuIsSelected: selectedIndex == 2,
                          title: AppLocalizations.of(context)!.message,
                          nonSelectedImageSize: 20,
                          onTap: () {
                            mainScreenBloc.onMenuClickEvent(2);
                          },
                        ),
                        const Spacer(),
                        BottomMenuItem(
                          image: AssetRes.icNotification,
                          imageSize: 22,
                          menuIsSelected: selectedIndex == 3,
                          title: AppLocalizations.of(context)!.notifications,
                          nonSelectedImageSize: 20,
                          onTap: () {
                            mainScreenBloc.onMenuClickEvent(3);
                          },
                        ),
                        const Spacer(),
                        BottomMenuItem(
                          image: AssetRes.icSalon,
                          imageSize: 20,
                          menuIsSelected: selectedIndex == 4,
                          title: AppLocalizations.of(context)!.mySalon,
                          nonSelectedImageSize: 20,
                          onTap: () {
                            mainScreenBloc.onMenuClickEvent(4);
                          },
                        ),
                        const Spacer(),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BottomMenuItem extends StatelessWidget {
  final String image;
  final double imageSize;
  final String title;
  final bool menuIsSelected;
  final double? nonSelectedImageSize;
  final Function()? onTap;

  const BottomMenuItem({
    Key? key,
    required this.image,
    required this.imageSize,
    required this.title,
    required this.menuIsSelected,
    this.nonSelectedImageSize,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          color: menuIsSelected ? ColorRes.lavender : ColorRes.transparent,
        ),
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Image(
              image: AssetImage(image),
              height: menuIsSelected ? imageSize : nonSelectedImageSize,
              color: menuIsSelected ? ColorRes.themeColor : ColorRes.darkGray,
            ),
            Visibility(
              visible: menuIsSelected,
              child: const SizedBox(
                width: 10,
              ),
            ),
            Visibility(
              visible: menuIsSelected,
              child: Text(
                title,
                style: kRegularTextStyle.copyWith(
                  color: ColorRes.themeColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BgRoundImageWidget extends StatelessWidget {
  final String image;
  final double? imagePadding;
  final double? height;
  final double? width;
  final Color? imageColor;
  final Color? bgColor;
  final Function()? onTap;

  const BgRoundImageWidget({
    Key? key,
    required this.image,
    this.imagePadding,
    this.onTap,
    this.imageColor,
    this.bgColor,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 40,
        width: width ?? 40,
        decoration: BoxDecoration(
          color: bgColor ?? ColorRes.themeColor10,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
        ),
        padding: EdgeInsets.all(imagePadding ?? 0),
        child: Image(
          image: AssetImage(image),
          color: imageColor,
        ),
      ),
    );
  }
}
