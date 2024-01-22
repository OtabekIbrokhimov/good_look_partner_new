import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class CreationScreen extends StatelessWidget {
  const CreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F4E8),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 25),
              alignment: Alignment.bottomCenter,
              height: 153,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: ColorRes.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(45),
                  bottomRight: Radius.circular(45),
                ),
              ),
              child: const Image(
                image: AssetImage("images/PARTNER.png"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: Get.height - 175,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.assalamuAlaikum,
                      style: kBlackButtonTextStyle.copyWith(fontSize: 25)),
                  Text(AppLocalizations.of(context)!.fullName,
                      style: kBlackButtonTextStyle.copyWith(
                          fontSize: 25, fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(AppLocalizations.of(context)!.continueAs,
                      style: kBlackButtonTextStyle.copyWith(fontSize: 25)),
                  const SizedBox(
                    height: 20,
                  ),
                  CreateWidget(
                    titles: [],
                    function: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CreateWidget(
                    titles: const ["Pro Connect", "Pro Agency"],
                    function: () {},
                    isMaster: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {},
                      child: Text(AppLocalizations.of(context)!.logOutAccount,
                          style: kRegularTextStyle),
                    ),
                  ),
                  const Spacer(),
                  const Center(
                      child: Image(image: AssetImage("images/prosfera.png"))),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CreateWidget extends StatelessWidget {
  final List titles;
  final bool isMaster;
  final Function function;

  const CreateWidget({
    super.key,
    required this.titles,
    this.isMaster = true,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image(
                image: isMaster
                    ? const AssetImage(
                        "images/account.png",
                      )
                    : const AssetImage(
                        "images/salon_icon.png",
                      ),
                color: ColorRes.black,
                width: 15,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                isMaster
                    ? AppLocalizations.of(context)!.master
                    : AppLocalizations.of(context)!.salon,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'GT Walsheim Pro',
                  fontWeight: FontWeight.w500,
                  height: 0.05,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              height: (54 * titles.length).toDouble(),
              child: Column(
                children: [
                  for (int index = 0; index < titles.length; index++)
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      width: double.infinity,
                      height: 49,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF6F6F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: ColorRes.greyD9,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            titles[index],
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'GT Walsheim Pro',
                              fontWeight: FontWeight.w500,
                              height: 0.05,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              )),
          titles.isNotEmpty
              ? const SizedBox(
                  height: 10,
                )
              : const SizedBox.shrink(),
          Container(
            width: 345,
            height: 49,
            decoration: ShapeDecoration(
              color: const Color(0xFFF6F6F6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                Get.bottomSheet(CreationBottomsheet(
                  isMaster: isMaster,
                  function: () {},
                ));
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(Icons.add),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    isMaster
                        ? AppLocalizations.of(context)!.createMaster
                        : AppLocalizations.of(context)!.createSalon,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'GT Walsheim Pro',
                      fontWeight: FontWeight.w500,
                      height: 0.05,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class CreationBottomsheet extends StatelessWidget {
  final bool isMaster;
  final Function function;

  const CreationBottomsheet({
    Key? key,
    required this.isMaster,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: Get.width,
        height: 700,
        decoration: const BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 6,
                width: 106,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: ColorRes.greyD9),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  isMaster
                      ? AppLocalizations.of(context)!.createMaster
                      : AppLocalizations.of(context)!.createSalon,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: 'GT Walsheim Pro',
                    fontWeight: FontWeight.w500,
                    height: 0.05,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.close,
                    size: 30,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              isMaster
                  ? AppLocalizations.of(context)!.masterName
                  : AppLocalizations.of(context)!.salonName,
              style: kRegularTextStyle.copyWith(
                  color: ColorRes.black, fontSize: 20),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(bottom: 5),
              width: double.infinity,
              height: 49,
              decoration: BoxDecoration(
                color: ColorRes.white,
                boxShadow: [
                  BoxShadow(
                    color: ColorRes.black.withOpacity(0.2),
                    blurRadius: 5,
                  )
                ],
                borderRadius: BorderRadius.circular(13),
              ),
              alignment: Alignment.centerLeft,
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: isMaster
                      ? AppLocalizations.of(context)!.fullName
                      : AppLocalizations.of(context)!.enterSalonName,
                  hintStyle: kRegularTextStyle.copyWith(
                      color: ColorRes.textColor5757, fontSize: 20),
                ),
                //isMaster ? "ФАМИЛИЯ ИМЯ" : "Введите Наименование салона",
                style: kRegularTextStyle.copyWith(
                    color: ColorRes.textColor5757, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              isMaster
                  ? AppLocalizations.of(context)!.yourProfession
                  : AppLocalizations.of(context)!.pROBUSINESSaccount,
              style: kRegularTextStyle.copyWith(
                  color: ColorRes.black, fontSize: 20),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(bottom: 5),
              width: double.infinity,
              height: 49,
              decoration: BoxDecoration(
                color: ColorRes.white,
                boxShadow: [
                  BoxShadow(
                    color: ColorRes.black.withOpacity(0.2),
                    blurRadius: 5,
                  )
                ],
                borderRadius: BorderRadius.circular(13),
              ),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    isMaster
                        ? AppLocalizations.of(context)!.selectPROJOBentries
                        : AppLocalizations.of(context)!
                            .selectPROBUSINESSaccount,
                    style: kRegularTextStyle.copyWith(
                        color: ColorRes.textColor5757, fontSize: 20),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_drop_down_sharp),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 345,
              height: 42,
              decoration: ShapeDecoration(
                color: const Color(0xFFF6F6F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(Icons.add),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                        isMaster
                            ? AppLocalizations.of(context)!.addEntryToPROJOB
                            : AppLocalizations.of(context)!
                                .selectPROBUSINESSaccount,
                        style: kRegularTextStyle),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Spacer(),
            InkWell(
              child: Container(
                width: 345,
                height: 49,
                decoration: ShapeDecoration(
                  color: ColorRes.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.save,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'GT Walsheim Pro',
                        fontWeight: FontWeight.w500,
                        height: 0.05,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
