import 'package:cutfx_salon/model/bookings/booking.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'bookings_event.dart';
part 'bookings_state.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;

  BookingsBloc() : super(BookingsInitial()) {
    on<BookingsEvent>((event, emit) {});
    on<MonthSelectBookingEvent>((event, emit) {
      year = event.year;
      month = event.month;
      emit(MonthSelectBookingState());
    });
    on<DateSelectBookingEvent>((event, emit) async {
      day = event.day;
      year = event.year;
      month = event.month;
      emit(BookingsInitial());
      var booking = await ApiService().fetchBookingsByDate(
          date: DateFormat('yyyy-MM-dd', Intl.defaultLocale)
              .format(DateTime(year, month, day)));
      emit(DateSelectBookingState(booking.data ?? []));
    });
    add(DateSelectBookingEvent(day, month, year));
  }
}
