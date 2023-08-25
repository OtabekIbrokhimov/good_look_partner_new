import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

abstract class SignUpEvent {}

class SignUpNextClickEvent extends SignUpEvent {
  int selectedPosition;

  SignUpNextClickEvent(this.selectedPosition);
}

class SignUpOwnerPhotoEvent extends SignUpEvent {
  XFile? ownerPhoto;

  SignUpOwnerPhotoEvent(this.ownerPhoto);
}

class SignUpLocationClickEvent extends SignUpEvent {
  LatLng? latLng;

  SignUpLocationClickEvent(this.latLng);
}

class SignUpTimeClickEvent extends SignUpEvent {
  int? timeTypeClick;

  SignUpTimeClickEvent(this.timeTypeClick);
}

class SignUpUploadImageClickEvent extends SignUpEvent {
  XFile? selectedImage;

  SignUpUploadImageClickEvent(this.selectedImage);
}
