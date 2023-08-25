part of 'manage_awards_bloc.dart';

abstract class ManageAwardsState {}

class ManageAwardsInitial extends ManageAwardsState {}

class LoadingAwardsState extends ManageAwardsState {}

class FetchedAwardsState extends ManageAwardsState {}
