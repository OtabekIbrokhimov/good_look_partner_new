part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent {}

class FetchUserProfileEvent extends EditProfileEvent {}

class SubmitEditProfileEvent extends EditProfileEvent {}

class ImageSelectClickEvent extends EditProfileEvent {}
