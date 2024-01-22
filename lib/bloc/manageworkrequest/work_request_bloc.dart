import 'package:cutfx_salon/model/service/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'work_request_event.dart';
part 'work_request_state.dart';

class WorkRequestBloc extends Bloc<WorkRequestEvent, ManageServiceState> {
  WorkRequestBloc() : super(ManageServiceInitial()) {
    on<FetchWorkRequestEvent>((event, emit) {
      emit(FetchCategoriesState());
    });
  }
}
