part of 'manage_service_bloc.dart';

abstract class ManageServiceState {}

class ManageServiceInitial extends ManageServiceState {}

class FetchCategoriesState extends ManageServiceState {}

class LoadingServiceState extends ManageServiceState {}

class ServiceDataFoundState extends ManageServiceState {
  final List<ServiceData>? services;

  ServiceDataFoundState(this.services);
}

class ServiceDataNotFoundState extends ManageServiceState {}
