part of 'edit_availability_bloc.dart';

abstract class EditAvailabilityState {}

class EditAvailabilityInitial extends EditAvailabilityState {}

class FetchedEditAvailabilityState extends EditAvailabilityState {}

class EditAvailabilityTimeState extends EditAvailabilityState {
  int? timeTypeClick;

  EditAvailabilityTimeState(this.timeTypeClick);
}
