part of 'edit_availability_bloc.dart';

abstract class EditAvailabilityEvent {}

class FetchedEditAvailabilityEvent extends EditAvailabilityEvent {}

class EditTimeClickEvent extends EditAvailabilityEvent {
  int? timeTypeClick;

  EditTimeClickEvent(this.timeTypeClick);
}
