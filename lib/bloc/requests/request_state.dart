part of 'request_bloc.dart';

abstract class RequestState {}

class RequestInitial extends RequestState {}

class FetchedRequestState extends RequestState {
  List<BookingData> requests = [];

  FetchedRequestState(this.requests);
}
