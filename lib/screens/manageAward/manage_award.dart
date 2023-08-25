import 'package:cutfx_salon/bloc/manageawards/manage_awards_bloc.dart';
import 'package:cutfx_salon/model/user/salon.dart';
import 'package:cutfx_salon/screens/addAward/add_award.dart';
import 'package:cutfx_salon/screens/main/main_screen.dart';
import 'package:cutfx_salon/screens/salon/salon_details_page.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class ManageAwardScreen extends StatelessWidget {
  const ManageAwardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageAwardsBloc(),
      child: BlocBuilder<ManageAwardsBloc, ManageAwardsState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.to(() => const AddAwardScreen())?.then((value) {
                  context.read<ManageAwardsBloc>().add(FetchAwardsEvent());
                });
              },
              backgroundColor: ColorRes.themeColor,
              child: const Image(
                image: AssetImage(AssetRes.icPlus_),
                height: 30,
                width: 30,
              ),
            ),
            body: Column(
              children: [
                ToolBarWidget(
                  title: AppLocalizations.of(context)!.manageAwards,
                ),
                BlocBuilder<ManageAwardsBloc, ManageAwardsState>(
                  builder: (context, state) {
                    ManageAwardsBloc manageAwardBloc =
                        context.read<ManageAwardsBloc>();
                    return state is FetchedAwardsState
                        ? Expanded(
                            child: ListView.builder(
                              itemCount:
                                  manageAwardBloc.salon?.data?.awards?.length ??
                                      0,
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(0),
                              itemBuilder: (context, index) {
                                Awards? awards =
                                    manageAwardBloc.salon?.data?.awards?[index];
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  color: ColorRes.smokeWhite,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const RoundCornerWithImageWidget(
                                        image: AssetRes.icAwards,
                                        cornerRadius: 10,
                                        imagePadding: 7,
                                        bgColor: ColorRes.smokeWhite1,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${awards?.title}',
                                                        style:
                                                            kRegularTextStyle,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        'By ${awards?.awardBy}',
                                                        style:
                                                            kLightWhiteTextStyle
                                                                .copyWith(
                                                          color: ColorRes
                                                              .themeColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                PopupMenuButton(
                                                  itemBuilder: (context) {
                                                    return [
                                                      PopupMenuItem(
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .edit,
                                                          style:
                                                              kMediumTextStyle
                                                                  .copyWith(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        onTap: () async {
                                                          await Future.delayed(
                                                            const Duration(
                                                                seconds: 0),
                                                          );
                                                          Get.to(
                                                            () =>
                                                                const AddAwardScreen(),
                                                            arguments: awards,
                                                          )?.then((value) {
                                                            manageAwardBloc.add(
                                                                FetchAwardsEvent());
                                                          });
                                                        },
                                                      ),
                                                      PopupMenuItem(
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .delete,
                                                          style:
                                                              kMediumTextStyle
                                                                  .copyWith(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                  ManageAwardsBloc>()
                                                              .add(
                                                                  DeleteAwardsEvent(
                                                                      awards));
                                                        },
                                                      ),
                                                    ];
                                                  },
                                                  child:
                                                      const BgRoundImageWidget(
                                                    image: AssetRes.icMore,
                                                    bgColor:
                                                        ColorRes.smokeWhite1,
                                                    imagePadding: 5,
                                                    height: 35,
                                                    width: 35,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '${awards?.description}',
                                              style:
                                                  kLightWhiteTextStyle.copyWith(
                                                color: ColorRes.empress,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: ColorRes.themeColor,
                              ),
                            ),
                          );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
