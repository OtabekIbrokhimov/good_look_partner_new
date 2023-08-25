import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewScreen extends StatelessWidget {
  final String? imageUrl;

  const ImagePreviewScreen({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            bottom: false,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 38,
                height: 38,
                margin: const EdgeInsets.only(left: 20, top: 10),
                decoration: const BoxDecoration(
                  color: ColorRes.themeColor5,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: ColorRes.white,
                  size: 18,
                ),
              ),
            ),
          ),
          Expanded(
            child: PhotoView(
              imageProvider: NetworkImage(
                '${ConstRes.itemBaseUrl}$imageUrl',
              ),
              filterQuality: FilterQuality.high,
              loadingBuilder: (context, event) {
                return const LoadingImage();
              },
              errorBuilder: errorBuilderForImage,
            ),
          ),
        ],
      ),
    );
  }
}
