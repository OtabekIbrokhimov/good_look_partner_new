part of 'email_login_bloc.dart';

abstract class EmailLoginEvent {}

class ContinueLoginEvent extends EmailLoginEvent {}

class UpdateEmailLoginEvent extends EmailLoginEvent {}

class UpdateSmsCodeTime extends EmailLoginEvent {}
class CheckSmsCode extends EmailLoginEvent {}
