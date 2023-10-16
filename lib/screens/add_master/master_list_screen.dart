import 'package:cutfx_salon/bloc/masterlistblock/master_list_bloc.dart';
import 'package:cutfx_salon/screens/add_master/add_master_screen.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils/asset_res.dart';
import '../../utils/const_res.dart';
import '../../utils/custom/custom_bottom_sheet.dart';
import '../../utils/custom/custom_widget.dart';
import '../main/main_screen.dart';

class MasterListScreen extends StatelessWidget {
  const MasterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MasterListBloc(),
        child: BlocBuilder<MasterListBloc, MasterListState>(
            builder: (context, state) {
          MasterListBloc masters = context.read<MasterListBloc>();

          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.to(
                  () => AddMasterScreen(),
                );
              },
              backgroundColor: ColorRes.themeColor,
              child: const Icon(
                Icons.add,
                size: 40,
              ),
            ),
            backgroundColor: ColorRes.smokeWhite,
            body: Column(
              children: [
                const ToolBarWidget(
                  title: "Master List",
                ),
                Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: masters.masterList?.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return MasterItem(
                              photo:
                                  masters.masterList?.data?[index].photo ?? "",
                              fullName:
                                  masters.masterList?.data?[index].fullname ??
                                      "",
                              delete: () {
                                masters.deleteMaster(masters
                                        .masterList?.data?[index].id
                                        .toString() ??
                                    "");
                              },
                              edit: () {
                                Get.to(
                                    () => AddMasterScreen(
                                          master:
                                              masters.masterList?.data?[index],
                                        ),
                                    arguments:
                                        masters.masterList?.data?[index]);
                              });
                        }))
              ],
            ),
          );
        }));
  }
}

class MasterItem extends StatelessWidget {
  final String photo;
  final String fullName;
  final Function delete;
  final Function edit;

  const MasterItem({
    super.key,
    required this.photo,
    required this.fullName,
    required this.delete,
    required this.edit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: ColorRes.black.withOpacity(0.1),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              child: Image(
                image: NetworkImage('${ConstRes.itemBaseUrl}$photo'),
                fit: BoxFit.cover,
                height: 45,
                width: 45,
                loadingBuilder: loadingImageForCircle,
                errorBuilder: errorBuilderForCircleImage,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(fullName, style: kMediumThemeTextStyle),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: BgRoundImageWidget(
                            image: AssetRes.icEdit,
                            onTap: () {
                              edit();
                            },
                            height: 30,
                            width: 30,
                            imagePadding: 5,
                            bgColor: ColorRes.charcoal50,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: BgRoundImageWidget(
                            image: AssetRes.icRemove,
                            onTap: () {
                              Get.bottomSheet(  ConfirmationBottomSheet(
                                  title: "Delete",
                                  description: "Do you wanna delete this date",
                                  buttonText: AppLocalizations.of(context)!.continue_,
                                  onButtonClick: () {
                                    delete();
                                  }));
                            },
                            height: 30,
                            width: 30,
                            imagePadding: 5,
                            bgColor: ColorRes.charcoal50,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
