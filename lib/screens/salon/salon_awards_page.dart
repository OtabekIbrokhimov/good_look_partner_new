import 'package:cutfx_salon/bloc/mysalon/my_salon_bloc.dart';
import 'package:cutfx_salon/model/user/salon.dart';
import 'package:cutfx_salon/screens/salon/salon_details_page.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SalonAwardsPage extends StatelessWidget {
  const SalonAwardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MySalonBloc, MySalonState>(
      builder: (context, state) {
        Salon? salon = state is MySalonDataFetched ? state.salon : null;
        return salon == null ||
                salon.data == null ||
                salon.data!.awards!.isEmpty
            ? const DataNotFound()
            : ListView.builder(
                itemCount: salon.data?.awards?.length ?? 0,
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  Awards? awards = salon.data?.awards?[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    color: ColorRes.smokeWhite,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${awards?.title}',
                                style: kRegularTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${AppLocalizations.of(context)!.by} ${awards?.awardBy}',
                                style: kLightWhiteTextStyle.copyWith(
                                  color: ColorRes.themeColor,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${awards?.description}',
                                style: kLightWhiteTextStyle.copyWith(
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
              );
      },
    );
  }
}
