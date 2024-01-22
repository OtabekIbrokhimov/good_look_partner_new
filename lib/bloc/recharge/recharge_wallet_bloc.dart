import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/setting/setting.dart';
import '../../model/user/salon_user.dart';
import '../../utils/app_res.dart';
import '../../utils/shared_pref.dart';

part 'recharge_wallet_event.dart';
part 'recharge_wallet_state.dart';

class RechargeWalletBloc
    extends Bloc<RechargeWalletEvent, RechargeWalletState> {
  RechargeWalletBloc() : super(RechargeWalletInitial()) {
    on<FetchRechargeWalletEvent>((event, emit) async {
      SharePref sharePref = await SharePref().init();
      //userData = sharePref.getSalonUser();
      settings = sharePref.getSettings()?.data;
      emit(UserDataFoundRechargeWalletState());
    });
    add(FetchRechargeWalletEvent());
  }

  SalonUser? userData;
  FocusNode amountFocusNode = FocusNode();
  SettingData? settings;
  int type = 0;
  String selectedAmount = '0';
  TextEditingController amountTextController = TextEditingController();

  // void onContinueTap() async {
  //   amountFocusNode.unfocus();
  //   selectedAmount = type == 0
  //       ? '50'
  //       : type == 1
  //           ? '100'
  //           : type == 2
  //               ? '150'
  //               : amountTextController.text;
  //   if (settings?.paymentGateway == 1) {
  //     SharePref sharePref = await SharePref().init();
  //     // await Stripe.instance.applySettings();
  //     // Stripe.publishableKey =
  //     //     sharePref.getSettings()?.data?.stripePublishableKey ?? '';
  //     // StripePayment().makePayment(
  //     //   amount: selectedAmount.toString(),
  //     //   currency: settings?.stripeCurrencyCode ?? '',
  //     //   user: userData?.data,
  //     //   authKey: settings?.stripeSecret ?? '',
  //     //   onError: (error) {
  //     //     AppRes.showSnackBar(
  //     //         AppLocalizations.of(Get.context!)!.paymentFailed, false);
  //     //   },
  //     //   onSuccess: (value) {
  //     //     apiCall(type,
  //     //         paymentGateway: 1,
  //     //         transactionId: value['id'],
  //     //         transactionSummary: jsonEncode(value));
  //     //   },
  //    // );
  //   } else if (settings?.paymentGateway == 3) {
  //     /// card Payment :- 4111 1111 1111 1111
  //     RazorPayPayment().makePayment(
  //       amount: selectedAmount.toString(),
  //       authKey: settings?.razorpayKey ?? '',
  //       currency: settings?.razorpayCurrencyCode ?? '',
  //       user: userData?.data,
  //       handleExternalWalletSelected: (response) {
  //         AppRes.showSnackBar(response.toString(), false);
  //       },
  //       handlePaymentErrorResponse: (response) {
  //         AppRes.showSnackBar(response.message.toString(), false);
  //       },
  //       handlePaymentSuccessResponse: (response) {
  //         Map<String, dynamic> map = {};
  //         map["razorpay_payment_id"] = response.paymentId;
  //         map["razorpay_signature"] = response.signature;
  //         map["razorpay_order_id"] = response.orderId;
  //
  //         String data = jsonEncode(map);
  //         apiCall(type,
  //             paymentGateway: 3,
  //             transactionSummary: data,
  //             transactionId: response.paymentId.toString());
  //       },
  //     );
  //   } else if (settings?.paymentGateway == 4) {
  //     ///Test card:- 4084084084084081
  //     ///03/24
  //     ///408
  //     PaystackPayment().makePayment(
  //       user: userData?.data,
  //       amount: selectedAmount.toString(),
  //       publicKey: settings?.paystackPublicKey ?? '',
  //       authKey: settings?.paystackSecretKey ?? '',
  //       currency: settings?.paystackCurrencyCode ?? '',
  //       onSuccess: (response) {
  //         if (jsonDecode(response)['status'] == true) {
  //           apiCall(type,
  //               paymentGateway: 4,
  //               transactionId: jsonDecode(response)['data']['reference'],
  //               transactionSummary: jsonEncode(response));
  //         } else {
  //           AppRes.showSnackBar(
  //               AppLocalizations.of(Get.context!)!.paymentCancelled, false);
  //         }
  //       },
  //     );
  //   } else if (settings?.paymentGateway == 5) {
  //     /// Card Type: Visa
  //     /// Card Number: 4032 0323 7188 0367
  //     /// Expiration Date: 01/2024
  //     /// CVV: 571
  //     PaypalPayment().makePayment(
  //       user: userData?.data,
  //       amount: selectedAmount.toString(),
  //       currency: settings?.paypalCurrencyCode ?? 'USD',
  //       authKey: settings?.paypalSecretKey ?? '',
  //       clientId: settings?.paypalClientId ?? '',
  //       onSuccess: (param) {
  //         apiCall(type,
  //             paymentGateway: 5,
  //             transactionId: param['paymentId'],
  //             transactionSummary: jsonEncode(param));
  //       },
  //       onError: (error) {
  //         AppRes.showSnackBar(
  //             AppLocalizations.of(Get.context!)!.somethingWentWrong, false);
  //       },
  //       onCancel: (param) {
  //         AppRes.showSnackBar(
  //             AppLocalizations.of(Get.context!)!.paymentCancelled, false);
  //       },
  //     );
  //   } else if (settings?.paymentGateway == 6) {
  //     /// 'Card number' = 5531 8866 5214 2950
  //     /// 'Expiry' = 09 / 32
  //     /// 'CVV' = 564
  //     /// 'OTP' = 12345
  //     /// 'PIN' = 3310
  //     FlutterwavePayment().makePayment(
  //       user: userData?.data,
  //       amount: selectedAmount.toString(),
  //       publishKey: settings?.flutterwavePublicKey ?? '',
  //       currency: settings?.flutterwaveCurrencyCode ?? 'USD',
  //       onError: (error) {
  //         AppRes.showSnackBar(error, false);
  //       },
  //       onSuccess: (param) {
  //         apiCall(
  //           type,
  //           paymentGateway: 6,
  //           transactionId: param.transactionId ?? '',
  //           transactionSummary: jsonEncode(param),
  //         );
  //       },
  //     );
  //   }
  // }

  void apiCall(int type,
      {required int paymentGateway,
      required String transactionId,
      required String transactionSummary}) {
    if (type == 1) {
      addMoneyApiCall(
          paymentGateway: paymentGateway,
          transactionSummary: transactionSummary,
          transactionId: transactionId);
    } else {
      addMoneyApiCall(
              paymentGateway: paymentGateway,
              transactionSummary: transactionSummary,
              transactionId: transactionId)
          .then((value) {
        // Get.bottomSheet(const TransactionCompleteSheet(),
        //     isScrollControlled: true);
      });
    }
  }

  Future<void> addMoneyApiCall(
      {required int paymentGateway,
      required String transactionId,
      required String transactionSummary}) async {
    AppRes.showCustomLoader();
    // await ApiService()
    //     .addMoneyToUserWallet(
    //         amount: int.parse(selectedAmount),
    //         paymentGateway: paymentGateway,
    //         transactionId: transactionId,
    //         transactionSummary: transactionSummary)
    //     .then((value) {
    //   AppRes.hideCustomLoaderWithBack();
    //   AppRes.showSnackBar(value.message!, value.status ?? false);
    // });
  }

  void selectAmountType(int type) {
    this.type = type;
    add(FetchRechargeWalletEvent());
  }
}
