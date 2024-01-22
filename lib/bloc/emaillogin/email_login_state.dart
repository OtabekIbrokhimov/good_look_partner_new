part of 'email_login_bloc.dart';

abstract class EmailLoginState {}

class EmailLoginInitial extends EmailLoginState {}

class EmailLoginLoadingState extends EmailLoginState {}

class UpdateEmailLoginState extends EmailLoginState {}

class UpdateSmsState extends EmailLoginState {}

class CheckSmsState extends EmailLoginState {}

class EmailLoginResultState extends EmailLoginState {}
