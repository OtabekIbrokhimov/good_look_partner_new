part of 'edit_salon_detail_screen_bloc.dart';

abstract class EditSalonDetailState {}

class EditSalonDetailScreenInitial extends EditSalonDetailState {}

class EditSalonFetchedCatsState extends EditSalonDetailState {
  final List<cat.CategoryData>? categories;

  EditSalonFetchedCatsState(this.categories);
}

class EditSalonAddImageState extends EditSalonDetailState {}
