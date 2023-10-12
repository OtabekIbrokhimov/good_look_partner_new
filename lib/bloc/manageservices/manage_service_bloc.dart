import 'package:cutfx_salon/model/cat/categories.dart' as cat;
import 'package:cutfx_salon/model/service/services.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:cutfx_salon/utils/custom/custom_bottom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

part 'manage_service_event.dart';
part 'manage_service_state.dart';

class ManageServiceBloc extends Bloc<ManageServiceEvent, ManageServiceState> {
  ManageServiceBloc() : super(ManageServiceInitial()) {
    on<FetchedCategoryDataEvent>((event, emit) {
      emit(FetchCategoriesState());
    });

    on<TakeIdEvent>((event, emit) {
      emit(TakeIdState());
    });

    on<CategoryItemClickEvent>((event, emit) async {
      emit(LoadingServiceState());
      services = await ApiService()
          .fetchServicesByCatOfSalon(categoryId: event.categoryId.toString());
      if (services?.data == null || services!.data!.isEmpty) {
        emit(ServiceDataNotFoundState());
      } else {
        emit(ServiceDataFoundState(services?.data));
      }
    });
    on<CategoryAllItemClickEvent>((event, emit) async {
      emit(LoadingServiceState());
      services = await ApiService().fetchAllServicesOfSalon();
      if (services?.data == null || services!.data!.isEmpty) {
        emit(ServiceDataNotFoundState());
      } else {
        emit(ServiceDataFoundState(services?.data));
      }
    });
    on<DeleteItemClickEvent>((event, emit) async {
      Get.bottomSheet(
        ConfirmationBottomSheet(
          title: AppLocalizations.of(Get.context!)!.deleteService,
          description: serviceData?.title ?? '',
          buttonText: AppLocalizations.of(Get.context!)!.delete,
          onButtonClick: () async {
            emit(LoadingServiceState());
            await ApiService().deleteService(serviceId: event.serviceId);
            services = await ApiService().fetchAllServicesOfSalon();
            if (services?.data == null || services!.data!.isEmpty) {
              emit(ServiceDataNotFoundState());
            } else {
              emit(ServiceDataFoundState(services?.data));
            }
          },
        ),
      );
    });
    fetchCategories();
  }

  cat.Categories? categories;
  Services? services;

  void fetchCategories() async {
    categories = await ApiService().fetchSalonCategories();
    add(FetchedCategoryDataEvent());
    add(CategoryAllItemClickEvent());
  }

  void onTapCategory(int categoryId) async {
    if (categoryId == -1) {
      add(CategoryAllItemClickEvent());
    } else {
      add(CategoryItemClickEvent(categoryId));
    }
  }

  ServiceData? serviceData;

  void deleteService(ServiceData? serviceData) {
    this.serviceData = serviceData;
    add(DeleteItemClickEvent(serviceData?.id ?? -1));
  }

  List<int> ids = [];

  void takeFirstIds(List<int> id) {
    ids = id;
    add(TakeIdEvent());
  }

  void takeIds(int id) {
    Get.log(id.toString() + "manabu");

    ids.isEmpty ? {ids.add(id), ids.add(id)} : {};
    for (int i = 0; i < ids.length; i++) {
      if (ids[i] == id) {
        ids.removeAt(i);
        Get.log(ids.toString());
      } else {
        ids.add(id);
        Get.log(ids.toString());
      }
    }
    add(TakeIdEvent());
    Get.log(ids.toString());
  }
}
