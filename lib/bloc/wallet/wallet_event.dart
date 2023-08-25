part of 'wallet_bloc.dart';

abstract class WalletEvent {}

class FetchWalletStatementsEvent extends WalletEvent {}

class FetchSalonDataEvent extends WalletEvent {}
