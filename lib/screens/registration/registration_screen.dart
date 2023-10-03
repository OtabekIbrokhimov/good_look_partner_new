import 'package:cutfx_salon/bloc/singnup/sign_up_bloc.dart';
import 'package:cutfx_salon/bloc/singnup/sign_up_event.dart';
import 'package:cutfx_salon/bloc/singnup/sign_up_state.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen(
      {Key? key, required this.phoneNumber, required this.name})
      : super(key: key);
  final String phoneNumber;
  final String name;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignUpBloc(),
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            int selectedPosition = context.read<SignUpBloc>().selectPosition;
            if (state is SignUpPageChangeState) {
              selectedPosition = state.selectedPosition;
            }
            return Column(
              children: [
                Container(
                  color: ColorRes.smokeWhite,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.salon.toUpperCase(),
                              style: const TextStyle(
                                color: ColorRes.themeColor,
                                fontFamily: AssetRes.fnGilroyBlack,
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Text(
                                AppLocalizations.of(context)!.registration,
                                style: const TextStyle(
                                  color: ColorRes.themeColor,
                                  fontFamily: AssetRes.fnProductSansLight,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .enterYourDetailsAndCompleteYourRegistration,
                          style: kLightTextStyle.copyWith(
                            color: ColorRes.empress,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            SignUpProgressWidget(
                              text: AppLocalizations.of(context)!.one,
                              selectIndicator: true,
                              selectBarrier: selectedPosition > 0,
                            ),
                            SignUpProgressWidget(
                              text: AppLocalizations.of(context)!.two,
                              selectBarrier: selectedPosition > 1,
                              selectIndicator: selectedPosition >= 1,
                            ),
                            SignUpProgressWidget(
                              text: AppLocalizations.of(context)!.three,
                              selectBarrier: selectedPosition > 2,
                              selectIndicator: selectedPosition >= 2,
                            ),
                            SignUpProgressWidget(
                              text: AppLocalizations.of(context)!.four,
                              selectBarrier: selectedPosition > 3,
                              selectIndicator: selectedPosition >= 3,
                            ),
                            SignUpProgressWidget(
                              text: AppLocalizations.of(context)!.five,
                              selectBarrier: selectedPosition > 4,
                              selectIndicator: selectedPosition >= 4,
                            ),
                            SignUpProgressWidget(
                              text: AppLocalizations.of(context)!.six,
                              selectBarrier: selectedPosition > 5,
                              selectIndicator: selectedPosition >= 5,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: context.read<SignUpBloc>().list[selectedPosition],
                ),
                SafeArea(
                  top: false,
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    margin:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 15),
                    child: TextButton(
                      onPressed: () {
                        context
                            .read<SignUpBloc>()
                            .add(SignUpNextClickEvent(selectedPosition + 1));
                      },
                      style: kButtonThemeStyle,
                      child: Text(
                        AppLocalizations.of(context)!.next,
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

class SignUpProgressWidget extends StatelessWidget {
  final bool selectIndicator;
  final bool selectBarrier;
  final String text;

  const SignUpProgressWidget({
    Key? key,
    required this.text,
    required this.selectIndicator,
    required this.selectBarrier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: text != AppLocalizations.of(context)!.six ? 2 : 1,
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color:
                  selectIndicator ? ColorRes.themeColor : ColorRes.smokeWhite1,
              borderRadius: const BorderRadius.all(Radius.circular(100)),
            ),
            child: Center(
              child: Text(
                text,
                style: kSemiBoldTextStyle.copyWith(
                    fontSize: 18,
                    color: selectIndicator ? ColorRes.white : ColorRes.empress),
              ),
            ),
          ),
          Visibility(
            visible: text != AppLocalizations.of(context)!.six,
            child: Expanded(
              child: Container(
                color:
                    selectBarrier ? ColorRes.themeColor : ColorRes.smokeWhite1,
                height: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
