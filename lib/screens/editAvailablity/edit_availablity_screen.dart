import 'package:cutfx_salon/bloc/editavailablity/edit_availability_bloc.dart';
import 'package:cutfx_salon/screens/editAvailablity/edit_salon_availability.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditAvailabilityScreen extends StatelessWidget {
  const EditAvailabilityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditAvailabilityBloc(),
      child: Scaffold(
        body: Column(
          children: [
            ToolBarWidget(
              title: AppLocalizations.of(context)!.editAvailabilitySlots,
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: EditSalonAvailabilityWidget(),
              ),
            ),
            SafeArea(
              top: false,
              child: BlocBuilder<EditAvailabilityBloc, EditAvailabilityState>(
                builder: (context, state) {
                  return Container(
                    width: double.infinity,
                    height: 55,
                    margin:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 15),
                    child: TextButton(
                      onPressed: () {
                        context.read<EditAvailabilityBloc>().onTapSubmit();
                      },
                      style: kButtonThemeStyle,
                      child: Text(
                        AppLocalizations.of(context)!.submit,
                        style: kBlackButtonTextStyle.copyWith(
                          color: ColorRes.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
