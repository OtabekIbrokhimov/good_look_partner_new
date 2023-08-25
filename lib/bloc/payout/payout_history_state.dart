part of 'payout_history_bloc.dart';

abstract class PayoutHistoryState {}

class PayoutHistoryInitial extends PayoutHistoryState {}

class PayoutHistoryDataFoundState extends PayoutHistoryState {
  final PayoutHistory payoutHistory;

  PayoutHistoryDataFoundState(this.payoutHistory);
}
