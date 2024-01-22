import 'package:cutfx_salon/bloc/chat/chat_bloc.dart';
import 'package:cutfx_salon/model/chat/chat.dart';
import 'package:cutfx_salon/screens/chat/bottom_selected_item_bar.dart';
import 'package:cutfx_salon/screens/chat/fancy_button.dart';
import 'package:cutfx_salon/screens/main/main_screen.dart';
import 'package:cutfx_salon/screens/preview/image_preview_screen.dart';
import 'package:cutfx_salon/screens/preview/video_preview_screen.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_bottom_sheet.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/firebase_res.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(),
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          ChatBloc chatBloc = context.read<ChatBloc>();
          return Scaffold(
            body: Column(
              children: [
                Stack(
                  children: [
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: chatBloc.timeStamp.isEmpty ? 1 : 0,
                      child: Container(
                        color: ColorRes.smokeWhite,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SafeArea(
                          bottom: false,
                          child: Row(
                            children: [
                              CustomCircularInkWell(
                                onTap: () => Get.back(),
                                child: Container(
                                  height: 40,
                                  width: 55,
                                  padding: const EdgeInsets.all(5),
                                  child: const Image(
                                    image: AssetImage(AssetRes.icBack),
                                  ),
                                ),
                              ),
                              ClipOval(
                                child: SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: Image(
                                      image: NetworkImage(
                                          '${ConstRes.itemBaseUrl}${chatBloc.salonData?.profileImage ?? (chatBloc.conversation.user?.image ?? '')}'),
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, v, b) {
                                        return errorBuilderForImage(
                                            context, v, b,
                                            name: chatBloc.conversation.user
                                                    ?.username ??
                                                "");
                                      },
                                      loadingBuilder: (context, child, l) {
                                        return loadingImage(context, child, l);
                                      }),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      chatBloc.conversation.user?.username
                                              ?.capitalize ??
                                          '',
                                      style: kBoldThemeTextStyle.copyWith(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      '',
                                      style: kLightWhiteTextStyle.copyWith(
                                        color: ColorRes.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const BgRoundImageWidget(
                              //   image: AssetRes.icMore,
                              //   bgColor: ColorRes.smokeWhite1,
                              //   imagePadding: 5,
                              // ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: chatBloc.timeStamp.isNotEmpty ? 1 : 0,
                      child: Visibility(
                        visible: chatBloc.timeStamp.isNotEmpty,
                        child: BottomSelectedItemBar(
                          onBackTap: chatBloc.onMsgDeleteBackTap,
                          selectedItemCount: chatBloc.timeStamp.length,
                          onItemDelete: () {
                            Get.bottomSheet(
                              ConfirmationBottomSheet(
                                title: chatBloc.timeStamp.length == 1
                                    ? AppLocalizations.of(context)!
                                        .deleteMessage
                                    : '${AppLocalizations.of(context)!.delete} ${chatBloc.timeStamp.length} ${AppLocalizations.of(context)!.messages}',
                                description: '',
                                buttonText:
                                    AppLocalizations.of(context)!.deleteForMe,
                                onButtonClick: chatBloc.onChatItemDelete,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: chatBloc.chatData.length,
                              reverse: true,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 5),
                              itemBuilder: (context, index) {
                                ChatMessage chatMessage =
                                    chatBloc.chatData[index];
                                bool chatIsFromReceiver =
                                    chatMessage.senderUser?.address == null ||
                                        chatMessage
                                            .senderUser!.address!.isEmpty;
                                bool selected = chatBloc.timeStamp
                                    .contains('${chatMessage.id}');
                                return InkWell(
                                  onTap: () {
                                    if (chatBloc.timeStamp.isNotEmpty) {
                                      chatBloc.onLongPress(chatMessage);
                                      return;
                                    }
                                    if (chatMessage.msgType ==
                                        FirebaseRes.image) {
                                      Get.to(
                                        ImagePreviewScreen(
                                          imageUrl: chatMessage.image,
                                        ),
                                      );
                                    } else if (chatMessage.msgType ==
                                        FirebaseRes.video) {
                                      Get.to(
                                        const VideoPreviewScreen(),
                                        arguments: chatMessage.video,
                                      );
                                    }
                                  },
                                  onLongPress: () {
                                    chatBloc.onLongPress(chatMessage);
                                  },
                                  overlayColor: MaterialStateProperty.all(
                                      ColorRes.transparent),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    width: double.infinity,
                                    color: selected
                                        ? ColorRes.themeColor20
                                        : ColorRes.transparent,
                                    child: Column(
                                      crossAxisAlignment: chatIsFromReceiver
                                          ? CrossAxisAlignment.start
                                          : CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: chatIsFromReceiver
                                                ? ColorRes.lavender
                                                : ColorRes.smokeWhite,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                          ),
                                          constraints: const BoxConstraints(
                                            maxWidth: 250,
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                chatIsFromReceiver
                                                    ? CrossAxisAlignment.start
                                                    : CrossAxisAlignment.end,
                                            children: [
                                              Visibility(
                                                visible: chatMessage.msgType ==
                                                        FirebaseRes.image ||
                                                    chatMessage.msgType ==
                                                        FirebaseRes.video,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Image(
                                                    image: NetworkImage(
                                                      '${ConstRes.itemBaseUrl}${chatMessage.image}',
                                                    ),
                                                    errorBuilder:
                                                        errorBuilderForImage,
                                                    loadingBuilder:
                                                        loadingImage,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: chatMessage.msgType ==
                                                            FirebaseRes.image ||
                                                        chatMessage.msgType ==
                                                            FirebaseRes.video
                                                    ? 5
                                                    : 0,
                                              ),
                                              Text(
                                                chatMessage.msg ?? '',
                                                style: kLightWhiteTextStyle
                                                    .copyWith(
                                                  color: chatIsFromReceiver
                                                      ? ColorRes.themeColor
                                                      : ColorRes.mortar,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          AppRes.formatDate(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  int.parse(
                                                      chatMessage.id ?? '0'))),
                                          style: kLightWhiteTextStyle.copyWith(
                                            color: ColorRes.darkGray,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            color: ColorRes.smokeWhite,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            child: SafeArea(
                              top: false,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                      child: Container(
                                        height: 45,
                                        color: ColorRes.smokeWhite1,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: TextField(
                                                  controller:
                                                      chatBloc.msgController,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            CustomCircularInkWell(
                                              onTap: () {
                                                chatBloc.onSendBtnTap();
                                              },
                                              child: const BgRoundImageWidget(
                                                image: AssetRes.icSend,
                                                bgColor: ColorRes.themeColor,
                                                imagePadding: 9,
                                                height: 42,
                                                width: 42,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 55,
                                  ),

                                  // const Image(
                                  //   image: AssetImage(
                                  //     AssetRes.icCirclePlus,
                                  //   ),
                                  //   height: 26,
                                  //   width: 26,
                                  // ),
                                  // const SizedBox(
                                  //   width: 10,
                                  // ),
                                  // const Image(
                                  //   image: AssetImage(
                                  //     AssetRes.icCamera,
                                  //   ),
                                  //   height: 26,
                                  //   width: 26,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 15,
                        bottom: 3,
                        child: SafeArea(
                          top: false,
                          child: FancyButton(
                            onGalleryTap: () {
                              chatBloc.onImageTap(source: ImageSource.gallery);
                            },
                            onCameraTap: () {
                              chatBloc.onImageTap(source: ImageSource.camera);
                            },
                            onVideoTap: () {
                              chatBloc.onVideoTap();
                            },
                            isOpen: chatBloc.isOpen,
                            msgFocusNode: FocusNode(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
