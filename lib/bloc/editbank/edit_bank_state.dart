part of 'edit_bank_bloc.dart';

abstract class EditBankState {}

class EditBankInitial extends EditBankState {}

class EditCancelChequePhotoState extends EditBankState {}

class FetchedDataState extends EditBankState {}
