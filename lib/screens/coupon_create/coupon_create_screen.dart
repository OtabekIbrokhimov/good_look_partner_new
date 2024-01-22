import 'package:cutfx_salon/bloc/coupon_create_block/coupon_create_blog.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class CouponCreateScreen extends StatelessWidget {
  const CouponCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CouponCreateBloc(),
        child: Column(
          children: [
            ToolBarWidget(
              title: AppLocalizations.of(context)!.createCoupon,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: BlocBuilder<CouponCreateBloc, EditCouponState>(
                  builder: (context, state) {
                    CouponCreateBloc editBankBloc =
                        context.read<CouponCreateBloc>();
                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          TextWithTextFieldSmokeWhiteWidget(
                            title: AppLocalizations.of(context)!.name,
                            controller: editBankBloc.nameController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextWithTextFieldSmokeWhiteWidget(
                            title: "${AppLocalizations.of(context)!.salon}:",
                            controller: editBankBloc.salonController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextWithTextFieldSmokeWhiteWidget(
                            title: "${AppLocalizations.of(context)!.services}:",
                            controller: editBankBloc.discountController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextWithTextFieldSmokeWhiteWidget(
                            title: AppLocalizations.of(context)!.timeOfAction,
                            controller: editBankBloc.timeController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextWithTextFieldSmokeWhiteWidget(
                            title: "${AppLocalizations.of(context)!.price}:",
                            controller: editBankBloc.priceController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SafeArea(
              top: false,
              child: Container(
                width: double.infinity,
                height: 55,
                margin: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: kButtonThemeStyle,
                  child: Text(
                    AppLocalizations.of(context)!.save,
                    style: kBlackButtonTextStyle.copyWith(
                      color: ColorRes.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
