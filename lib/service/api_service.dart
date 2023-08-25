import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cutfx_salon/model/bookings/booking.dart';
import 'package:cutfx_salon/model/cat/categories.dart' as cat;
import 'package:cutfx_salon/model/earninghistory/earning_history.dart';
import 'package:cutfx_salon/model/faq/faqs.dart';
import 'package:cutfx_salon/model/notification/notification.dart';
import 'package:cutfx_salon/model/payout/payout_history.dart';
import 'package:cutfx_salon/model/request/request_details.dart'
    as request_details;
import 'package:cutfx_salon/model/rest/get_path.dart';
import 'package:cutfx_salon/model/rest/rest_response.dart';
import 'package:cutfx_salon/model/review/salon_review.dart';
import 'package:cutfx_salon/model/service/services.dart' as services;
import 'package:cutfx_salon/model/setting/setting.dart';
import 'package:cutfx_salon/model/user/salon.dart';
import 'package:cutfx_salon/model/user/salon_user.dart';
import 'package:cutfx_salon/model/wallet/wallet_statement.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/shared_pref.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ApiService {
  Future<Salon> salonRegistration({
    required String email,
    required bool isRegistration,
    String? ownerName,
    File? ownerPhoto,
    String? salonName,
  }) async {
    var request = http.MultipartRequest(
      ConstRes.aPost,
      Uri.parse(ConstRes.salonRegistration),
    );

    SharePref sharePref = await SharePref().init();
    request.headers.addAll({ConstRes.apiKey: ConstRes.apiKeyValue});
    request.fields[ConstRes.email] = email;
    request.fields[ConstRes.salonName] = salonName ?? '';
    request.fields[ConstRes.ownerName] = ownerName ?? '';
    request.fields[ConstRes.type] = isRegistration ? '0' : '1';

    request.fields[ConstRes.deviceToken] =
        sharePref.getString(ConstRes.deviceToken) ?? 'q';
    request.fields[ConstRes.deviceType] = Platform.isAndroid ? '1' : '2';
    if (ownerPhoto != null) {
      request.files.add(
        http.MultipartFile(
          ConstRes.ownerPhoto,
          ownerPhoto.readAsBytes().asStream(),
          ownerPhoto.lengthSync(),
          filename: ownerPhoto.path.split("/").last,
        ),
      );
    }
    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    sharePref.saveString(AppRes.user, respStr);
    log('SALON REGISTRATION $respStr');

    Salon salon = Salon.fromJson(responseJson);
    ConstRes.salonId = salon.data?.id?.toInt() ?? -1;
    return Salon.fromJson(responseJson);
  }

  Future<Setting> fetchGlobalSettings() async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchGlobalSettings),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
    );
    final responseJson = jsonDecode(response.body);
    SharePref sharePref = await SharePref().init();
    sharePref.saveString(AppRes.settings, response.body);
    AppRes.currency = sharePref.getSettings()?.data?.currency ?? '';

    return Setting.fromJson(responseJson);
  }

  Future<Salon> updateSalonDetails({
    required int salonId,
    String? salonName,
    String? salonAbout,
    String? salonAddress,
    String? salonPhone,
    double? salonLat,
    double? salonLong,
    String? monFriFrom,
    String? monFriTo,
    String? satSunFrom,
    String? satSunTo,
    String? genderServed,
    String? salonCategories,
    bool? isNotification,
    bool? onVacation,
    List<String>? deleteImageIds,
    List<XFile?>? salonImages,
  }) async {
    var request = http.MultipartRequest(
      ConstRes.aPost,
      Uri.parse(ConstRes.updateSalonDetails),
    );

    SharePref sharePref = await SharePref().init();
    request.headers.addAll(
      {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
    );
    request.fields[ConstRes.salonId_] = salonId.toString();
    request.fields[ConstRes.deviceToken] =
        sharePref.getString(ConstRes.deviceToken) ?? 'q';
    request.fields[ConstRes.deviceType] = Platform.isAndroid ? '1' : '2';
    if (isNotification != null) {
      request.fields[ConstRes.isNotification] = isNotification ? '1' : '0';
    }
    if (onVacation != null) {
      request.fields[ConstRes.onVacation] = onVacation ? '1' : '0';
    }
    if (salonAbout != null) {
      request.fields[ConstRes.salonAbout] = salonAbout;
    }
    if (salonAddress != null) {
      request.fields[ConstRes.salonAddress] = salonAddress;
    }
    if (salonName != null) {
      request.fields[ConstRes.salonName] = salonName;
    }
    if (salonPhone != null) {
      request.fields[ConstRes.salonPhone] = salonPhone;
    }
    if (salonLat != null) {
      request.fields[ConstRes.salonLat] = salonLat.toString();
    }
    if (salonLong != null) {
      request.fields[ConstRes.salonLong] = salonLong.toString();
    }
    if (monFriFrom != null) {
      request.fields[ConstRes.monFriFrom] = monFriFrom;
    }
    if (monFriTo != null) {
      request.fields[ConstRes.monFriTo] = monFriTo;
    }
    if (satSunFrom != null) {
      request.fields[ConstRes.satSunFrom] = satSunFrom;
    }
    if (satSunTo != null) {
      request.fields[ConstRes.satSunTo] = satSunTo;
    }
    if (genderServed != null) {
      request.fields[ConstRes.genderServed] = genderServed;
    }
    if (salonCategories != null) {
      request.fields[ConstRes.salonCategories] = salonCategories;
    }
    if (salonImages != null && salonImages.isNotEmpty) {
      for (int i = 0; i < salonImages.length; i++) {
        File salonImageFile = File(salonImages[i]?.path ?? '');
        request.files.add(http.MultipartFile(
            ConstRes.images_,
            salonImageFile.readAsBytes().asStream(),
            salonImageFile.lengthSync(),
            filename: salonImageFile.path.split("/").last));
      }
    }
    if (deleteImageIds != null && deleteImageIds.isNotEmpty) {
      for (int i = 0; i < deleteImageIds.length; i++) {
        request.fields['deleteImageIds[$i]'] = deleteImageIds[i];
      }
    }
    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    sharePref.saveString(AppRes.user, respStr);
    return Salon.fromJson(responseJson);
  }

  Future<cat.Categories> fetchSalonCategories() async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchSalonCategories),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
    );
    final responseJson = jsonDecode(response.body);

    return cat.Categories.fromJson(responseJson);
  }

  Future<RestResponse> updateSalonBankAccount({
    required int salonId,
    String? bankTitle,
    String? accountNumber,
    String? holder,
    String? swiftCode,
    File? chequePhoto,
  }) async {
    var request = http.MultipartRequest(
      ConstRes.aPost,
      Uri.parse(ConstRes.updateSalonBankAccount),
    );
    request.headers.addAll({ConstRes.apiKey: ConstRes.apiKeyValue});
    request.fields[ConstRes.bankTitle] = bankTitle ?? '';
    request.fields[ConstRes.accountNumber] = accountNumber ?? '';
    request.fields[ConstRes.holder] = holder ?? '';
    request.fields[ConstRes.swiftCode] = swiftCode ?? '';
    request.fields[ConstRes.salonId_] = salonId.toString();
    if (chequePhoto != null) {
      request.files.add(http.MultipartFile(ConstRes.chequePhoto,
          chequePhoto.readAsBytes().asStream(), chequePhoto.lengthSync(),
          filename: chequePhoto.path.split("/").last));
    }
    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    await updateSalonDetails(salonId: ConstRes.salonId);
    return RestResponse.fromJson(responseJson);
  }

  Future<Salon> deleteBookingSlots({
    required int slotId,
  }) async {
    final response =
        await http.post(Uri.parse(ConstRes.deleteBookingSlots), headers: {
      ConstRes.apiKey: ConstRes.apiKeyValue,
    }, body: {
      ConstRes.slotId: slotId.toString(),
    });
    Salon salon = await fetchMySalonDetails();
    return salon;
  }

  Future<Salon> fetchMySalonDetails() async {
    SharePref sharePref = await SharePref().init();
    final response = await http.post(
      Uri.parse(ConstRes.fetchMySalonDetails),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
        // ConstRes.salonId_: '2',
      },
    );
    final responseJson = jsonDecode(response.body);
    Salon salon = Salon.fromJson(responseJson);
    if (salon.data?.status == 1) {
      sharePref.saveString(AppRes.user, response.body);
    }
    return salon;
  }

  Future<services.Services> fetchServicesByCatOfSalon({
    required String categoryId,
  }) async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchServicesByCatOfSalon),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
        ConstRes.categoryId: categoryId
      },
    );
    final responseJson = jsonDecode(response.body);

    return services.Services.fromJson(responseJson);
  }

  Future<services.Services> fetchAllServicesOfSalon() async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchAllServicesOfSalon),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    log("SERVICES FETCH ALL: $responseJson");

    return services.Services.fromJson(responseJson);
  }

  Future<RestResponse> addServiceToSalon({
    required String catId,
    required String title,
    required String price,
    required String? discount,
    required String gender,
    required String about,
    required String serviceTime,
    required List<XFile>? salonImages,
  }) async {
    var request = http.MultipartRequest(
      ConstRes.aPost,
      Uri.parse(ConstRes.addServiceToSalon),
    );

    request.headers.addAll(
      {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
    );
    request.fields[ConstRes.salonId_] = ConstRes.salonId.toString();
    request.fields[ConstRes.categoryId] = catId;
    request.fields[ConstRes.title] = title;
    request.fields[ConstRes.price] = price;
    if (discount != null) {
      request.fields[ConstRes.discount] = discount;
    }
    request.fields[ConstRes.gender] = gender;
    request.fields[ConstRes.about] = about;
    request.fields[ConstRes.serviceTime] = serviceTime;

    if (salonImages != null && salonImages.isNotEmpty) {
      for (int i = 0; i < salonImages.length; i++) {
        File salonImageFile = File(salonImages[i].path);
        request.files.add(http.MultipartFile(
            ConstRes.images_,
            salonImageFile.readAsBytes().asStream(),
            salonImageFile.lengthSync(),
            filename: salonImageFile.path.split("/").last));
      }
    }
    var response = await request.send();
    log("ADD SERVICE SALON ${response.statusCode} ");
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    log("ADD SERVICE SALON $responseJson");
    return RestResponse.fromJson(responseJson);
  }

  Future<RestResponse> editService({
    required String serviceId,
    String? catId,
    String? title,
    String? price,
    String? discount,
    String? gender,
    String? about,
    String? serviceTime,
    List<String>? deleteImageIds,
    List<XFile>? salonImages,
  }) async {
    var request = http.MultipartRequest(
      ConstRes.aPost,
      Uri.parse(ConstRes.editService),
    );

    request.headers.addAll(
      {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
    );
    request.fields[ConstRes.salonId_] = ConstRes.salonId.toString();
    if (catId != null) {
      request.fields[ConstRes.categoryId] = catId;
    }
    if (catId != null) {
      request.fields[ConstRes.serviceId] = serviceId;
    }
    if (title != null) {
      request.fields[ConstRes.title] = title;
    }
    if (price != null) {
      request.fields[ConstRes.price] = price;
    }
    if (discount != null) {
      request.fields[ConstRes.discount] = discount;
    }
    if (gender != null) {
      request.fields[ConstRes.gender] = gender;
    }
    if (about != null) {
      request.fields[ConstRes.about] = about;
    }
    if (serviceTime != null) {
      request.fields[ConstRes.serviceTime] = serviceTime;
    }

    if (salonImages != null && salonImages.isNotEmpty) {
      for (int i = 0; i < salonImages.length; i++) {
        File salonImageFile = File(salonImages[i].path);
        request.files.add(http.MultipartFile(
            ConstRes.images_,
            salonImageFile.readAsBytes().asStream(),
            salonImageFile.lengthSync(),
            filename: salonImageFile.path.split("/").last));
      }
    }
    if (deleteImageIds != null && deleteImageIds.isNotEmpty) {
      for (int i = 0; i < deleteImageIds.length; i++) {
        request.fields['deleteImageIds[$i]'] = deleteImageIds[i];
      }
    }
    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    return RestResponse.fromJson(responseJson);
  }

  Future<RestResponse> changeServiceStatus({
    required String serviceId,
    required String status,
  }) async {
    final response = await http.post(
      Uri.parse(ConstRes.changeServiceStatus),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
        ConstRes.serviceId: serviceId,
        ConstRes.status: status
      },
    );
    final responseJson = jsonDecode(response.body);
    return RestResponse.fromJson(responseJson);
  }

  Future<RestResponse> deleteService({
    required int serviceId,
  }) async {
    final response = await http.post(
      Uri.parse(ConstRes.deleteService),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
        ConstRes.serviceId: serviceId.toString()
      },
    );
    final responseJson = jsonDecode(response.body);
    return RestResponse.fromJson(responseJson);
  }

  Future<RestResponse> deleteMySalonAccount() async {
    final response = await http.post(
      Uri.parse(ConstRes.deleteMySalonAccount),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    return RestResponse.fromJson(responseJson);
  }

  Future<RestResponse> addSalonAward({
    required String title,
    required String awardBy,
    required String description,
  }) async {
    final response = await http.post(
      Uri.parse(ConstRes.addSalonAward),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
        ConstRes.title: title,
        ConstRes.awardBy: awardBy,
        ConstRes.description: description
      },
    );
    final responseJson = jsonDecode(response.body);
    await fetchMySalonDetails();
    return RestResponse.fromJson(responseJson);
  }

  Future<RestResponse> editSalonAward({
    required String awardId,
    required String title,
    required String awardBy,
    required String description,
  }) async {
    final response = await http.post(
      Uri.parse(ConstRes.editSalonAward),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
        ConstRes.awardId: awardId,
        ConstRes.title: title,
        ConstRes.awardBy: awardBy,
        ConstRes.description: description
      },
    );
    final responseJson = jsonDecode(response.body);
    await fetchMySalonDetails();
    return RestResponse.fromJson(responseJson);
  }

  Future<RestResponse> deleteSalonAward({
    required int awardId,
  }) async {
    final response = await http.post(
      Uri.parse(ConstRes.deleteSalonAward),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
        ConstRes.awardId: awardId.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    await fetchMySalonDetails();
    return RestResponse.fromJson(responseJson);
  }

  Future<RestResponse> addSalonGalleryImage({
    required XFile image,
    String? description,
  }) async {
    var request = http.MultipartRequest(
      ConstRes.aPost,
      Uri.parse(ConstRes.addSalonGalleryImage),
    );

    request.headers.addAll(
      {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
    );
    File imageFile = File(image.path);
    request.files.add(
      http.MultipartFile(ConstRes.image, imageFile.readAsBytes().asStream(),
          imageFile.lengthSync(),
          filename: imageFile.path.split("/").last),
    );
    request.fields[ConstRes.salonId_] = ConstRes.salonId.toString();
    if (description != null && description.isNotEmpty) {
      request.fields[ConstRes.description] = description;
    }
    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    await fetchMySalonDetails();
    return RestResponse.fromJson(responseJson);
  }

  Future<RestResponse> deleteSalonGalleryImage({
    required int galleryId,
  }) async {
    final response = await http.post(
      Uri.parse(ConstRes.deleteSalonGalleryImage),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
        ConstRes.galleryId: galleryId.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    await fetchMySalonDetails();
    return RestResponse.fromJson(responseJson);
  }

  Future<SalonReview> fetchMySalonReviews({
    required int start,
  }) async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchMySalonReviews),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
        ConstRes.start: start.toString(),
        ConstRes.count: '10',
      },
    );
    final responseJson = jsonDecode(response.body);
    await fetchMySalonDetails();
    return SalonReview.fromJson(responseJson);
  }

  Future<Booking> fetchBookingsByDate({
    required String date,
  }) async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchBookingsByDate),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
        ConstRes.date: date,
      },
    );
    final responseJson = jsonDecode(response.body);
    return Booking.fromJson(responseJson);
  }

  Future<Booking> fetchSalonBookingHistory({
    required int start,
  }) async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchSalonBookingHistory),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
        ConstRes.start: start.toString(),
        ConstRes.count: ConstRes.count_.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    return Booking.fromJson(responseJson);
  }

  Future<Booking> fetchSalonBookingRequests() async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchSalonBookingRequests),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    return Booking.fromJson(responseJson);
  }

  Future<Faqs> fetchFaqCats() async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchFaqCats),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
    );
    final responseJson = jsonDecode(response.body);
    return Faqs.fromJson(responseJson);
  }

  Future<request_details.RequestDetails> fetchBookingDetails(
      String bookingId) async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchBookingDetails),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
        ConstRes.bookingId: bookingId.toString()
      },
    );
    final responseJson = jsonDecode(response.body);
    return request_details.RequestDetails.fromJson(responseJson);
  }

  Future<PayoutHistory> fetchSalonPayoutHistory() async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchSalonPayoutHistory),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    return PayoutHistory.fromJson(responseJson);
  }

  Future<EarningHistory> fetchSalonEarningHistory(int month, int year) async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchSalonEarningHistory),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
        ConstRes.month: month.toString(),
        ConstRes.year: year.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    return EarningHistory.fromJson(responseJson);
  }

  Future<WalletStatement> fetchSalonWalletStatement(int start) async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchSalonWalletStatement),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
        ConstRes.start: start.toString(),
        ConstRes.count: ConstRes.count_.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    return WalletStatement.fromJson(responseJson);
  }

  Future<RestResponse> submitSalonWithdrawRequest() async {
    final response = await http.post(
      Uri.parse(ConstRes.submitSalonWithdrawRequest),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    await fetchMySalonDetails();
    return RestResponse.fromJson(responseJson);
  }

  Future<MyNotification> fetchSalonNotifications(int start) async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchSalonNotifications),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
        ConstRes.start: start.toString(),
        ConstRes.count: ConstRes.count_.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    await fetchMySalonDetails();
    return MyNotification.fromJson(responseJson);
  }

  Future<RestResponse> acceptBooking(String bookingId) async {
    final response = await http.post(
      Uri.parse(ConstRes.acceptBooking),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
        ConstRes.bookingId: bookingId,
      },
    );
    final responseJson = jsonDecode(response.body);
    await fetchMySalonDetails();
    return RestResponse.fromJson(responseJson);
  }

  Future<RestResponse> rejectBooking(String bookingId) async {
    final response = await http.post(
      Uri.parse(ConstRes.rejectBooking),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
        ConstRes.bookingId: bookingId,
      },
    );
    final responseJson = jsonDecode(response.body);
    await fetchMySalonDetails();
    return RestResponse.fromJson(responseJson);
  }

  Future<RestResponse> completeBooking(
      String bookingId, String completionOtp) async {
    final response = await http.post(
      Uri.parse(ConstRes.completeBooking),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
        ConstRes.bookingId: bookingId,
        ConstRes.completionOtp: completionOtp,
      },
    );
    final responseJson = jsonDecode(response.body);
    await fetchMySalonDetails();
    return RestResponse.fromJson(responseJson);
  }

  Future<Salon?> addBookingSlots(
      String time, String weekDay, String slotLimit) async {
    SharePref sharePref = await SharePref().init();

    final response = await http.post(
      Uri.parse(ConstRes.addBookingSlots),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: ConstRes.salonId.toString(),
        ConstRes.time: time,
        ConstRes.weekday: weekDay,
        ConstRes.bookingLimit: slotLimit,
      },
    );
    final responseJson = jsonDecode(response.body);
    Salon? salon = Salon.fromJson(responseJson);
    if (salon.status! && salon.data?.status == 1) {
      sharePref.saveString(AppRes.user, response.body);
    } else {
      salon = sharePref.getSalon();
    }
    return salon;
  }

  Future<SalonUser> fetchMyUserDetails(int userId) async {
    var request = http.MultipartRequest(
      ConstRes.aPost,
      Uri.parse(ConstRes.fetchUserDetails),
    );

    request.headers.addAll({ConstRes.apiKey: ConstRes.apiKeyValue});
    request.fields[ConstRes.userId] = userId.toString();

    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    return SalonUser.fromJson(responseJson);
  }

  Future<GetPath> uploadFileGivePath(File? image) async {
    var request = http.MultipartRequest(
      ConstRes.aPost,
      Uri.parse(ConstRes.uploadFileGivePath),
    );
    request.headers.addAll({
      ConstRes.apiKey: ConstRes.apiKeyValue,
    });
    if (image != null) {
      request.files.add(
        http.MultipartFile(
          ConstRes.file,
          image.readAsBytes().asStream(),
          image.lengthSync(),
          filename: image.path.split("/").last,
        ),
      );
    }
    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    return GetPath.fromJson(responseJson);
  }

  Future pushNotification(
      {required String authorization,
      required String title,
      required String body,
      required String token,
      String? senderIdentity,
      String? appointmentId,
      required String notificationType}) async {
    Map<String, dynamic> map = {};
    if (senderIdentity != null) {
      map[ConstRes.senderId] = senderIdentity;
    }
    if (appointmentId != null) {
      map[ConstRes.bookingId] = appointmentId;
    }
    map[ConstRes.notificationType] = notificationType;
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: {
        'Authorization': 'key=$authorization',
        'content-type': 'application/json'
      },
      body: json.encode(
        {
          'data': map,
          'notification': {
            'title': title,
            'body': body,
            "sound": "default",
            "badge": "0",
          },
          'to': '/token/$token',
        },
      ),
    );
  }
}
