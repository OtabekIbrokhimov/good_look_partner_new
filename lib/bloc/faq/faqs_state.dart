part of 'faqs_bloc.dart';

abstract class FaqsState {}

class FaqsInitial extends FaqsState {}

class FaqsLoadingState extends FaqsState {}

class FaqsDataFoundState extends FaqsState {
  final Faqs faqs;

  FaqsDataFoundState(this.faqs);
}

class FaqsCatSelectedState extends FaqsState {
  final List<FaqData> faqs;

  FaqsCatSelectedState(this.faqs);
}
