import 'package:cutfx_salon/bloc/addawards/add_awards_bloc.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddAwardScreen extends StatelessWidget {
  const AddAwardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddAwardsBloc(),
      child: Scaffold(
        body: BlocBuilder<AddAwardsBloc, AddAwardsState>(
          builder: (context, state) {
            AddAwardsBloc addAwardsBloc = context.read<AddAwardsBloc>();
            return Column(
              children: [
                ToolBarWidget(
                  title: AppLocalizations.of(context)!.addAward,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWithTextFieldSmokeWhiteWidget(
                          title: AppLocalizations.of(context)!.awardTitle,
                          controller: addAwardsBloc.awardTitleController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextWithTextFieldSmokeWhiteWidget(
                          title: AppLocalizations.of(context)!.awardedBy,
                          controller: addAwardsBloc.awardByController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.description,
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
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                            ),
                            controller: addAwardsBloc.descriptionController,
                            style: kRegularTextStyle.copyWith(
                              color: ColorRes.charcoal50,
                            ),
                            maxLines: 7,
                            maxLength: 300,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            '${addAwardsBloc.descriptionController.text.length}/300',
                            style: kThinWhiteTextStyle.copyWith(
                              color: ColorRes.mortar,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    margin:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: TextButton(
                      onPressed: () {
                        addAwardsBloc.onTapSubmit();
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
