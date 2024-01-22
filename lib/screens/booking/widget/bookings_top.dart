import 'package:cutfx_salon/bloc/bookings/bookings_bloc.dart';
import 'package:cutfx_salon/screens/booking/widget/select_month_dialog.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookingsTopWidget extends StatefulWidget {
  final Function(int month, int year) onDoneClick;

  const BookingsTopWidget({
    Key? key,
    required this.onDoneClick,
  }) : super(key: key);

  @override
  State<BookingsTopWidget> createState() => _BookingsTopWidgetState();
}

class _BookingsTopWidgetState extends State<BookingsTopWidget> {
  @override
  Widget build(BuildContext context) {
    BookingsBloc bookingsBloc = context.read<BookingsBloc>();
    return Container(
      color: ColorRes.themeColor5,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.bookings,
                style: kRegularThemeTextStyle.copyWith(
                  fontSize: 22,
                ),
              ),
              const Spacer(),
              CustomCircularInkWell(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (context) => SelectMonthDialog(
                      onDoneClick: widget.onDoneClick,
                      month: bookingsBloc.month,
                      year: bookingsBloc.year,
                    ),
                  );
                  // await SimpleMonthYearPicker.showMonthYearPickerDialog(
                  //   context: context,
                  //   titleFontFamily: AssetRes.fnGTWalsheimProBlack,
                  //   selectionColor: ColorRes.themeColor,
                  //   monthTextFontFamily: AssetRes.fnGTWalsheimProMedium,
                  //   yearTextFontFamily: AssetRes.fnGTWalsheimProBold,
                  // );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorRes.themeColor10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  child: Row(
                    children: [
                      const Image(
                        image: AssetImage(
                          AssetRes.icCalender,
                        ),
                        color: Colors.black,
                        height: 22,
                        width: 22,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        '${AppRes.convertMonthNumberToName(context, bookingsBloc.month)} ${bookingsBloc.year}',
                        style: kMediumThemeTextStyle.copyWith(
                          fontSize: 17,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
