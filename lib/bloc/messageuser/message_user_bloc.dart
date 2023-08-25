import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cutfx_salon/model/chat/chat.dart';
import 'package:cutfx_salon/model/user/salon.dart';
import 'package:cutfx_salon/utils/firebase_res.dart';
import 'package:cutfx_salon/utils/shared_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'message_user_event.dart';
part 'message_user_state.dart';

class MessageUserBloc extends Bloc<MessageUserEvent, MessageUserState> {
  MessageUserBloc() : super(MessageUserInitial()) {
    getChatUsers();
    on<FetchMessageUserEvent>((event, emit) {
      emit(MessageUsersDataFoundState());
    });
  }

  List<Conversation> userList = [];
  List<Conversation> duplicateUserList = [];
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final SharePref sharePref = SharePref();
  SalonData? userData;
  String? firebaseUserIdentity;
  bool isLoading = true;
  StreamSubscription<QuerySnapshot<Conversation>>? subscription;

  void getChatUsers() async {
    await sharePref.init();
    userData = sharePref.getSalon()?.data;
    firebaseUserIdentity = '${FirebaseRes.sl}${'${userData?.email}'}';
    isLoading = true;
    subscription = db
        .collection(FirebaseRes.userChatList)
        .doc(firebaseUserIdentity)
        .collection(FirebaseRes.userList)
        .orderBy(FirebaseRes.time, descending: true)
        .where(FirebaseRes.isDeleted, isEqualTo: false)
        .withConverter(
            fromFirestore: Conversation.fromFireStore,
            toFirestore: (Conversation value, options) => value.toFireStore())
        .snapshots()
        .listen((element) {
      userList = [];
      for (int i = 0; i < element.docs.length; i++) {
        userList.add(element.docs[i].data());
      }
      duplicateUserList = userList;
      isLoading = false;
      add(FetchMessageUserEvent());
    });
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }

  void filterData(String value) {
    userList = [];
    for (Conversation conversation in duplicateUserList) {
      if ((conversation.user?.username ?? '')
          .toLowerCase()
          .contains(value.toLowerCase())) {
        userList.add(conversation);
      }
    }
    add(FetchMessageUserEvent());
  }
}
