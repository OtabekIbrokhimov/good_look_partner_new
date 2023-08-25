import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

abstract class SignUpState {}

class SignUpInitialState extends SignUpState {}

class SignUpPageChangeState extends SignUpState {
  int selectedPosition;

  SignUpPageChangeState(this.selectedPosition);
}

class SignUpOwnerPhotoState extends SignUpState {
  XFile? ownerPhoto;

  SignUpOwnerPhotoState(this.ownerPhoto);
}

class SignUpLocationFetchState extends SignUpState {
  LatLng? latLng;

  SignUpLocationFetchState(this.latLng);
}

class SignUpTimeState extends SignUpState {
  int? timeTypeClick;

  SignUpTimeState(this.timeTypeClick);
}
