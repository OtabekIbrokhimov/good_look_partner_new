part of 'earning_report_bloc.dart';

abstract class EarningReportState {}

class EarningReportInitial extends EarningReportState {}

class EarningReportLoadingState extends EarningReportState {}

class EarningReportDataFoundState extends EarningReportState {
  final EarningHistory earningHistory;

  EarningReportDataFoundState(this.earningHistory);
}
