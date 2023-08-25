part of 'chat_bloc.dart';

abstract class ChatEvent {}

class FetchChatArgumentsEvent extends ChatEvent {}

class UpdateChatEvent extends ChatEvent {}
