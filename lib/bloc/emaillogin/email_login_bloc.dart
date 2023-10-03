
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/otp/otp_responce.dart';

part 'email_login_event.dart';
part 'email_login_state.dart';

class EmailLoginBloc extends Bloc<EmailLoginEvent, EmailLoginState> {
  String phoneNumber = '';
  String phoneNumberWithObuscure = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController phoneNumberTextController = TextEditingController();
  TextEditingController fullNameTextController = TextEditingController();
  TextEditingController smsCodeController = TextEditingController();
  int smsCodeTime = 60;
  String smsCode = "";
  String fullName = "";
  bool firstTimeCalculate = true;
  bool isVisiblePhone = true;
  bool needReset = false;
  bool needVerify = false;



  EmailLoginBloc() : super(EmailLoginInitial()) {
    on<UpdateEmailLoginEvent>((event, emit) async {
      emit(UpdateEmailLoginState());
    });
    on<UpdateSmsCodeTime>((event, emit) async {
      emit(UpdateSmsState());
    });

    on<CheckSmsCode>((event, emit)  {
      // getMainPage(phoneNumber);
    });



  }
  SendOtpResponce? sendOtpResponce;


  void checkTime() {
    if (smsCodeTime < 60) {
      smsCodeTime = 60;
      needReset = false;
    }
    add(UpdateEmailLoginEvent());
  }

  void calculateSmsTime() async {
    firstTimeCalculate = false;

    for (int i = 0; i < 60; i++) {
      await Future.delayed(const Duration(seconds: 1));
      smsCodeTime -= 1;
      if (smsCodeTime == 0) needReset = true;
      add(UpdateEmailLoginEvent());
    }
  }

  void onChangedPinCode(String value) {
    if (value.length == 6) {
      needVerify = true;
      add(UpdateEmailLoginEvent());
    } else {
      needVerify = false;
      add(UpdateEmailLoginEvent());
    }
  }

//  VerifyResponce? verifyResponse;
// void getMainPage(String phoneNumber) async{
//   if (smsCodeController.text.length != 6) {
//     AppRes.showSnackBar("Please enter sms code", false);
//     return;
//   }else{
//      verifyResponse = await ApiService().verifyOTP(password: smsCodeController.text, phoneNumber: phoneNumber, needName: needVerify);
//      Get.offAll(() => const MainScreen());
//   }
//
// }
}
