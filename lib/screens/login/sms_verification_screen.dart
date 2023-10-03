import 'package:cutfx_salon/bloc/login/login_bloc.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:mask_input_formatter/mask_input_formatter.dart';

import '../../utils/asset_res.dart';
import '../../utils/style_res.dart';

class SmsCodePage extends StatelessWidget {
  final String phone;
  final bool isLoading;
  final bool isSuccess;
  final bool needFullName ;
  final Function()? verifyCode;

  const SmsCodePage(
      {Key? key,
      required this.phone,
      this.verifyCode,
      this.isLoading = false,
      this.isSuccess = false,
      this.needFullName = false})
      : super(key: key);

  submit() {
    if (isSuccess && verifyCode != null) verifyCode?.call();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: ColorRes.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          elevation: 0,
          backgroundColor: ColorRes.white,
          title: const Text(
            "Phone Check",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorRes.themeColor,
              fontFamily: AssetRes.fnProductSansRegular,
            ),
          ),
        ),
        body: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            LoginBloc emailLoginBloc = context.read<LoginBloc>();
            emailLoginBloc.firstTimeCalculate
                ? emailLoginBloc.calculateSmsTime()
                : () {};
            return SingleChildScrollView(
                child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Text(
                      textAlign: TextAlign.center,
                      AppLocalizations.of(context)?.weSentOtp ?? "",
                      style: kLightWhiteTextStyle.copyWith(
                        color: ColorRes.empress,
                        fontSize: 18,
                      ),
                    )),
                    const SizedBox(
                      height: 50,
                    ),

                    ///show number
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "+$phone",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: ColorRes.black),
                      ),
                    ),

                    const SizedBox(height: 50),
                    Visibility(
                      visible: needFullName,
                      child: TextWidget(
                        emailLoginBloc: emailLoginBloc,
                        isFullName: true,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextWidget(emailLoginBloc: emailLoginBloc),
                    GestureDetector(
                        onTap: () {
                          emailLoginBloc.getMainPage(phone, needFullName);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: emailLoginBloc.needVerify
                                ? ColorRes.black
                                : ColorRes.smokeWhite,
                          ),
                          height: 55,
                          child: Text(
                            AppLocalizations.of(context)?.verify ?? "",
                            style: !emailLoginBloc.needVerify
                                ? kThemeButtonTextStyle
                                : const TextStyle(
                                    color: ColorRes.white,
                                    fontFamily: AssetRes.fnProductSansRegular,
                                    fontSize: 16,
                                  ),
                          ),
                        )),
                    const SizedBox(height: 14),

                    ///Timer
                    ResentSmsCodeWidget(
                        resend: () {
                          emailLoginBloc.checkTime();
                          emailLoginBloc.calculateSmsTime();
                        },
                        time: emailLoginBloc.smsCodeTime,
                        needResend: emailLoginBloc.needReset),

                    ///button
                    const Spacer(),
                  ],
                ),
              ),
            ));
          },
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  final bool isFullName;

  const TextWidget({
    super.key,
    required this.emailLoginBloc,
    this.isFullName = false,
  });

  final LoginBloc emailLoginBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorRes.smokeWhite,
      ),
      child: TextField(
        inputFormatters: isFullName
            ? []
            : [
                MaskInputFormatter(mask: '######'),
              ],
        controller: isFullName
            ? emailLoginBloc.fullNameTextController
            : emailLoginBloc.smsCodeController,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        onChanged: emailLoginBloc.onChangedPinCode,
        decoration: InputDecoration(
            hintText: isFullName
                ? "Please! enter your full name "
                : AppLocalizations.of(context)?.enterYourOneTimeCode,
            border: InputBorder.none),
      ),
    );
  }
}

class ResentSmsCodeWidget extends StatelessWidget {
  final int time;
  final Function resend;
  final bool needResend;

  const ResentSmsCodeWidget(
      {Key? key, this.time = 60, required this.resend, this.needResend = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          time.toString().length < 2 ? "00:0$time" : "00:$time",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: ColorRes.themeColor),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            needResend ? resend() : () {};
          },
          child: Text(AppLocalizations.of(context)?.resendCode ?? "",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: needResend ? ColorRes.themeColor : ColorRes.white)),
        )
      ],
    );
  }
}
