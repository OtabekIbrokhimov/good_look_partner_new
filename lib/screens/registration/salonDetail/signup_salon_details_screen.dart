import 'dart:io';

import 'package:cutfx_salon/bloc/singnup/sign_up_bloc.dart';
import 'package:cutfx_salon/bloc/singnup/sign_up_event.dart';
import 'package:cutfx_salon/bloc/singnup/sign_up_state.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

class SignUpSalonDetailsScreen extends StatelessWidget {
  const SignUpSalonDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePicker imagePicker = ImagePicker();
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        SignUpBloc signUpBloc = context.read<SignUpBloc>();
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                TextWithTextFieldSmokeWhiteWidget(
                  title: AppLocalizations.of(context)!.salonOwnerName,
                  controller: signUpBloc.ownerNameController,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: CustomCircularInkWell(
                        onTap: () async {
                          XFile? xFile = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          signUpBloc.add(SignUpOwnerPhotoEvent(xFile));
                        },
                        child: DottedBorder(
                          color: ColorRes.darkGray,
                          borderType: BorderType.RRect,
                          strokeWidth: 3,
                          dashPattern:
                              signUpBloc.ownerImage != null ? [1000] : [3],
                          radius: const Radius.circular(20),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              color: ColorRes.smokeWhite1,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorRes.darkGray.withOpacity(0.7),
                                  blurRadius: 100,
                                  blurStyle: BlurStyle.outer,
                                ),
                              ],
                            ),
                            child: signUpBloc.ownerImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Image.file(
                                      File(signUpBloc.ownerImage?.path ?? ''),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(
                                    Icons.add_circle,
                                    color: ColorRes.darkGray,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.ownerPhoto,
                            style: kRegularTextStyle.copyWith(
                              color: ColorRes.empress,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .yourFaceShouldBeVisibleCompletelyImageWithSpecsHeadphonesWillNotBeApproved,
                            style: kLightTextStyle.copyWith(
                              color: ColorRes.empress,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextWithTextFieldSmokeWhiteWidget(
                  title: AppLocalizations.of(context)!.salonName,
                  controller: signUpBloc.salonNameController,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextWithTextFieldSmokeWhiteWidget(
                  title: AppLocalizations.of(context)!.emailAddress,
                  controller: signUpBloc.emailController,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextWithTextFieldSmokeWhiteWidget(
                  title: AppLocalizations.of(context)!.password,
                  controller: signUpBloc.passwordController,
                  isPassword: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextWithTextFieldSmokeWhiteWidget(
                  title: AppLocalizations.of(context)!.confirmPassword,
                  controller: signUpBloc.confirmPasswordController,
                  isPassword: true,
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
