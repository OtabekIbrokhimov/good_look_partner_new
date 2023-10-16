import 'package:cutfx_salon/bloc/manageservices/manage_service_bloc.dart';
import 'package:cutfx_salon/screens/manageServices/item_manage_service.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../manageServices/tab_bar_of_manage_service.dart';

class ChooseServiceScreen extends StatelessWidget {
  const ChooseServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ManageServiceBloc(),
        child: BlocBuilder<ManageServiceBloc, ManageServiceState>(
            builder: (context, state) {
          ManageServiceBloc manageServiceBloc =
              context.watch<ManageServiceBloc>();

          return Scaffold(
              body: ListView(shrinkWrap: true, children: [
            const ToolBarWidget(
              title: "Choose service",
            ),
            SizedBox(
              height: Get.height - 300,
              width: Get.width,
              child: Scaffold(
                body: Column(
                  children: [
                    const TabBarOfManageServiceWidget(),
                    SizedBox(
                      height: Get.height / 2,
                      child: BlocBuilder<ManageServiceBloc, ManageServiceState>(
                        builder: (context, state) {
                          ManageServiceBloc manageServiceBloc =
                              context.watch<ManageServiceBloc>();
                          if (state is LoadingServiceState) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: ColorRes.themeColor,
                              ),
                            );
                          }
                          if (state is ServiceDataFoundState) {
                            return ListView.builder(
                              itemCount: state.services?.length ?? 0,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              itemBuilder: (context, index) =>
                                  ItemManageService(
                                serviceData: state.services?[index],
                                isShowFromManage: true,
                                needEdit: false,
                                list: manageServiceBloc.ids,
                                whenSelected: (v) {
                                  manageServiceBloc.takeIds(v);
                                },
                              ),
                            );
                          }
                          return const DataNotFound();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: SafeArea(
                top: false,
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: TextButton(
                    style: kButtonThemeStyle,
                    onPressed: () {
                      Get.back(result: manageServiceBloc.ids);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.submit,
                      style: kRegularWhiteTextStyle,
                    ),
                  ),
                ),
              ),
            )
          ]));
        }));
  }
}
