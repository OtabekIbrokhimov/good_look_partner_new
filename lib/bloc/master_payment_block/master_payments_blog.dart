import 'package:flutter_bloc/flutter_bloc.dart';

part 'master_payment_event.dart';part 'master_payment_state.dart';

class MasterPaymentsBloc extends Bloc<EditMasterEvent, EditMasterState> {
  MasterPaymentsBloc() : super(EditMasterInitial()) {
    on<FetchedMasterEvent>((event, emit) {
      emit(FetchedDataState());
    });

    initData();
  }

  void initData() async {
    add(FetchedMasterEvent());
  }

  Future<void> onTapSubmit() async {}
}
