part of 'edit_bank_bloc.dart';

abstract class EditBankEvent {}

class FetchedEditBankEvent extends EditBankEvent {}

class EditCancelChequePhotoEvent extends EditBankEvent {
  XFile? ownerPhoto;

  EditCancelChequePhotoEvent(this.ownerPhoto);
}
