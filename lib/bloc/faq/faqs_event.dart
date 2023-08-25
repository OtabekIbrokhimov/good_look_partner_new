part of 'faqs_bloc.dart';

abstract class FaqsEvent {}

class FetchFaqsCatEvent extends FaqsEvent {}

class SelectFaqCategoryEvent extends FaqsEvent {
  final int catId;

  SelectFaqCategoryEvent(this.catId);
}
