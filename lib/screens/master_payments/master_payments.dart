import 'package:cutfx_salon/bloc/master_payment_block/master_payments_blog.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class MAsterPaymentScreen extends StatelessWidget {
  const MAsterPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => MasterPaymentsBloc(),
        child: Column(
          children: [
            ToolBarWidget(
              title: AppLocalizations.of(context)!.mastersAllowance,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: BlocBuilder<MasterPaymentsBloc, EditMasterState>(
                  builder: (context, state) {
                    MasterPaymentsBloc editBankBloc =
                        context.read<MasterPaymentsBloc>();
                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.selectSalon,
                            style: kRegularTextStyle.copyWith(
                                color: ColorRes.black, fontSize: 16),
                          ),
                          const MastersSalonWidget(),
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
                        color: ColorRes.white, fontSize: 20),
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

class MastersSalonWidget extends StatelessWidget {
  const MastersSalonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width,
          height: 61,
          decoration: ShapeDecoration(
            color: const Color(0xFFF6F6F6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
          ),
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {},
            child: const Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: ColorRes.greyD9,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("PRO Barbershop", style: kRegularTextStyle),
                Spacer(),
                InkWell(
                  child: Icon(Icons.keyboard_arrow_down_sharp),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: Get.width,
            height: 140,
            decoration: ShapeDecoration(
              color: const Color(0xFFF6F6F6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    boxShadow: [
                      BoxShadow(
                        color: ColorRes.black.withOpacity(0.2),
                        blurRadius: 5,
                      )
                    ],
                    borderRadius: BorderRadius.circular(11),
                  ),
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(AppLocalizations.of(context)!.services,
                            style: kRegularTextStyle),
                        const Spacer(),
                        const InkWell(
                          child: Icon(Icons.keyboard_arrow_down_sharp),
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: Get.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    boxShadow: [
                      BoxShadow(
                        color: ColorRes.black.withOpacity(0.2),
                        blurRadius: 5,
                      )
                    ],
                    borderRadius: BorderRadius.circular(11),
                  ),
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(AppLocalizations.of(context)!.supplementAmount,
                            style: kRegularTextStyle),
                      ],
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
