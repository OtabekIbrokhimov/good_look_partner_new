import 'package:cutfx_salon/model/request/request_details.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

part 'request_details_event.dart';
part 'request_details_state.dart';

class RequestDetailsBloc
    extends Bloc<RequestDetailsEvent, RequestDetailsState> {
  RequestDetailsBloc() : super(RequestDetailsInitial()) {
    on<FetchRequestDetailEvent>((event, emit) async {
      Map<String, dynamic> map = Get.arguments;
      RequestDetails requestDetails =
          await ApiService().fetchBookingDetails(map[ConstRes.bookingId]);
      this.requestDetails = requestDetails;
      type = map[ConstRes.type];
      emit(RequestDetailFoundState(requestDetails));
    });
    add(FetchRequestDetailEvent());
  }

  int type = 0;
  RequestDetails? requestDetails;

  void acceptBooking() {
    AppRes.showCustomLoader();
    ApiService()
        .acceptBooking(
      requestDetails?.data?.bookingId ?? '',
    )
        .then((value) {
      AppRes.hideCustomLoaderWithBack();
      AppRes.showSnackBar(value.message ?? '', value.status ?? false);
      type = 1;
      add(FetchRequestDetailEvent());
    });
  }

  void rejectBooking() {
    AppRes.showCustomLoader();
    ApiService()
        .rejectBooking(
      requestDetails?.data?.bookingId ?? '',
    )
        .then((value) {
      AppRes.hideCustomLoaderWithBack();
      AppRes.showSnackBar(value.message ?? '', value.status ?? false);
      type = 1;
      add(FetchRequestDetailEvent());
    });
  }
}
