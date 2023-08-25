import 'package:cutfx_salon/bloc/mysalon/my_salon_bloc.dart';
import 'package:cutfx_salon/model/service/services.dart';
import 'package:cutfx_salon/screens/manageServices/item_manage_service.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/user/salon.dart';
import '../main/main_screen.dart';

class SalonServicesPage extends StatelessWidget {
  const SalonServicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MySalonBloc, MySalonState>(
      builder: (context, state) {
        Salon? salon;
        if (state is MySalonDataFetched) {
          salon = state.salon;
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.all(0),
                itemCount: salon?.data?.categories?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index) => ItemSalonDetailsService(
                  categories: salon?.data?.categories?[index],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ItemSalonDetailsService extends StatelessWidget {
  final Categories? categories;

  const ItemSalonDetailsService({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            '${categories?.title}'.toUpperCase(),
            style: kLightWhiteTextStyle.copyWith(
              color: ColorRes.themeColor,
              letterSpacing: 2,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: categories?.services?.length ?? 0,
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return ItemManageService(
                serviceData: ServiceData.fromJson(
                  categories?.services?[index].toJson(),
                ),
                isShowFromManage: false,
              );
            },
          ),
        ],
      ),
    );
  }
}

class PlusMinusImageWidget extends StatefulWidget {
  final Function(bool isAdded)? onTapChange;

  const PlusMinusImageWidget({
    Key? key,
    this.onTapChange,
  }) : super(key: key);

  @override
  State<PlusMinusImageWidget> createState() => _PlusMinusImageWidgetState();
}

class _PlusMinusImageWidgetState extends State<PlusMinusImageWidget> {
  bool serviceIsAdded = false;

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: () {},
      child: const BgRoundImageWidget(
        image: AssetRes.icEdit,
        imagePadding: 7,
        bgColor: ColorRes.themeColor,
        height: 35,
        width: 35,
      ),
    );
  }
}
