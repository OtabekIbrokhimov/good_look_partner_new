part of 'my_salon_bloc.dart';

abstract class MySalonState {}

class MySalonInitial extends MySalonState {}

class MySalonDataFetched extends MySalonState {
  final Salon salon;

  MySalonDataFetched(this.salon);
}
