import 'dart:io';

import 'package:cutfx_salon/bloc/image/add_image_bloc.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddImageScreen extends StatelessWidget {
  const AddImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AddImageBloc(),
        child: Column(
          children: [
            ToolBarWidget(
              title: AppLocalizations.of(context)!.addImages,
            ),
            BlocBuilder<AddImageBloc, AddImageState>(
              builder: (context, state) {
                AddImageBloc addImageBloc = context.read<AddImageBloc>();
                return Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        CustomCircularInkWell(
                          onTap: () {
                            context
                                .read<AddImageBloc>()
                                .add(AddImageClickEvent());
                          },
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: addImageBloc.imageOfGallery != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                      image: FileImage(
                                        File(
                                            addImageBloc.imageOfGallery?.path ??
                                                ''),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : DottedBorder(
                                    radius: const Radius.circular(10),
                                    padding: const EdgeInsets.all(1),
                                    borderType: BorderType.RRect,
                                    color: ColorRes.empress,
                                    strokeWidth: 1,
                                    dashPattern: const [3],
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: ColorRes.smokeWhite,
                                      ),
                                      child: const Center(
                                        child: Image(
                                          height: 40,
                                          width: 40,
                                          image: AssetImage(AssetRes.icPlus),
                                          color: ColorRes.darkGray,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppLocalizations.of(context)!.descriptionOptional,
                          style: kLightWhiteTextStyle.copyWith(
                            color: ColorRes.black,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: ColorRes.smokeWhite,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              color: ColorRes.smokeWhite,
                              width: 0.5,
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            controller: addImageBloc.descriptionController,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            style: kRegularTextStyle.copyWith(
                              color: ColorRes.charcoal50,
                            ),
                            maxLines: 5,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            '00/100',
                            style: kThinWhiteTextStyle.copyWith(
                              color: ColorRes.mortar,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            BlocBuilder<AddImageBloc, AddImageState>(
              builder: (context, state) {
                return SafeArea(
                  top: false,
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    margin:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: TextButton(
                      onPressed: () {
                        context.read<AddImageBloc>().add(AddSubmitClickEvent());
                      },
                      style: kButtonThemeStyle,
                      child: Text(
                        AppLocalizations.of(context)!.submit,
                        style: kBlackButtonTextStyle.copyWith(
                          color: ColorRes.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
