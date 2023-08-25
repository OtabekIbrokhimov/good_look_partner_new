part of 'wallet_bloc.dart';

abstract class WalletState {}

class WalletInitial extends WalletState {}

class WalletStatementDataFoundState extends WalletState {}

class SalonDataFoundState extends WalletState {}
