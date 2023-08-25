import 'dart:io';

import 'package:cutfx_salon/bloc/singnup/sign_up_bloc.dart';
import 'package:cutfx_salon/bloc/singnup/sign_up_state.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpSalonImagesWidget extends StatelessWidget {
  const SignUpSalonImagesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        SignUpBloc signUpBloc = context.read<SignUpBloc>();
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                AppLocalizations.of(context)!.uploadMinimum3ImagesOfYourSalon,
                style: kRegularTextStyle,
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 1.25,
              ),
              padding: const EdgeInsets.only(
                top: 10,
                right: 10,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: signUpBloc.salonImages.length > index
                        ? InkWell(
                            onTap: () {
                              signUpBloc.onImageDeleteClick(signUpBloc, index);
                            },
                            child: Stack(
                              children: [
                                Image(
                                  image: FileImage(
                                    File(signUpBloc.salonImages[index]?.path ??
                                        ''),
                                  ),
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1000),
                                      color: Colors.white.withOpacity(.4),
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              signUpBloc.onImageClick(signUpBloc);
                            },
                            child: Stack(
                              children: [
                                DottedBorder(
                                  radius: const Radius.circular(10),
                                  padding: const EdgeInsets.all(1),
                                  borderType: BorderType.RRect,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorRes.smokeWhite,
                                    ),
                                  ),
                                ),
                                const Center(
                                  child: Image(
                                    image: AssetImage(
                                      AssetRes.icPlus,
                                    ),
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
