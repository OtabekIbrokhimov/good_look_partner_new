import 'package:cutfx_salon/bloc/mysalon/my_salon_bloc.dart';
import 'package:cutfx_salon/screens/addImage/add_image.dart';
import 'package:cutfx_salon/screens/salon/gallery/list_widget.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SalonGalleryPage extends StatelessWidget {
  const SalonGalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddImageScreen())?.then((value) {
            context.read<MySalonBloc>().fetchSalonData();
          });
        },
        backgroundColor: ColorRes.themeColor,
        child: const Image(
          image: AssetImage(AssetRes.icPlus_),
          height: 30,
          width: 30,
        ),
      ),
      body: const GalleryListWidget(),
    );
  }
}
