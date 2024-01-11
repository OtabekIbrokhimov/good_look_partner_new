import 'package:cutfx_salon/bloc/mysalon/my_salon_bloc.dart';
import 'package:cutfx_salon/model/user/salon.dart';
import 'package:cutfx_salon/screens/add_master/master_list_screen.dart';
import 'package:cutfx_salon/screens/main/main_screen.dart';
import 'package:cutfx_salon/screens/salon/salon_awards_page.dart';
import 'package:cutfx_salon/screens/salon/salon_details_page.dart';
import 'package:cutfx_salon/screens/salon/salon_gallery_page.dart';
import 'package:cutfx_salon/screens/salon/salon_reviews_page.dart';
import 'package:cutfx_salon/screens/salon/salon_services_page.dart';
import 'package:cutfx_salon/screens/setting/setting_screen.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../utils/shared_pref.dart';
import '../login/email_login_screen.dart';

class SalonDetailsScreen extends StatefulWidget {
  const SalonDetailsScreen({Key? key}) : super(key: key);

  @override
  State<SalonDetailsScreen> createState() => _SalonDetailsScreenState();
}

class _SalonDetailsScreenState extends State<SalonDetailsScreen> {
  ScrollController scrollController = ScrollController();
  bool toolbarIsExpand = true;
  bool lastToolbarIsExpand = true;
  PageController pageController = PageController();

  @override
  void initState(){
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
    return BlocProvider(
      create: (context) => MySalonBloc(),
      child: BlocBuilder<MySalonBloc, MySalonState>(
        builder: (context, state) {
          return state is MySalonInitial
              ? const LoadingData()
              : Scaffold(
                  body: NestedScrollView(
                    controller: scrollController,
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        TopBarOfSalonDetails(toolbarIsExpand: toolbarIsExpand),
                      ];
                    },

                    body: Column(
                      children: [
                        Container(
                          height: toolbarIsExpand
                              ? 0
                              : MediaQuery.of(context).viewPadding.top +
                                  kToolbarHeight,
                        ),
                        TabBarOfSalonDetailWidget(
                          onTabChange: (selectedIndex) {
                            pageController.jumpToPage(selectedIndex);
                          },
                        ),
                        Expanded(
                          child: PageView(
                            controller: pageController,
                            //physics: const NeverScrollableScrollPhysics(),
                            children: const [
                              SalonDetailsPage(),
                              SalonServicesPage(),
                              MasterListScreen(needManage: false,),
                              SalonGalleryPage(),
                              SalonReviewsPage(),
                              SalonAwardsPage(),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}

class TabBarOfSalonDetailWidget extends StatefulWidget {
  final Function(int)? onTabChange;

  const TabBarOfSalonDetailWidget({
    Key? key,
    this.onTabChange,
  }) : super(key: key);

  @override
  State<TabBarOfSalonDetailWidget> createState() =>
      _TabBarOfSalonDetailWidgetState();
}

class _TabBarOfSalonDetailWidgetState extends State<TabBarOfSalonDetailWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      AppLocalizations.of(context)!.details,
      AppLocalizations.of(context)!.services,
      AppLocalizations.of(context)!.my_masters,
      AppLocalizations.of(context)!.gallery,
      AppLocalizations.of(context)!.reviews,
      AppLocalizations.of(context)!.awards,

    ];
    return Container(
      height: 60,
      color: ColorRes.white,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List<Widget>.generate(
          categories.length,
          (index) => CustomCircularInkWell(
            onTap: () {
              selectedIndex = index;
              widget.onTabChange?.call(selectedIndex);
              setState(() {});
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: index == selectedIndex
                    ? ColorRes.themeColor10
                    : ColorRes.smokeWhite,
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                border: Border.all(
                  color: index == selectedIndex
                      ? ColorRes.themeColor
                      : ColorRes.transparent,
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 8,
              ),
              margin: EdgeInsets.only(
                right: index == (categories.length - 1) ? 15 : 10,
                left: index == 0 ? 15 : 0,
                bottom: 10,
                top: 10,
              ),
              child: Text(
                categories[index],
                style: kSemiBoldTextStyle.copyWith(
                  fontSize: 15,
                  color: index == selectedIndex
                      ? ColorRes.themeColor
                      : ColorRes.empress,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TopBarOfSalonDetails extends StatelessWidget {
  TopBarOfSalonDetails({
    Key? key,
    required this.toolbarIsExpand,
  }) : super(key: key);

  final bool toolbarIsExpand;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MySalonBloc, MySalonState>(
      builder: (context, state) {
        Salon? salon;
        if (state is MySalonDataFetched) {
          salon = state.salon;
        }

        return SliverAppBar(
          collapsedHeight: 60,
          expandedHeight: 350,
          pinned: true,
          floating: true,
          leadingWidth: 0,
          backgroundColor: ColorRes.smokeWhite,
          leading: Container(
            width: 0,
          ),
          elevation: 0,
          title: Text(
            !toolbarIsExpand ? '${salon?.data?.salonName}' : '',
            style: kSemiBoldTextStyle.copyWith(
              color: ColorRes.mortar,
            ),
          ),
          titleTextStyle: kSemiBoldTextStyle.copyWith(
            color: ColorRes.mortar,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: BgRoundImageWidget(
                onTap: () async {
                  BranchUniversalObject buo = BranchUniversalObject(
                    canonicalIdentifier: 'flutter/branch',
                    title: salon?.data?.salonName ?? '',
                    imageUrl:
                        '${ConstRes.itemBaseUrl}${salon?.data?.images?[0].image}',
                    contentDescription: salon?.data?.salonAbout ?? '',
                    publiclyIndex: true,
                    locallyIndex: true,
                    contentMetadata: BranchContentMetaData()
                      ..addCustomMetadata(ConstRes.salonId_, ConstRes.salonId),
                  );
                  BranchLinkProperties lp = BranchLinkProperties(
                      channel: 'facebook',
                      feature: 'sharing',
                      stage: 'new share',
                      tags: ['one', 'two', 'three']);
                  // lp.addControlParam('url', 'http://www.google.com');
                  // lp.addControlParam('url2', 'http://flutter.dev');
                  BranchResponse response = await FlutterBranchSdk.getShortUrl(
                      buo: buo, linkProperties: lp);
                  if (response.success) {
                    Share.share(
                      'Check out this Profile ${response.result}',
                      subject: 'Look ${salon?.data?.salonName}',
                    );
                  } else {}
                },
                image: AssetRes.icShare,
                imagePadding: 8,
                imageColor: !toolbarIsExpand ? ColorRes.mortar : ColorRes.white,
                bgColor: !toolbarIsExpand
                    ? ColorRes.smokeWhite1
                    : ColorRes.white.withOpacity(0.2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BgRoundImageWidget(
                image: AssetRes.icSetting,
                imagePadding: 8,
                imageColor: !toolbarIsExpand ? ColorRes.mortar : ColorRes.white,
                bgColor: !toolbarIsExpand
                    ? ColorRes.smokeWhite1
                    : ColorRes.white.withOpacity(0.2),
                onTap: () {
                  Get.to(() => const SettingScreen())?.then((value) {
                    context.read<MySalonBloc>().fetchSalonData();
                  });
                },
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: SizedBox(
              height: 350,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: PageView(
                          controller: pageController,
                          children: List<Widget>.generate(
                              salon?.data?.images?.length ?? 0, (index) {
                            return Image(
                              width: double.infinity,
                              image: NetworkImage(
                                '${ConstRes.itemBaseUrl}${salon?.data?.images?[index].image}',
                              ),
                              errorBuilder: errorBuilderForImage,
                              loadingBuilder: loadingImage,
                              fit: BoxFit.cover,
                            );
                          }),
                        ),
                      ),
                      Container(
                        height: 100,
                        color: ColorRes.smokeWhite,
                      ),
                    ],
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
                              OpenClosedStatusWidget(
                                bgDisable: ColorRes.smokeWhite1,
                                salonIsOpen: salon != null
                                    ? AppRes.isSalonIsOpen(salon)
                                    : false,
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
                                  AppRes.getGenderTypeInStringFromNumber(
                                      context,
                                      salon?.data?.genderServed?.toInt() ?? 0),
                                  style: kLightWhiteTextStyle.copyWith(
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: salon?.data?.topRated == 1,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        ColorRes.pancho,
                                        ColorRes.fallow
                                      ],
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 8,
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .topRated
                                        .toUpperCase(),
                                    style: kLightWhiteTextStyle.copyWith(
                                      fontSize: 12,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ),
                              PageIndicator(
                                salon: salon,
                                pageController: pageController,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: 110,
                        width: double.infinity,
                        color: ColorRes.smokeWhite,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              '${salon?.data?.salonName}',
                              style: kBoldThemeTextStyle,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${salon?.data?.salonAddress}',
                                  style: kThinWhiteTextStyle.copyWith(
                                    color: ColorRes.titleText,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Visibility(
                                  visible: salon?.data?.reviewsCount != 0,
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: ColorRes.pumpkin15,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              '${salon?.data?.rating}',
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
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '(${salon?.data?.reviewsCount ?? 0} Ratings)',
                                        style: kThinWhiteTextStyle.copyWith(
                                          color: ColorRes.titleText,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
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
      },
    );
  }
}

class PageIndicator extends StatefulWidget {
  const PageIndicator({
    super.key,
    required this.salon,
    this.pageController,
  });

  final Salon? salon;
  final PageController? pageController;

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.pageController?.addListener(() {
      // if (selectedIndex != (widget.pageController?.page?.round() ?? 0)) {
      setState(() {});
      // }
      selectedIndex = widget.pageController?.page?.round() ?? 0;
    });
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:
                List.generate(widget.salon?.data?.images?.length ?? 0, (index) {
              return SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? ColorRes.smokeWhite
                        : ColorRes.smokeWhite.withOpacity(.3),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  height: 2.5,
                  width: 20,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
// bottom: PreferredSize(
//   preferredSize: const Size(double.infinity, 60),
//   child: Container(
//     height: 60,
//     color: ColorRes.white,
//     child: ListView(
//       scrollDirection: Axis.horizontal,
//       children: List<Widget>.generate(
//         categories.length,
//         (index) => Container(
//           decoration: BoxDecoration(
//             color: index == 0
//                 ? ColorRes.themeColor10
//                 : ColorRes.smokeWhite,
//             borderRadius:
//                 const BorderRadius.all(Radius.circular(100)),
//             border: Border.all(
//               color: index == 0
//                   ? ColorRes.themeColor
//                   : ColorRes.transparent,
//               width: 1,
//             ),
//           ),
//           padding: const EdgeInsets.symmetric(
//             horizontal: 15,
//             vertical: 8,
//           ),
//           margin: const EdgeInsets.only(
//             right: 10,
//             bottom: 10,
//             top: 10,
//           ),
//           child: Text(
//             categories[index],
//             style: kSemiBoldTextStyle.copyWith(
//               fontSize: 16,
//               color: index == 0
//                   ? ColorRes.themeColor
//                   : ColorRes.empress,
//             ),
//           ),
//         ),
//       ),
//     ),
//   ),
// ),
// bottom: AppBar(),
