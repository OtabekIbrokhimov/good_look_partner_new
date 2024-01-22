import 'package:cutfx_salon/bloc/manageworkrequest/work_request_bloc.dart';
import 'package:cutfx_salon/screens/addService/add_service_screen.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../utils/color_res.dart';
import '../../utils/style_res.dart';

class WorkRequestScreen extends StatefulWidget {
  const WorkRequestScreen({super.key});

  @override
  State<WorkRequestScreen> createState() => _WorkRequestScreenState();
}

class _WorkRequestScreenState extends State<WorkRequestScreen> {
  int type = 0;

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      AppLocalizations.of(context)!.active,
      AppLocalizations.of(context)!.overdue
    ];
    return BlocProvider(
      create: (context) => WorkRequestBloc(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorRes.themeColor,
          onPressed: () {
            Get.to(() => const AddServiceScreen());
          },
          child: const Image(
            image: AssetImage(AssetRes.icPlus_),
            height: 30,
            width: 30,
          ),
        ),
        body: Column(
          children: [
            ToolBarWidget(
              title: AppLocalizations.of(context)!.requests,
            ),
            Container(
              height: 55,
              color: ColorRes.white,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List<Widget>.generate(
                  2,
                  (index) {
                    return CustomCircularInkWell(
                      onTap: () {
                        setState(() {
                          type = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: index == type
                              ? ColorRes.themeColor10
                              : ColorRes.smokeWhite,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          border: Border.all(
                            color: index == type
                                ? ColorRes.themeColor
                                : ColorRes.transparent,
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        margin: EdgeInsets.only(
                          right: index == type ? 15 : 10,
                          left: index == type ? 15 : 0,
                          bottom: 10,
                          top: 10,
                        ),
                        child: Center(
                          child: Text(
                            list[index],
                            style: kSemiBoldTextStyle.copyWith(
                              fontSize: 14,
                              color: index == type
                                  ? ColorRes.themeColor
                                  : ColorRes.empress,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: 2,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemBuilder: (context, index) => const WorkRequestItem()))
          ],
        ),
      ),
    );
  }
}

class WorkRequestItem extends StatelessWidget {
  const WorkRequestItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / .40,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: const BoxDecoration(
            color: ColorRes.smokeWhite,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: Image(
                          image: NetworkImage('ks'),
                          fit: BoxFit.cover,
                          loadingBuilder: loadingImage,
                          errorBuilder: (q, w, e) {
                            return errorBuilderForImage(q, w, e,
                                name: "Abdulla");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      bottom: 2,
                      right: 10,
                      left: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Abdulla Abdullayev',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kSemiBoldTextStyle.copyWith(
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          'Стрижка / Массаж',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kRegularTextStyle.copyWith(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "${AppLocalizations.of(context)!.experience} 10 ${AppLocalizations.of(context)!.year}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kRegularTextStyle.copyWith(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 35,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.red),
                              child: Text(
                                AppLocalizations.of(context)!.rejected,
                                style: kRegularTextStyle,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              alignment: Alignment.center,
                              height: 35,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.green),
                              child: Text(
                                AppLocalizations.of(context)!.accept,
                                style: kRegularTextStyle,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
