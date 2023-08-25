import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cutfx_salon/bloc/chat/image_send_sheet.dart';
import 'package:cutfx_salon/model/chat/chat.dart';
import 'package:cutfx_salon/model/user/salon.dart';
import 'package:cutfx_salon/model/user/salon_user.dart';
import 'package:cutfx_salon/screens/chat/fancy_button.dart';
import 'package:cutfx_salon/screens/chat/video_upload_dialog.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/firebase_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<FetchChatArgumentsEvent>((event, emit) async {
      conversation = Get.arguments[0];
      senderId = conversation.conversationId ?? '';
      userData = Get.arguments[1];
      add(UpdateChatEvent());
      ApiService()
          .fetchMyUserDetails(conversation.user?.userid ?? -1)
          .then((value) {
        salonData = value.data;
        add(UpdateChatEvent());
        initFireBase();
      });
    });
    on<UpdateChatEvent>((event, emit) async {
      emit(UpdateChatState());
    });
    add(FetchChatArgumentsEvent());
  }

  TextEditingController msgController = TextEditingController();
  TextEditingController sendMediaController = TextEditingController();
  ScrollController scrollController = ScrollController();
  Conversation conversation = Conversation();
  FirebaseFirestore db = FirebaseFirestore.instance;
  late DocumentReference documentReceiver;
  late CollectionReference drChatMessages;
  String firebaseUserIdentity = '';
  String firebaseDoctorIdentity = '';
  List<ChatMessage> chatData = [];
  ChatUser? receiverUser;
  List<String> notDeletedIdentity = [];
  int startingNumber = 30;
  StreamSubscription<QuerySnapshot<ChatMessage>>? chatStream;
  bool isOpen = false;

  // GlobalKey<FancyButtonState> key = GlobalKey<FancyButtonState>();
  String? imageUrl;
  String? videoUrl;
  List<String> timeStamp = [];
  bool isLongPress = false;
  String deletedId = '';
  ChatUser? senderUser;
  DocumentReference? documentSender;
  UserData? salonData;
  static String senderId = '';
  SalonData userData = SalonData();

  void initFireBase() async {
    firebaseDoctorIdentity = conversation.user?.userIdentity ?? '';
    firebaseUserIdentity = '${FirebaseRes.sl}${'${userData.email}'}';

    documentReceiver = db
        .collection(FirebaseRes.userChatList)
        .doc(firebaseDoctorIdentity)
        .collection(FirebaseRes.userList)
        .doc(firebaseUserIdentity);
    documentSender = db
        .collection(FirebaseRes.userChatList)
        .doc(firebaseUserIdentity)
        .collection(FirebaseRes.userList)
        .doc(firebaseDoctorIdentity);

    documentSender
        ?.withConverter(
          fromFirestore: Conversation.fromFireStore,
          toFirestore: (Conversation value, options) {
            return value.toFireStore();
          },
        )
        .get()
        .then(
      (value) async {
        chatData = [];
        if (value.data() != null && value.data()?.conversationId != null) {
          conversation.setConversationId(value.data()?.conversationId);
        }
        drChatMessages = db
            .collection(FirebaseRes.chat)
            .doc(conversation.conversationId)
            .collection(FirebaseRes.chat);
        getChat();
      },
    );
    onScrollToFetchData();
  }

  onScrollToFetchData() {
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        getChat();
      }
    });
  }

  void getChat() async {
    await documentSender
        ?.withConverter(
          fromFirestore: Conversation.fromFireStore,
          toFirestore: (Conversation value, options) {
            return value.toFireStore();
          },
        )
        .get()
        .then((value) {
      if (value.data()?.user != null) {
        senderUser = value.data()?.user;
      }
      deletedId = value.data()?.deletedId.toString() ?? '';
    });

    chatStream = drChatMessages
        .where(FirebaseRes.noDeleteIdentity,
            arrayContains: firebaseUserIdentity)
        .where(FirebaseRes.id,
            isGreaterThan: deletedId.isEmpty ? '0' : deletedId)
        .orderBy(FirebaseRes.id, descending: true)
        .limit(startingNumber)
        .withConverter(
          fromFirestore: ChatMessage.fromFirestore,
          toFirestore: (ChatMessage value, options) {
            return value.toFirestore();
          },
        )
        .snapshots()
        .listen(
      (element) {
        chatData = [];
        for (int i = 0; i < element.docs.length; i++) {
          chatData.add(element.docs[i].data());
        }
        startingNumber += 45;
        add(UpdateChatEvent());
      },
    );
  }

  Future<void> chatMessage({
    required String msgType,
    String? msg,
    String? image,
    String? video,
  }) async {
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    notDeletedIdentity = [];
    notDeletedIdentity.addAll(
      [firebaseUserIdentity, firebaseDoctorIdentity],
    );
    drChatMessages.doc(time).set(
          ChatMessage(
            notDeletedIdentities: notDeletedIdentity,
            senderUser: ChatUser(
                username: userData.salonName,
                msgCount: 0,
                userid: userData.id?.toInt() ?? -1,
                userIdentity: firebaseUserIdentity,
                image: userData.images?[0].image,
                address: userData.salonAddress),
            msgType: msgType,
            msg: msg,
            image: image,
            video: video,
            id: time,
          ).toJson(),
        );

    if (chatData.isEmpty && deletedId.isEmpty) {
      Map con = conversation.toJson();
      con[FirebaseRes.lastMsg] = msgType == FirebaseRes.image
          ? '🖼️ ${FirebaseRes.image}'
          : msgType == FirebaseRes.video
              ? '🎥 ${FirebaseRes.video}'
              : msg;
      documentSender?.set(con);
      documentReceiver.set(
        Conversation(
          conversationId: conversation.conversationId,
          deletedId: '',
          isDeleted: false,
          lastMsg: msgType == FirebaseRes.image
              ? '🖼️ ${FirebaseRes.image}'
              : msgType == FirebaseRes.video
                  ? '🎥 ${FirebaseRes.video}'
                  : msg,
          newMsg: msgType == FirebaseRes.image
              ? '🖼️ ${FirebaseRes.image}'
              : msgType == FirebaseRes.video
                  ? '🎥 ${FirebaseRes.video}'
                  : msg,
          time: time,
          user: ChatUser(
              username: userData.salonName,
              msgCount: 0,
              userid: userData.id?.toInt() ?? -1,
              userIdentity: firebaseUserIdentity,
              image: userData.images?[0].image,
              address: userData.salonAddress),
        ).toJson(),
      );
    } else {
      await documentReceiver
          .withConverter(
            fromFirestore: Conversation.fromFireStore,
            toFirestore: (Conversation value, SetOptions? options) {
              return value.toFireStore();
            },
          )
          .get()
          .then((value) {
        receiverUser = value.data()?.user;
        receiverUser?.msgCount = (receiverUser?.msgCount ?? 0) + 1;

        documentReceiver.update({
          FirebaseRes.time: time,
          FirebaseRes.isDeleted: false,
          FirebaseRes.lastMsg: msgType == FirebaseRes.image
              ? '🖼️ ${FirebaseRes.image}'
              : msgType == FirebaseRes.video
                  ? '🎥 ${FirebaseRes.video}'
                  : msg,
          FirebaseRes.user: receiverUser?.toJson(),
        });
      });
      documentSender?.update(
        {
          FirebaseRes.time: time,
          FirebaseRes.isDeleted: false,
          FirebaseRes.lastMsg: msgType == FirebaseRes.image
              ? '🖼️ ${FirebaseRes.image}'
              : msgType == FirebaseRes.video
                  ? '🎥 ${FirebaseRes.video}'
                  : msg,
        },
      );
    }
    if (salonData?.isNotification == 1) {
      ApiService().pushNotification(
          authorization: ConstRes.authorisationKey,
          title:
              salonData?.fullname ?? AppLocalizations.of(Get.context!)!.unknown,
          body: msgType == FirebaseRes.image
              ? '🖼️ ${FirebaseRes.image}'
              : msgType == FirebaseRes.video
                  ? '🎥 ${FirebaseRes.video}'
                  : '$msg',
          token: '${salonData?.deviceToken}',
          senderIdentity: conversation.conversationId,
          notificationType: '0');
    }
  }

  void onSendBtnTap() {
    if (msgController.text.isNotEmpty) {
      chatMessage(msgType: FirebaseRes.text, msg: msgController.text.trim());
      msgController.clear();
    }
  }

  GlobalKey<FancyButtonState> key = GlobalKey<FancyButtonState>();
  ImagePicker picker = ImagePicker();

  void onImageTap({required ImageSource source}) async {
    // if (source == ImageSource.camera) {
    //   PermissionStatus status = await Permission.camera.request();
    //
    //   if (status != PermissionStatus.granted) {
    //     openAppSettings();
    //     return;
    //   }
    // }
    key.currentState?.animate();
    final XFile? galleryImage = await picker.pickImage(
        source: source,
        imageQuality: AppRes.imageQuality,
        maxHeight: AppRes.maxHeight,
        maxWidth: AppRes.maxWidth);
    if (galleryImage != null) {
      ApiService().uploadFileGivePath(File(galleryImage.path)).then((value) {
        imageUrl = value.path;
      });
      Get.bottomSheet(
              ImageSendSheet(
                image: galleryImage.path,
                onSendMediaTap: (image) =>
                    onSendMediaTap(image: galleryImage.path, type: 0),
                sendMediaController: sendMediaController,
              ),
              isScrollControlled: true)
          .then((value) {
        sendMediaController.clear();
      });
    }
  }

  void onVideoTap() async {
    key.currentState?.animate();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      /// calculating file size
      final videoFile = File(video.path);
      int sizeInBytes = videoFile.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      if (sizeInMb <= 15) {
        AppRes.showCustomLoader();
        ApiService().uploadFileGivePath(File(video.path)).then((value) {
          videoUrl = value.path;
        });
        VideoThumbnail.thumbnailFile(video: video.path).then((value) {
          ApiService().uploadFileGivePath(File(value ?? '')).then((value) {
            imageUrl = value.path;
          });
          Get.back();
          Get.bottomSheet(
                  ImageSendSheet(
                    image: value ?? '',
                    onSendMediaTap: (String image) => onSendMediaTap(
                        image: value ?? '', type: 1, video: videoFile.path),
                    sendMediaController: sendMediaController,
                  ),
                  isScrollControlled: true)
              .then((value) {
            sendMediaController.clear();
          });
        });
      } else {
        showDialog(
          context: Get.context!,
          builder: (context) {
            return VideoUploadDialog(selectAnother: () {
              Get.back();
              onVideoTap();
            });
          },
        );
      }
    }
  }

  void onSendMediaTap(
      {required String image, required int type, String? video}) async {
    if (type == 0) {
      if (imageUrl == null) {
        await ApiService().uploadFileGivePath(File(image)).then((value) {
          imageUrl = value.path;
        });
      }
      Get.back();
      chatMessage(
        msgType: FirebaseRes.image,
        msg: sendMediaController.text.trim(),
        image: imageUrl,
      );
    } else {
      if (videoUrl == null) {
        await ApiService().uploadFileGivePath(File(video ?? '')).then((value) {
          videoUrl = value.path;
        });
      } else if (imageUrl == null) {
        await ApiService().uploadFileGivePath(File(image)).then((value) {
          imageUrl = value.path;
        });
      }
      Get.back();
      chatMessage(
        msgType: FirebaseRes.video,
        msg: sendMediaController.text.trim(),
        image: imageUrl,
        video: videoUrl,
      );
    }
  }

  void onLongPress(ChatMessage? data) {
    if (!timeStamp.contains('${data?.id}')) {
      timeStamp.add('${data?.id}');
    } else {
      timeStamp.remove('${data?.id}');
    }
    isLongPress = true;
    add(UpdateChatEvent());
  }

  void onMsgDeleteBackTap() {
    timeStamp = [];
    add(UpdateChatEvent());
  }

  void onChatItemDelete() {
    for (int i = 0; i < timeStamp.length; i++) {
      drChatMessages.doc(timeStamp[i]).update(
        {
          FirebaseRes.noDeleteIdentity: FieldValue.arrayRemove(
            [firebaseUserIdentity],
          )
        },
      );
      chatData.removeWhere(
        (element) => element.id.toString() == timeStamp[i],
      );
    }
    timeStamp = [];
    Get.back();
    add(UpdateChatEvent());
  }

  @override
  Future<void> close() {
    _msgCountUpdate();
    chatStream?.cancel();
    return super.close();
  }

  Future<void> _msgCountUpdate() async {
    if (senderUser != null) {
      senderUser?.msgCount = 0;
      documentSender?.update({FirebaseRes.user: senderUser?.toJson()});
    } else {
      await documentSender
          ?.withConverter(
            fromFirestore: Conversation.fromFireStore,
            toFirestore: (Conversation value, options) {
              return value.toFireStore();
            },
          )
          .get()
          .then((value) {
        if (value.data()?.user != null) {
          senderUser = value.data()?.user;
          senderUser?.msgCount = 0;
          documentSender?.update({FirebaseRes.user: senderUser?.toJson()});
        }
      });
    }
  }
}
