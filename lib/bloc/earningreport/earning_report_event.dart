part of 'earning_report_bloc.dart';

abstract class EarningReportEvent {}

class FetchEarningReportEvent extends EarningReportEvent {}

class SelectMonthEvent extends EarningReportEvent {
  final int month;
  final int year;

  SelectMonthEvent(this.month, this.year);
}
