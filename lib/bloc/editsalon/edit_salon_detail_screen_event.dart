part of 'edit_salon_detail_screen_bloc.dart';

abstract class EditSalonDetailEvent {}

class EditSalonFetchedCatsEvent extends EditSalonDetailEvent {
  final List<cat.CategoryData>? categories;

  EditSalonFetchedCatsEvent(this.categories);
}

class AddImageEvent extends EditSalonDetailEvent {}

class FetchLocationEvent extends EditSalonDetailEvent {}
