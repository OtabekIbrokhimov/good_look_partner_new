import 'dart:io';

import 'package:cutfx_salon/bloc/singnup/sign_up_bloc.dart';
import 'package:cutfx_salon/bloc/singnup/sign_up_event.dart';
import 'package:cutfx_salon/bloc/singnup/sign_up_state.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

class SignUpSalonBankWidget extends StatelessWidget {
  SignUpSalonBankWidget({Key? key}) : super(key: key);

  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        SignUpBloc signUpBloc = context.read<SignUpBloc>();
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextWithTextFieldSmokeWhiteWidget(
                title: AppLocalizations.of(context)!.bankName,
                controller: signUpBloc.bankNameController,
              ),
              const SizedBox(
                height: 15,
              ),
              TextWithTextFieldSmokeWhiteWidget(
                title: AppLocalizations.of(context)!.accountNumber,
                controller: signUpBloc.accountNumberController,
              ),
              const SizedBox(
                height: 15,
              ),
              TextWithTextFieldSmokeWhiteWidget(
                title: AppLocalizations.of(context)!.reEnterAccountNumber,
                controller: signUpBloc.reEnterAccountNumberController,
              ),
              const SizedBox(
                height: 15,
              ),
              TextWithTextFieldSmokeWhiteWidget(
                title: AppLocalizations.of(context)!.holdersName,
                controller: signUpBloc.holderNameController,
              ),
              const SizedBox(
                height: 15,
              ),
              TextWithTextFieldSmokeWhiteWidget(
                title: AppLocalizations.of(context)!.swiftCode,
                controller: signUpBloc.swiftCodeController,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                AppLocalizations.of(context)!.cancelledChequePhoto,
                style: kLightWhiteTextStyle.copyWith(
                  color: ColorRes.black,
                  fontSize: 17,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.photoShouldBeClear,
                style: kLightWhiteTextStyle.copyWith(
                  color: ColorRes.empress,
                  fontSize: 16,
                ),
              ),
              InkWell(
                onTap: () async {
                  XFile? xFile =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  signUpBloc.cancelledCheque = File(
                    xFile?.path ?? '',
                  );
                  signUpBloc.add(SignUpOwnerPhotoEvent(xFile));
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: ColorRes.smokeWhite,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  height: 120,
                  width: 120,
                  padding: EdgeInsets.all(
                      signUpBloc.cancelledCheque != null ? 0 : 45),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: signUpBloc.cancelledCheque != null
                        ? Image(
                            image: FileImage(signUpBloc.cancelledCheque!),
                            fit: BoxFit.cover,
                          )
                        : const Image(
                            image: AssetImage(AssetRes.icAddImage),
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
