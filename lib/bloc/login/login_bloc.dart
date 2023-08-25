import 'package:cutfx_salon/screens/ban/salon_ban_screen.dart';
import 'package:cutfx_salon/screens/main/main_screen.dart';
import 'package:cutfx_salon/screens/registration/registration_screen.dart';
import 'package:cutfx_salon/screens/registration/sign_up_done_screen.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
  }

  void onContinueClick() async {
    if (emailAddressController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterEmailAddress,
        false,
      );
      return;
    }
    if (passwordController.text.isEmpty) {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.pleaseEnterPassword,
        false,
      );
      return;
    }
    AppRes.showCustomLoader();
    UserCredential userCredential = await _auth
        .signInWithEmailAndPassword(
      email: emailAddressController.text,
      password: passwordController.text,
    )
        .onError((error, stackTrace) {
      Get.back();
      // AppRes.showSnackBar(
      //     AppLocalizations.of(Get.context!)!.passwordDoesNotMatch,false,);
      FirebaseAuthException map = error as FirebaseAuthException;
      switch (map.code) {
        case "invalid-email":
        case "wrong-password":
        case "user-not-found":
          {
            AppRes.showSnackBar("Wrong email address or password.", false);
            break;
          }
        case "too-many-requests":
        case "temail-already-in-use":
          {
            AppRes.showSnackBar(
                "The email address is already in use by another account.",
                false);
            break;
          }
        case "user-disabled":
          {
            AppRes.showSnackBar("This account is disabled", false);
            break;
          }
      }
      return Future.delayed(const Duration(seconds: 1));
    });
    if (userCredential.user != null) {
      ApiService()
          .salonRegistration(
        email: emailAddressController.text,
        isRegistration: false,
      )
          .then((value) {
        if (value.data?.status == 2) {
          Get.off(() => const BanSalonInfoScreen());
        } else if (value.data?.bankAccount == null) {
          Get.off(() => const RegistrationScreen());
        } else if (value.data?.status?.toInt() == 0) {
          Get.off(() => const SignUpDoneScreen());
          return;
        } else {
          Get.off(() => const MainScreen());
        }
      });
    } else {
      AppRes.showSnackBar(
        AppLocalizations.of(Get.context!)!.userAlreadyExist,
        false,
      );
    }
    Get.back();
  }
}
