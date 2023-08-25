part of 'manage_service_bloc.dart';

abstract class ManageServiceEvent {}

class FetchedCategoryDataEvent extends ManageServiceEvent {}

class CategoryItemClickEvent extends ManageServiceEvent {
  final int categoryId;

  CategoryItemClickEvent(this.categoryId);
}

class CategoryAllItemClickEvent extends ManageServiceEvent {}

class DeleteItemClickEvent extends ManageServiceEvent {
  final int serviceId;

  DeleteItemClickEvent(this.serviceId);
}
