import 'package:cutfx_salon/screens/main/main_screen.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/ext/num_ext.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class ServiceDetailScreen extends StatefulWidget {
  const ServiceDetailScreen({Key? key}) : super(key: key);

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  ScrollController scrollController = ScrollController();
  bool toolbarIsExpand = true;
  bool lastToolbarIsExpand = true;

  @override
  void initState() {
    scrollController.addListener(() {
      toolbarIsExpand = !(scrollController.offset >=
          scrollController.position.maxScrollExtent - 120);
      if (lastToolbarIsExpand != toolbarIsExpand) {
        lastToolbarIsExpand = toolbarIsExpand;
        if (!lastToolbarIsExpand) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            TopBarOfServiceDetails(toolbarIsExpand: toolbarIsExpand),
          ];
        },
        physics: const NeverScrollableScrollPhysics(),
        body: SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            margin: EdgeInsets.only(
              top: toolbarIsExpand
                  ? 0
                  : MediaQuery.of(context).viewPadding.top + kToolbarHeight,
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsumis that it has a more-or-less normal distribution ofletters, as opposed to using.\n\n The point of using Lorem Ipsumis that it has a more-or-less normal distribution ofletters, as opposed to using.',
                          style: kLightWhiteTextStyle.copyWith(
                            color: ColorRes.empress,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.offeredBy,
                          style: kRegularThemeTextStyle,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: ColorRes.smokeWhite,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              const ClipRRect(
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(10),
                                ),
                                child: Image(
                                  width: 110,
                                  image: AssetImage(AssetRes.icMassage3),
                                  height: 110,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    right: 15,
                                    left: 15,
                                  ),
                                  height: 110,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Stefen’s Salon Spa',
                                        style: kSemiBoldTextStyle.copyWith(
                                          color: ColorRes.nero,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '84 Green Square, NYC 345687',
                                        style: kThinWhiteTextStyle.copyWith(
                                          color: ColorRes.titleText,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: ColorRes.pumpkin15,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        width: 60,
                                        height: 26,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '5.0',
                                              style: kRegularTextStyle.copyWith(
                                                color: ColorRes.pumpkin,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Icon(
                                              Icons.star_rounded,
                                              color: ColorRes.pumpkin,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Container(
                //   margin: const EdgeInsets.only(top: 10),
                //   height: 60,
                //   width: double.infinity,
                //   child: Row(
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.only(right: 30),
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             const Text(
                //               '${AppRes.currency}150',
                //               style: kBoldThemeTextStyle,
                //             ),
                //             Text(
                //               AppLocalizations.of(context)!.subTotal,
                //               style: kThinWhiteTextStyle.copyWith(
                //                 color: ColorRes.empress,
                //                 fontSize: 14,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Expanded(
                //         child: SizedBox(
                //           height: 55,
                //           child: TextButton(
                //             style: kButtonThemeStyle,
                //             onPressed: () {
                //               Get.to(() => const ConfirmBookingScreen());
                //             },
                //             child: Text(
                //               AppLocalizations.of(context)!.bookService,
                //               style: kRegularWhiteTextStyle,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TopBarOfServiceDetails extends StatelessWidget {
  const TopBarOfServiceDetails({
    Key? key,
    required this.toolbarIsExpand,
  }) : super(key: key);

  final bool toolbarIsExpand;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      collapsedHeight: 60,
      expandedHeight: MediaQuery.of(context).size.width + 40,
      pinned: true,
      floating: true,
      backgroundColor: ColorRes.smokeWhite,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BgRoundImageWidget(
          image: AssetRes.icBack,
          imagePadding: 6,
          imageColor: !toolbarIsExpand ? ColorRes.mortar : ColorRes.white,
          bgColor: !toolbarIsExpand
              ? ColorRes.smokeWhite1
              : ColorRes.white.withOpacity(0.2),
          onTap: () => Get.back(),
        ),
      ),
      elevation: 0,
      title: Text(
        !toolbarIsExpand ? 'Special Ganga hot stone massage' : '',
        style:
            kSemiBoldTextStyle.copyWith(color: ColorRes.mortar, fontSize: 18),
      ),
      titleTextStyle: kSemiBoldTextStyle.copyWith(
        color: ColorRes.mortar,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BgRoundImageWidget(
            image: AssetRes.icUnFavourite,
            imagePadding: 10,
            imageColor: !toolbarIsExpand ? ColorRes.mortar : ColorRes.white,
            bgColor: !toolbarIsExpand
                ? ColorRes.smokeWhite1
                : ColorRes.white.withOpacity(0.2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: BgRoundImageWidget(
            image: AssetRes.icShare,
            imagePadding: 8,
            imageColor: !toolbarIsExpand ? ColorRes.mortar : ColorRes.white,
            bgColor: !toolbarIsExpand
                ? ColorRes.smokeWhite1
                : ColorRes.white.withOpacity(0.2),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: SizedBox(
          child: Stack(
            children: [
              const AspectRatio(
                aspectRatio: 1 / 1,
                child: Image(
                  width: double.infinity,
                  image: AssetImage(AssetRes.icMassage),
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  const Spacer(),
                  Stack(
                    children: [
                      Positioned(
                        top: 15,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          color: ColorRes.smokeWhite,
                          height: 10,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: ColorRes.themeColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .unisex
                                  .toUpperCase(),
                              style: kLightWhiteTextStyle.copyWith(
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: ColorRes.themeColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            child: Text(
                              '2.5 Hours',
                              style: kLightWhiteTextStyle.copyWith(
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    color: ColorRes.smokeWhite,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Special Ganga hot stone massage',
                          style: kBoldWhiteTextStyle.copyWith(
                            color: ColorRes.neroDark,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'By Ganga Salon Spa',
                          style: kThinWhiteTextStyle.copyWith(
                            color: ColorRes.titleText,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              80.currency,
                              style: kBoldThemeTextStyle.copyWith(
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              120.currency,
                              style: kLightWhiteTextStyle.copyWith(
                                color: ColorRes.empress,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              decoration: const BoxDecoration(
                                color: ColorRes.pumpkin15,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              child: Row(
                                children: [
                                  const Image(
                                    image: AssetImage(AssetRes.icTag),
                                    color: ColorRes.pumpkin,
                                    height: 20,
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '-20%',
                                    style: kRegularTextStyle.copyWith(
                                      color: ColorRes.pumpkin,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
