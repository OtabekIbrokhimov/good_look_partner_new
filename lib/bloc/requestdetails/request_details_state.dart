part of 'request_details_bloc.dart';

abstract class RequestDetailsState {}

class RequestDetailsInitial extends RequestDetailsState {}

class RequestDetailFoundState extends RequestDetailsState {
  final RequestDetails requestDetails;

  RequestDetailFoundState(this.requestDetails);
}
