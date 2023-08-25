part of 'bookings_bloc.dart';

abstract class BookingsEvent {}

class MonthSelectBookingEvent extends BookingsEvent {
  final int month;
  final int year;

  MonthSelectBookingEvent(this.month, this.year);
}

class DateSelectBookingEvent extends BookingsEvent {
  final int day;
  final int month;
  final int year;

  DateSelectBookingEvent(this.day, this.month, this.year);
}
