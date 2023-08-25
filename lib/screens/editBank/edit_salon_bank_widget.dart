import 'dart:io';

import 'package:cutfx_salon/bloc/editbank/edit_bank_bloc.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

class EditSalonBankWidget extends StatelessWidget {
  EditSalonBankWidget({Key? key}) : super(key: key);

  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditBankBloc, EditBankState>(
      builder: (context, state) {
        EditBankBloc editBankBloc = context.read<EditBankBloc>();
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
                controller: editBankBloc.bankNameController,
              ),
              const SizedBox(
                height: 15,
              ),
              TextWithTextFieldSmokeWhiteWidget(
                title: AppLocalizations.of(context)!.accountNumber,
                controller: editBankBloc.accountNumberController,
              ),
              const SizedBox(
                height: 15,
              ),
              TextWithTextFieldSmokeWhiteWidget(
                title: AppLocalizations.of(context)!.reEnterAccountNumber,
                controller: editBankBloc.reEnterAccountNumberController,
              ),
              const SizedBox(
                height: 15,
              ),
              TextWithTextFieldSmokeWhiteWidget(
                title: AppLocalizations.of(context)!.holdersName,
                controller: editBankBloc.holderNameController,
              ),
              const SizedBox(
                height: 15,
              ),
              TextWithTextFieldSmokeWhiteWidget(
                title: AppLocalizations.of(context)!.swiftCode,
                controller: editBankBloc.swiftCodeController,
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
                ),
              ),
              InkWell(
                onTap: () async {
                  XFile? xFile =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  editBankBloc.cancelledCheque = File(
                    xFile?.path ?? '',
                  );
                  editBankBloc.add(EditCancelChequePhotoEvent(xFile));
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
                      editBankBloc.cancelledCheque != null ? 0 : 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: editBankBloc.cancelledCheque != null
                        ? Image(
                            image: FileImage(editBankBloc.cancelledCheque!),
                            fit: BoxFit.cover,
                          )
                        : Image(
                            image: NetworkImage(
                              editBankBloc.cancelledChequeUrl ?? '',
                            ),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const ImageNotFound();
                            },
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
