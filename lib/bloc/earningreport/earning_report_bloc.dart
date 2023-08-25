import 'package:cutfx_salon/model/earninghistory/earning_history.dart';
import 'package:cutfx_salon/model/user/salon.dart' as salon_;
import 'package:cutfx_salon/service/api_service.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/shared_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'earning_report_event.dart';
part 'earning_report_state.dart';

class EarningReportBloc extends Bloc<EarningReportEvent, EarningReportState> {
  List<SalesData> chartData = [];

  EarningReportBloc() : super(EarningReportInitial()) {
    on<FetchEarningReportEvent>((event, emit) async {
      emit(EarningReportLoadingState());
      SharePref sharePref = await SharePref().init();
      salon = sharePref.getSalon();
      EarningHistory earningHistory =
          await ApiService().fetchSalonEarningHistory(month, year);
      int day = 0;
      int value = 0;
      chartData = [];
      chartData = List<SalesData>.generate(DateTime(year, month + 1, 0).day,
          (index) => SalesData((index + 1).toString(), 0));
      earningHistory.data!.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      for (int i = 0; i < earningHistory.data!.length; i++) {
        Data element = earningHistory.data![i];
        if (day == AppRes.parseDate(element.createdAt ?? '').day) {
          value = value + (element.amount?.toInt() ?? 0);
          chartData[AppRes.parseDate(element.createdAt ?? '').day - 1] =
              SalesData(
                  AppRes.parseDate(element.createdAt ?? '').day.toString(),
                  value);
        } else {
          value = element.amount?.toInt() ?? 0;
          day = AppRes.parseDate(element.createdAt ?? '').day;
          chartData[AppRes.parseDate(element.createdAt ?? '').day - 1] =
              SalesData(
            AppRes.parseDate(element.createdAt ?? '').day.toString(),
            element.amount?.toInt() ?? 0,
          );
        }
      }
      chartData.sort(
        (a, b) => int.parse(a.year).compareTo(int.parse(b.year)),
      );
      emit(EarningReportDataFoundState(earningHistory));
    });
    on<SelectMonthEvent>((event, emit) async {});
    add(FetchEarningReportEvent());
  }

  int month = DateTime.now().month;
  int year = DateTime.now().year;

  salon_.Salon? salon;

  void onMonthSelected(int month, int year) {
    this.month = month;
    this.year = year;
    add(FetchEarningReportEvent());
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final int sales;
}
