part of 'bookings_bloc.dart';

abstract class BookingsState {}

class BookingsInitial extends BookingsState {}

class MonthSelectBookingState extends BookingsState {}

class DateSelectBookingState extends BookingsState {
  List<BookingData> list = [];

  DateSelectBookingState(this.list);
}
