import 'package:cutfx_salon/bloc/editbank/edit_bank_bloc.dart';
import 'package:cutfx_salon/screens/editBank/edit_salon_bank_widget.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditBankDetailScreen extends StatelessWidget {
  const EditBankDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => EditBankBloc(),
        child: Column(
          children: [
            ToolBarWidget(
              title: AppLocalizations.of(context)!.editBankDetails,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: EditSalonBankWidget(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<EditBankBloc, EditBankState>(
              builder: (context, state) {
                return SafeArea(
                  top: false,
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    margin:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 15),
                    child: TextButton(
                      onPressed: () {
                        context.read<EditBankBloc>().onTapSubmit();
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
