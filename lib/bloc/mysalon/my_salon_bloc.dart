import 'package:cutfx_salon/model/user/salon.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../screens/login/email_login_screen.dart';
import '../../utils/shared_pref.dart';

part 'my_salon_event.dart';
part 'my_salon_state.dart';

class MySalonBloc extends Bloc<MySalonEvent, MySalonState> {
  MySalonBloc() : super(MySalonInitial()) {
    on<FetchSalonDataEvent>(
      (event, emit) async {
        SharePref sharePref = await SharePref().init();
        if (sharePref.getSalon() == null) {
          Get.off(() => const EmailLoginScreen());
        }
        emit(MySalonInitial());
        Salon salon = await ApiService().fetchMySalonDetails();
        emit(MySalonDataFetched(salon));
      },
    );
    fetchSalonData();
  }

  void fetchSalonData() async {
    add(FetchSalonDataEvent());
  }
}
