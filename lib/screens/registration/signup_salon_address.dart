import 'package:cutfx_salon/bloc/singnup/sign_up_bloc.dart';
import 'package:cutfx_salon/bloc/singnup/sign_up_state.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpSalonAddressWidget extends StatelessWidget {
  const SignUpSalonAddressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        SignUpBloc? signUpBloc = context.read<SignUpBloc>();
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                AppLocalizations.of(context)!.aboutSalon,
                style: kLightWhiteTextStyle.copyWith(
                  color: ColorRes.black,
                  fontSize: 16,
                ),
              ),
              AboutSalonTextField(signUpBloc: signUpBloc),
              const SizedBox(
                height: 15,
              ),
              TextWithTextFieldSmokeWhiteWidget(
                title: AppLocalizations.of(context)!.salonAddress,
                controller: signUpBloc.salonAddressController,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                AppLocalizations.of(context)!.salonPhone,
                style: kLightWhiteTextStyle.copyWith(
                  color: ColorRes.black,
                  fontSize: 16,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorRes.smokeWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(top: 5),
                child: Stack(
                  children: [
                    Container(
                      width: Get.width / 4,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: ColorRes.nero,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                    ),
                    InternationalPhoneNumberInput(
                      textFieldController: signUpBloc.salonPhoneController,
                      onInputChanged: (PhoneNumber number) {
                        signUpBloc.salonPhone =
                            '${number.dialCode} ${number.parseNumber()}';
                      },
                      countrySelectorScrollControlled: true,
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.DIALOG,
                        leadingPadding: 7,
                        trailingSpace: true,
                        showFlags: true,
                        useEmoji: true,
                      ),
                      selectorTextStyle: kRegularEmpressTextStyle.copyWith(
                        color: ColorRes.white,
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis,
                      ),
                      textStyle: kRegularEmpressTextStyle.copyWith(
                        color: ColorRes.charcoal50,
                      ),
                      cursorColor: ColorRes.themeColor,
                      keyboardAction: TextInputAction.done,
                      formatInput: true,
                      keyboardType:
                          const TextInputType.numberWithOptions(signed: false),
                      inputDecoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.only(left: 5),
                        isCollapsed: false,
                        counterText: "",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                AppLocalizations.of(context)!.salonLocation,
                style: kLightWhiteTextStyle.copyWith(
                  color: ColorRes.black,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: TextButton(
                  style: kButtonThemeStyle.copyWith(
                    backgroundColor: MaterialStateProperty.all(
                      signUpBloc.latLng != null
                          ? ColorRes.green10
                          : ColorRes.smokeWhite,
                    ),
                  ),
                  onPressed: () {
                    signUpBloc.onFetchLocationClick(signUpBloc);
                  },
                  child: Text(
                    signUpBloc.latLng != null
                        ? AppLocalizations.of(context)!.locationFetched
                        : AppLocalizations.of(context)!.clickToFetchLocation,
                    style: kRegularWhiteTextStyle.copyWith(
                      color: signUpBloc.latLng != null
                          ? ColorRes.green
                          : ColorRes.empress,
                      fontSize: 16,
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

class AboutSalonTextField extends StatefulWidget {
  final SignUpBloc? signUpBloc;

  const AboutSalonTextField({
    Key? key,
    required this.signUpBloc,
  }) : super(key: key);

  @override
  State<AboutSalonTextField> createState() => _AboutSalonTextFieldState();
}

class _AboutSalonTextFieldState extends State<AboutSalonTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorRes.smokeWhite,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
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
            controller: widget.signUpBloc?.aboutSalonController,
            maxLength: 450,
            style: kRegularTextStyle.copyWith(
              fontSize: 15,
              color: ColorRes.charcoal50,
            ),
            onChanged: (value) {
              setState(() {});
            },
            maxLines: 7,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            '${widget.signUpBloc?.aboutSalonController.text.length ?? 00}/450',
            style: kThinWhiteTextStyle.copyWith(
              color: ColorRes.mortar,
            ),
          ),
        ),
      ],
    );
  }
}
