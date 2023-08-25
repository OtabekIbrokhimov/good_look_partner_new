import 'package:cutfx_salon/bloc/notification/notification_bloc.dart';
import 'package:cutfx_salon/model/notification/notification.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc(),
      child: Column(
        children: [
          Container(
            color: ColorRes.themeColor5,
            width: double.infinity,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Text(
                  AppLocalizations.of(context)!.notifications,
                  style: kRegularThemeTextStyle.copyWith(
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
                NotificationBloc notificationBloc =
                    context.read<NotificationBloc>();
                return state is NotificationInitial
                    ? const Center(
                        child: LoadingData(),
                      )
                    : notificationBloc.notifications.isNotEmpty
                        ? ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            itemCount: notificationBloc.notifications.length,
                            controller: notificationBloc.scrollController,
                            itemBuilder: (context, index) {
                              Data notificationData =
                                  notificationBloc.notifications[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    notificationData.title ?? '',
                                    style: kRegularTextStyle.copyWith(
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    notificationData.description ?? '',
                                    style: kLightWhiteTextStyle.copyWith(
                                      color: ColorRes.empress,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    color: ColorRes.empress,
                                    height: 0.2,
                                  ),
                                ],
                              );
                            },
                          )
                        : const DataNotFound();
              },
            ),
          ),
        ],
      ),
    );
  }
}
