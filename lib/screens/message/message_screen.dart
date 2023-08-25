import 'package:cutfx_salon/bloc/messageuser/message_user_bloc.dart';
import 'package:cutfx_salon/screens/message/messages_list_widget.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessageScreen extends StatelessWidget {
  final Function()? onMenuClick;

  const MessageScreen({Key? key, this.onMenuClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageUserBloc(),
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
                  AppLocalizations.of(context)!.messages,
                  style: kRegularThemeTextStyle.copyWith(
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<MessageUserBloc, MessageUserState>(
            builder: (context, state) {
              return Expanded(
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: ColorRes.smokeWhite,
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: AppLocalizations.of(context)!.search,
                          hintStyle: kRegularTextStyle.copyWith(
                            color: ColorRes.darkGray,
                          ),
                        ),
                        style: kRegularTextStyle.copyWith(
                          color: ColorRes.charcoal50,
                        ),
                        onChanged: (value) {
                          context.read<MessageUserBloc>().filterData(value);
                        },
                      ),
                    ),
                    const MessagesListWidget(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
