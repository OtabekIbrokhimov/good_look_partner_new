part of 'manage_awards_bloc.dart';

abstract class ManageAwardsEvent {}

class FetchAwardsEvent extends ManageAwardsEvent {}

class DeleteAwardsEvent extends ManageAwardsEvent {
  final Awards? awards;

  DeleteAwardsEvent(this.awards);
}
