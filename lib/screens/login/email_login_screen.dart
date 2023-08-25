import 'dart:ui';

import 'package:cutfx_salon/bloc/login/login_bloc.dart';
import 'package:cutfx_salon/screens/login/forgot_password.dart';
import 'package:cutfx_salon/screens/registration/registration_screen.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class EmailLoginScreen extends StatelessWidget {
  const EmailLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            LoginBloc loginBloc = context.read<LoginBloc>();
            return Stack(
              children: [
                const Image(
                  image: AssetImage(AssetRes.bg1),
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    width: double.infinity,
                    decoration:
                        BoxDecoration(color: ColorRes.black.withOpacity(.4)),
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Center(
                              child: AppLogo(
                                textSize: 30,
                              ),
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.signInToContinue,
                            style: kSemiBoldWhiteTextStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .registerYourShopWithUsFindCustomersManageAppointmentsAnd,
                            style: kLightWhiteTextStyle.copyWith(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          TextWithTextFieldWidget(
                            title: AppLocalizations.of(context)!.emailAddress,
                            controller: loginBloc.emailAddressController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextWithTextFieldWidget(
                            title: AppLocalizations.of(context)!.password,
                            isPassword: true,
                            controller: loginBloc.passwordController,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Get.bottomSheet(
                                  const ForgotPasswordBottomSheet());
                            },
                            child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Text(
                                AppLocalizations.of(context)!.forgotPassword_,
                                style: kRegularWhiteTextStyle,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            width: double.infinity,
                            height: 55,
                            child: TextButton(
                              style: kButtonWhiteStyle,
                              onPressed: () {
                                loginBloc.onContinueClick();
                              },
                              child: Text(
                                AppLocalizations.of(context)!.continue_,
                                style: kThemeButtonTextStyle,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => const RegistrationScreen())?.then(
                                (value) {
                                  SystemChrome.setSystemUIOverlayStyle(
                                    SystemUiOverlayStyle.light,
                                  );
                                },
                              );
                            },
                            child: Align(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .newUserRegisterHere,
                                style: kRegularWhiteTextStyle,
                              ),
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).viewInsets.bottom == 0
                                    ? 20
                                    : MediaQuery.of(context).viewInsets.bottom,
                          ),
                        ],
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
