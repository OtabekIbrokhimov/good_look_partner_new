class ConstRes {
  /// api url

  static const String baseUrl = 'http://api.goodlook.uz/v1/';
  static const String itemBaseUrl = 'http://lk.goodlook.uz/public/storage/';
  static const String salonRegistration = '${baseUrl}salonRegistration';
  static const String updateSalonDetails = '${baseUrl}updateSalonDetails';
  static const String addServiceToSalon = '${baseUrl}addServiceToSalon';
  static const String fetchSalonCategories = '${baseUrl}fetchSalonCategories';
  static const String fetchServicesByCatOfSalon =
      '${baseUrl}fetchServicesByCatOfSalon';
  static const String fetchAllServicesOfSalon =
      '${baseUrl}fetchAllServicesOfSalon';
  static const String updateSalonBankAccount =
      '${baseUrl}updateSalonBankAccount';
  static const String deleteBookingSlots = '${baseUrl}deleteBookingSlots';
  static const String fetchMySalonDetails = '${baseUrl}fetchMySalonDetails';
  static const String changeServiceStatus = '${baseUrl}changeServiceStatus';
  static const String editService = '${baseUrl}editService';
  static const String deleteService = '${baseUrl}deleteService';
  static const String deleteMySalonAccount = '${baseUrl}deleteMySalonAccount';
  static const String addSalonAward = '${baseUrl}addSalonAward';
  static const String editSalonAward = '${baseUrl}editSalonAward';
  static const String deleteSalonAward = '${baseUrl}deleteSalonAward';
  static const String addSalonGalleryImage = '${baseUrl}addSalonGalleryImage';
  static const String deleteSalonGalleryImage =
      '${baseUrl}deleteSalonGalleryImage';
  static const String fetchMySalonReviews = '${baseUrl}fetchMySalonReviews';
  static const String fetchBookingsByDate = '${baseUrl}fetchBookingsByDate';
  static const String fetchSalonBookingHistory =
      '${baseUrl}fetchSalonBookingHistory';
  static const String fetchSalonBookingRequests =
      '${baseUrl}fetchSalonBookingRequests';
  static const String fetchFaqCats = '${baseUrl}fetchFaqCats';
  static const String fetchBookingDetails = '${baseUrl}fetchBookingDetails';
  static const String fetchSalonPayoutHistory =
      '${baseUrl}fetchSalonPayoutHistory';
  static const String fetchSalonEarningHistory =
      '${baseUrl}fetchSalonEarningHistory';
  static const String fetchSalonWalletStatement =
      '${baseUrl}fetchSalonWalletStatement';
  static const String submitSalonWithdrawRequest =
      '${baseUrl}SubmitSalonWithdrawRequest';
  static const String fetchSalonNotifications =
      '${baseUrl}fetchSalonNotifications';
  static const String acceptBooking = '${baseUrl}acceptBooking';
  static const String rejectBooking = '${baseUrl}rejectBooking';
  static const String completeBooking = '${baseUrl}completeBooking';
  static const String addBookingSlots = '${baseUrl}addBookingSlots';
  static const String fetchUserDetails = '${baseUrl}user/fetchUserDetails';
  static const String uploadFileGivePath = '${baseUrl}uploadFileGivePath';
  static const String fetchGlobalSettings = '${baseUrl}fetchGlobalSettings';

  static const String sentForOtp = '${baseUrl}send-otp';
  static const String verifyOtp = '${baseUrl}verify-otp';

  static String termsOfUseUrl = baseUrl.replaceAll('api/', 'termsOfUse');
  static String privacyPolicyUrl = baseUrl.replaceAll('api/', 'privacypolicy');

  ///Api Key
  static const String apiKey = 'apikey';
  static const String apiKeyValue = '123';

  /// Api body keyword
  static const String email = 'email';
  static const String slotId = 'slot_id';
  static const String salonName = 'salon_name';
  static const String ownerPhoto = 'owner_photo';
  static const String ownerName = 'owner_name';
  static const String type = 'type';
  static const String deviceToken = 'device_token';
  static const String deviceType = 'device_type';
  static const String salonId_ = 'salon_id';
  static const String serviceId = 'service_id';
  static const String bookingId = 'booking_id';
  static const String salonAbout = 'salon_about';
  static const String salonAddress = 'salon_address';
  static const String salonPhone = 'salon_phone';
  static const String salonLat = 'salon_lat';
  static const String salonLong = 'salon_long';
  static const String monFriFrom = 'mon_fri_from';
  static const String monFriTo = 'mon_fri_to';
  static const String satSunFrom = 'sat_sun_from';
  static const String satSunTo = 'sat_sun_to';
  static const String genderServed = 'gender_served';
  static const String salonCategories = 'salon_categories';
  static const String images_ = 'images[]';
  static const String bankTitle = 'bank_title';
  static const String accountNumber = 'account_number';
  static const String holder = 'holder';
  static const String swiftCode = 'swift_code';
  static const String chequePhoto = 'cheque_photo';
  static const String categoryId = 'category_id';
  static const String title = 'title';
  static const String price = 'price';
  static const String discount = 'discount';
  static const String gender = 'gender';
  static const String about = 'about';
  static const String serviceTime = 'service_time';
  static const String status = 'status';
  static const String awardBy = 'award_by';
  static const String description = 'description';
  static const String awardId = 'award_id';
  static const String galleryId = 'gallery_id';
  static const String image = 'image';
  static const String start = 'start';
  static const String count = 'count';
  static const String date = 'date';
  static const String month = 'month';
  static const String year = 'year';
  static const String completionOtp = 'completion_otp';
  static const String userId = 'user_id';
  static const String file = 'file';
  static const String senderId = 'sender_id';
  static const String notificationType = 'notification_type';
  static const String onVacation = 'on_vacation';
  static const String isNotification = 'is_notification';
  static const String languageCode = 'language_code';
  static const String time = 'time';
  static const String weekday = 'weekday';
  static const String bookingLimit = 'booking_limit';

  static const int count_ = 10;
  static const String aPost = 'POST';

  static const String isLogin = 'is_login';

  static int salonId = -1;

  static var authorisationKey = '-----------------------------';
}
