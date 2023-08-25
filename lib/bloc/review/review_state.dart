part of 'review_bloc.dart';

abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class FetchedReviewsState extends ReviewState {}

class NoReviewsFoundState extends ReviewState {}
