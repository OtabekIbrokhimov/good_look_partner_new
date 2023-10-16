import 'package:cutfx_salon/model/status_message.dart';
import 'package:cutfx_salon/model/user/salon.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../model/masters/master_responce.dart';
import '../../service/api_service.dart';
import '../../utils/shared_pref.dart';

part 'master_list_event.dart';
part 'master_list_state.dart';

class MasterListBloc extends Bloc<MasterListEvent, MasterListState> {
  MasterListBloc() : super(MasterListInitial()) {
    fetchMasters();
    on<MasterListChangeEvent>((event, emit) {
      emit(MasterListChangeState());
    });
  }

  void fetchMasters() async {
    SharePref sharePref = await SharePref().init();
    Salon? salon = sharePref.getSalon();
    masterList =
        await ApiService().fetchMasterList(salon?.data?.id.toString() ?? "");
    add(MasterListChangeEvent());
  }

  void deleteMaster(String id) async {

    StatusMessage statusMessage = await ApiService().deleteMaster(id: id);
    if (statusMessage.status == true) {
      Get.back();
      AppRes.showSnackBar(
          statusMessage.message ?? "successfully deleted", true);
      fetchMasters();
    } else {
      Get.back();
      AppRes.showSnackBar(statusMessage.message ?? "try again", false);
    }
  }

  MasterList? masterList;
}
