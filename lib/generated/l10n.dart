// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Cut.FX`
  String get appName {
    return Intl.message(
      'Cut.FX',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Salon`
  String get salon {
    return Intl.message(
      'Salon',
      name: 'salon',
      desc: '',
      args: [],
    );
  }

  /// `Premium Beauty Services`
  String get premiumBeautyServices {
    return Intl.message(
      'Premium Beauty Services',
      name: 'premiumBeautyServices',
      desc: '',
      args: [],
    );
  }

  /// `Register your shop with us and\nhave valuable leads`
  String get registerYourShopWithUsAndHaveValuableLeads {
    return Intl.message(
      'Register your shop with us and\nhave valuable leads',
      name: 'registerYourShopWithUsAndHaveValuableLeads',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_ {
    return Intl.message(
      'Continue',
      name: 'continue_',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get open {
    return Intl.message(
      'Open',
      name: 'open',
      desc: '',
      args: [],
    );
  }

  /// `Top Rated`
  String get topRated {
    return Intl.message(
      'Top Rated',
      name: 'topRated',
      desc: '',
      args: [],
    );
  }

  /// `Closed`
  String get closed {
    return Intl.message(
      'Closed',
      name: 'closed',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get seeAll {
    return Intl.message(
      'See all',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to Continue`
  String get signInToContinue {
    return Intl.message(
      'Sign in to Continue',
      name: 'signInToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Find and book Hair Cut, Massage, Spa,\nWaxing, Coloring services anytime.`
  String get findAndBookHairCutMassageSpaWaxingColoringServicesAnytime {
    return Intl.message(
      'Find and book Hair Cut, Massage, Spa,\nWaxing, Coloring services anytime.',
      name: 'findAndBookHairCutMassageSpaWaxingColoringServicesAnytime',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword_ {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword_',
      desc: '',
      args: [],
    );
  }

  /// `New User? Register Here`
  String get newUserRegisterHere {
    return Intl.message(
      'New User? Register Here',
      name: 'newUserRegisterHere',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Your Password?`
  String get forgotYourPassword {
    return Intl.message(
      'Forgot Your Password?',
      name: 'forgotYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address, on which we will\nsend you the link to reset the password.`
  String
      get enterYourEmailAddressOnWhichWeWillSendYouTheLinkToResetThePassword {
    return Intl.message(
      'Enter your email address, on which we will\nsend you the link to reset the password.',
      name:
          'enterYourEmailAddressOnWhichWeWillSendYouTheLinkToResetThePassword',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get registration {
    return Intl.message(
      'Registration',
      name: 'registration',
      desc: '',
      args: [],
    );
  }

  /// `Enter your details and complete\nyour registration`
  String get enterYourDetailsAndCompleteYourRegistration {
    return Intl.message(
      'Enter your details and complete\nyour registration',
      name: 'enterYourDetailsAndCompleteYourRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `1`
  String get one {
    return Intl.message(
      '1',
      name: 'one',
      desc: '',
      args: [],
    );
  }

  /// `Purchase`
  String get purchase {
    return Intl.message(
      'Purchase',
      name: 'purchase',
      desc: '',
      args: [],
    );
  }

  /// `Deposit`
  String get deposit {
    return Intl.message(
      'Deposit',
      name: 'deposit',
      desc: '',
      args: [],
    );
  }

  /// `Refund`
  String get refund {
    return Intl.message(
      'Refund',
      name: 'refund',
      desc: '',
      args: [],
    );
  }

  /// `OrderRefund`
  String get orderRefund {
    return Intl.message(
      'OrderRefund',
      name: 'orderRefund',
      desc: '',
      args: [],
    );
  }

  /// `PayoutReject`
  String get payoutReject {
    return Intl.message(
      'PayoutReject',
      name: 'payoutReject',
      desc: '',
      args: [],
    );
  }

  /// `2`
  String get two {
    return Intl.message(
      '2',
      name: 'two',
      desc: '',
      args: [],
    );
  }

  /// `3`
  String get three {
    return Intl.message(
      '3',
      name: 'three',
      desc: '',
      args: [],
    );
  }

  /// `4`
  String get four {
    return Intl.message(
      '4',
      name: 'four',
      desc: '',
      args: [],
    );
  }

  /// `5`
  String get five {
    return Intl.message(
      '5',
      name: 'five',
      desc: '',
      args: [],
    );
  }

  /// `6`
  String get six {
    return Intl.message(
      '6',
      name: 'six',
      desc: '',
      args: [],
    );
  }

  /// `Salon Owner’s Name`
  String get salonOwnerName {
    return Intl.message(
      'Salon Owner’s Name',
      name: 'salonOwnerName',
      desc: '',
      args: [],
    );
  }

  /// `Salon Name`
  String get salonName {
    return Intl.message(
      'Salon Name',
      name: 'salonName',
      desc: '',
      args: [],
    );
  }

  /// `Owner photo`
  String get ownerPhoto {
    return Intl.message(
      'Owner photo',
      name: 'ownerPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Your Face should be visible\ncompletely.\nImage with Specs & Headphones\nwill not be approved.`
  String
      get yourFaceShouldBeVisibleCompletelyImageWithSpecsHeadphonesWillNotBeApproved {
    return Intl.message(
      'Your Face should be visible\ncompletely.\nImage with Specs & Headphones\nwill not be approved.',
      name:
          'yourFaceShouldBeVisibleCompletelyImageWithSpecsHeadphonesWillNotBeApproved',
      desc: '',
      args: [],
    );
  }

  /// `About Salon`
  String get aboutSalon {
    return Intl.message(
      'About Salon',
      name: 'aboutSalon',
      desc: '',
      args: [],
    );
  }

  /// `Salon Address`
  String get salonAddress {
    return Intl.message(
      'Salon Address',
      name: 'salonAddress',
      desc: '',
      args: [],
    );
  }

  /// `Salon Phone`
  String get salonPhone {
    return Intl.message(
      'Salon Phone',
      name: 'salonPhone',
      desc: '',
      args: [],
    );
  }

  /// `Salon Location`
  String get salonLocation {
    return Intl.message(
      'Salon Location',
      name: 'salonLocation',
      desc: '',
      args: [],
    );
  }

  /// `Click To Fetch Location`
  String get clickToFetchLocation {
    return Intl.message(
      'Click To Fetch Location',
      name: 'clickToFetchLocation',
      desc: '',
      args: [],
    );
  }

  /// `Set Availability of your salon`
  String get setAvailabilityOfYourSalon {
    return Intl.message(
      'Set Availability of your salon',
      name: 'setAvailabilityOfYourSalon',
      desc: '',
      args: [],
    );
  }

  /// `Monday - Friday`
  String get mondayFriday {
    return Intl.message(
      'Monday - Friday',
      name: 'mondayFriday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday & Sunday`
  String get saturdaySunday {
    return Intl.message(
      'Saturday & Sunday',
      name: 'saturdaySunday',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Categories You Serve`
  String get categoriesYouServe {
    return Intl.message(
      'Categories You Serve',
      name: 'categoriesYouServe',
      desc: '',
      args: [],
    );
  }

  /// `Genders You Serve`
  String get gendersYouServe {
    return Intl.message(
      'Genders You Serve',
      name: 'gendersYouServe',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Unisex`
  String get unisex {
    return Intl.message(
      'Unisex',
      name: 'unisex',
      desc: '',
      args: [],
    );
  }

  /// `Upload minimum 3 images of your salon`
  String get uploadMinimum3ImagesOfYourSalon {
    return Intl.message(
      'Upload minimum 3 images of your salon',
      name: 'uploadMinimum3ImagesOfYourSalon',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Bank Details`
  String get enterYourBankDetails {
    return Intl.message(
      'Enter Your Bank Details',
      name: 'enterYourBankDetails',
      desc: '',
      args: [],
    );
  }

  /// `Bank Name`
  String get bankName {
    return Intl.message(
      'Bank Name',
      name: 'bankName',
      desc: '',
      args: [],
    );
  }

  /// `Account Number`
  String get accountNumber {
    return Intl.message(
      'Account Number',
      name: 'accountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Re-Enter Account Number`
  String get reEnterAccountNumber {
    return Intl.message(
      'Re-Enter Account Number',
      name: 'reEnterAccountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Holders Name`
  String get holdersName {
    return Intl.message(
      'Holders Name',
      name: 'holdersName',
      desc: '',
      args: [],
    );
  }

  /// `Swift Code`
  String get swiftCode {
    return Intl.message(
      'Swift Code',
      name: 'swiftCode',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled Cheque Photo`
  String get cancelledChequePhoto {
    return Intl.message(
      'Cancelled Cheque Photo',
      name: 'cancelledChequePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Photo should be clear`
  String get photoShouldBeClear {
    return Intl.message(
      'Photo should be clear',
      name: 'photoShouldBeClear',
      desc: '',
      args: [],
    );
  }

  /// `Submission Successful`
  String get submissionSuccessful {
    return Intl.message(
      'Submission Successful',
      name: 'submissionSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Request ID`
  String get requestID {
    return Intl.message(
      'Request ID',
      name: 'requestID',
      desc: '',
      args: [],
    );
  }

  /// `All of the details you have submitted has been received by us. we will check and update you on this once we have an update for you.\n\nIt will take around 3 to 4 business days to check and verify your profile.\n\nWrite us on below details if you have any questions and queries.`
  String get salonOwnerNotice {
    return Intl.message(
      'All of the details you have submitted has been received by us. we will check and update you on this once we have an update for you.\n\nIt will take around 3 to 4 business days to check and verify your profile.\n\nWrite us on below details if you have any questions and queries.',
      name: 'salonOwnerNotice',
      desc: '',
      args: [],
    );
  }

  /// `Bookings`
  String get bookings {
    return Intl.message(
      'Bookings',
      name: 'bookings',
      desc: '',
      args: [],
    );
  }

  /// `Requests`
  String get requests {
    return Intl.message(
      'Requests',
      name: 'requests',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `My Salon`
  String get mySalon {
    return Intl.message(
      'My Salon',
      name: 'mySalon',
      desc: '',
      args: [],
    );
  }

  /// `Appointments`
  String get appointments {
    return Intl.message(
      'Appointments',
      name: 'appointments',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message(
      'Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `-`
  String get dash {
    return Intl.message(
      '-',
      name: 'dash',
      desc: '',
      args: [],
    );
  }

  /// `Call Now`
  String get callNow {
    return Intl.message(
      'Call Now',
      name: 'callNow',
      desc: '',
      args: [],
    );
  }

  /// `Booking Requests`
  String get bookingRequests {
    return Intl.message(
      'Booking Requests',
      name: 'bookingRequests',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get messages {
    return Intl.message(
      'Messages',
      name: 'messages',
      desc: '',
      args: [],
    );
  }

  /// `For questions and queries`
  String get forQuestionsAndQueries {
    return Intl.message(
      'For questions and queries',
      name: 'forQuestionsAndQueries',
      desc: '',
      args: [],
    );
  }

  /// `Availability`
  String get availability {
    return Intl.message(
      'Availability',
      name: 'availability',
      desc: '',
      args: [],
    );
  }

  /// `Navigate`
  String get navigate {
    return Intl.message(
      'Navigate',
      name: 'navigate',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get subTotal {
    return Intl.message(
      'Subtotal',
      name: 'subTotal',
      desc: '',
      args: [],
    );
  }

  /// `Place Booking`
  String get placeBooking {
    return Intl.message(
      'Place Booking',
      name: 'placeBooking',
      desc: '',
      args: [],
    );
  }

  /// `Ratings`
  String get ratings {
    return Intl.message(
      'Ratings',
      name: 'ratings',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `Awards`
  String get awards {
    return Intl.message(
      'Awards',
      name: 'awards',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message(
      'Contact Us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Booking Details`
  String get bookingDetails {
    return Intl.message(
      'Booking Details',
      name: 'bookingDetails',
      desc: '',
      args: [],
    );
  }

  /// `Coupon Discount`
  String get couponDiscount {
    return Intl.message(
      'Coupon Discount',
      name: 'couponDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get totalAmount {
    return Intl.message(
      'Total Amount',
      name: 'totalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Mark Completed`
  String get markCompleted {
    return Intl.message(
      'Mark Completed',
      name: 'markCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Decline`
  String get decline {
    return Intl.message(
      'Decline',
      name: 'decline',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get duration {
    return Intl.message(
      'Duration',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Salon Settings`
  String get salonSettings {
    return Intl.message(
      'Salon Settings',
      name: 'salonSettings',
      desc: '',
      args: [],
    );
  }

  /// `Push Notification`
  String get pushNotification {
    return Intl.message(
      'Push Notification',
      name: 'pushNotification',
      desc: '',
      args: [],
    );
  }

  /// `Keep it On, if you want to receive notifications`
  String get keepItOnIfYouWantToReceiveNotifications {
    return Intl.message(
      'Keep it On, if you want to receive notifications',
      name: 'keepItOnIfYouWantToReceiveNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Vacation Mode`
  String get vacationMode {
    return Intl.message(
      'Vacation Mode',
      name: 'vacationMode',
      desc: '',
      args: [],
    );
  }

  /// `Keeping it off, your salon and services will not be shown to the customer until turned on`
  String
      get keepingItOffYourSalonAndServicesWillNotBeShownToTheCustomerUntilTurnedOn {
    return Intl.message(
      'Keeping it off, your salon and services will not be shown to the customer until turned on',
      name:
          'keepingItOffYourSalonAndServicesWillNotBeShownToTheCustomerUntilTurnedOn',
      desc: '',
      args: [],
    );
  }

  /// `Edit Salon Details`
  String get editSalonDetails {
    return Intl.message(
      'Edit Salon Details',
      name: 'editSalonDetails',
      desc: '',
      args: [],
    );
  }

  /// `Edit Bank Details`
  String get editBankDetails {
    return Intl.message(
      'Edit Bank Details',
      name: 'editBankDetails',
      desc: '',
      args: [],
    );
  }

  /// `Edit Availability`
  String get editAvailability {
    return Intl.message(
      'Edit Availability',
      name: 'editAvailability',
      desc: '',
      args: [],
    );
  }

  /// `Manage Services`
  String get manageServices {
    return Intl.message(
      'Manage Services',
      name: 'manageServices',
      desc: '',
      args: [],
    );
  }

  /// `Manage Awards`
  String get manageAwards {
    return Intl.message(
      'Manage Awards',
      name: 'manageAwards',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message(
      'Wallet',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }

  /// `Earning Reports`
  String get earningReports {
    return Intl.message(
      'Earning Reports',
      name: 'earningReports',
      desc: '',
      args: [],
    );
  }

  /// `Payouts`
  String get payouts {
    return Intl.message(
      'Payouts',
      name: 'payouts',
      desc: '',
      args: [],
    );
  }

  /// `Terms Of Use`
  String get termsOfUse {
    return Intl.message(
      'Terms Of Use',
      name: 'termsOfUse',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Help & FAQ`
  String get helpAndFAQ {
    return Intl.message(
      'Help & FAQ',
      name: 'helpAndFAQ',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOut {
    return Intl.message(
      'Log Out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Delete My Account`
  String get deleteMyAccount {
    return Intl.message(
      'Delete My Account',
      name: 'deleteMyAccount',
      desc: '',
      args: [],
    );
  }

  /// `Salon Images`
  String get salonImages {
    return Intl.message(
      'Salon Images',
      name: 'salonImages',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Add Service`
  String get addService {
    return Intl.message(
      'Add Service',
      name: 'addService',
      desc: '',
      args: [],
    );
  }

  /// `Select Category`
  String get selectCategory {
    return Intl.message(
      'Select Category',
      name: 'selectCategory',
      desc: '',
      args: [],
    );
  }

  /// `Service Title`
  String get serviceTitle {
    return Intl.message(
      'Service Title',
      name: 'serviceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Discount (optional)`
  String get discountOptional {
    return Intl.message(
      'Discount (optional)',
      name: 'discountOptional',
      desc: '',
      args: [],
    );
  }

  /// `Time It Takes (Hours)`
  String get timeItTakesHours {
    return Intl.message(
      'Time It Takes (Hours)',
      name: 'timeItTakesHours',
      desc: '',
      args: [],
    );
  }

  /// `Time It Takes (Minutes)`
  String get timeItTakesMin {
    return Intl.message(
      'Time It Takes (Minutes)',
      name: 'timeItTakesMin',
      desc: '',
      args: [],
    );
  }

  /// `Gender (Service is for)`
  String get genderServiceIsFor {
    return Intl.message(
      'Gender (Service is for)',
      name: 'genderServiceIsFor',
      desc: '',
      args: [],
    );
  }

  /// `About Service`
  String get aboutService {
    return Intl.message(
      'About Service',
      name: 'aboutService',
      desc: '',
      args: [],
    );
  }

  /// `Service Images`
  String get serviceImages {
    return Intl.message(
      'Service Images',
      name: 'serviceImages',
      desc: '',
      args: [],
    );
  }

  /// `Add Award`
  String get addAward {
    return Intl.message(
      'Add Award',
      name: 'addAward',
      desc: '',
      args: [],
    );
  }

  /// `Award Title`
  String get awardTitle {
    return Intl.message(
      'Award Title',
      name: 'awardTitle',
      desc: '',
      args: [],
    );
  }

  /// `Awarded By`
  String get awardedBy {
    return Intl.message(
      'Awarded By',
      name: 'awardedBy',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Statement`
  String get statement {
    return Intl.message(
      'Statement',
      name: 'statement',
      desc: '',
      args: [],
    );
  }

  /// `Commission`
  String get commission {
    return Intl.message(
      'Commission',
      name: 'commission',
      desc: '',
      args: [],
    );
  }

  /// `Earning`
  String get earning {
    return Intl.message(
      'Earning',
      name: 'earning',
      desc: '',
      args: [],
    );
  }

  /// `Earnings Report`
  String get earningsReport {
    return Intl.message(
      'Earnings Report',
      name: 'earningsReport',
      desc: '',
      args: [],
    );
  }

  /// `Total Earning`
  String get totalEarning {
    return Intl.message(
      'Total Earning',
      name: 'totalEarning',
      desc: '',
      args: [],
    );
  }

  /// `Total Orders`
  String get totalOrders {
    return Intl.message(
      'Total Orders',
      name: 'totalOrders',
      desc: '',
      args: [],
    );
  }

  /// `Completed Orders`
  String get completedOrders {
    return Intl.message(
      'Completed Orders',
      name: 'completedOrders',
      desc: '',
      args: [],
    );
  }

  /// `Payout History`
  String get payoutHistory {
    return Intl.message(
      'Payout History',
      name: 'payoutHistory',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get oldPassword {
    return Intl.message(
      'Old Password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to logout ?`
  String get logoutDec {
    return Intl.message(
      'Do you really want to logout ?',
      name: 'logoutDec',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete your account?\nall of your data will deleted and you won’t\nbe able to recover it again !\n\nDo you really want to proceed?`
  String get deleteDesc {
    return Intl.message(
      'Do you really want to delete your account?\nall of your data will deleted and you won’t\nbe able to recover it again !\n\nDo you really want to proceed?',
      name: 'deleteDesc',
      desc: '',
      args: [],
    );
  }

  /// `QR Scan`
  String get qRScan {
    return Intl.message(
      'QR Scan',
      name: 'qRScan',
      desc: '',
      args: [],
    );
  }

  /// `QR Scan`
  String get qRScan1 {
    return Intl.message(
      'QR Scan',
      name: 'qRScan1',
      desc: '',
      args: [],
    );
  }

  /// `Scan the booking QR to get the details\nquickly`
  String get scanTheBookingQRToGetTheDetailsQuickly {
    return Intl.message(
      'Scan the booking QR to get the details\nquickly',
      name: 'scanTheBookingQRToGetTheDetailsQuickly',
      desc: '',
      args: [],
    );
  }

  /// `There is nothing to show.`
  String get thereIsNothingToShow {
    return Intl.message(
      'There is nothing to show.',
      name: 'thereIsNothingToShow',
      desc: '',
      args: [],
    );
  }

  /// `Please add something to your gallery so that users\ncan see what kind of services you are offering\nand the environment of your salon.`
  String get galleryDes {
    return Intl.message(
      'Please add something to your gallery so that users\ncan see what kind of services you are offering\nand the environment of your salon.',
      name: 'galleryDes',
      desc: '',
      args: [],
    );
  }

  /// `Add Images`
  String get addImages {
    return Intl.message(
      'Add Images',
      name: 'addImages',
      desc: '',
      args: [],
    );
  }

  /// `Description (Optional)`
  String get descriptionOptional {
    return Intl.message(
      'Description (Optional)',
      name: 'descriptionOptional',
      desc: '',
      args: [],
    );
  }

  /// `Offered By`
  String get offeredBy {
    return Intl.message(
      'Offered By',
      name: 'offeredBy',
      desc: '',
      args: [],
    );
  }

  /// `i`
  String get i {
    return Intl.message(
      'i',
      name: 'i',
      desc: '',
      args: [],
    );
  }

  /// `Please enter salon owner name`
  String get pleaseEnterSalonOwnerName {
    return Intl.message(
      'Please enter salon owner name',
      name: 'pleaseEnterSalonOwnerName',
      desc: '',
      args: [],
    );
  }

  /// `Please select owner image`
  String get pleaseSelectOwnerImage {
    return Intl.message(
      'Please select owner image',
      name: 'pleaseSelectOwnerImage',
      desc: '',
      args: [],
    );
  }

  /// `Please enter salon name`
  String get pleaseEnterSalonName {
    return Intl.message(
      'Please enter salon name',
      name: 'pleaseEnterSalonName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email address`
  String get pleaseEnterEmailAddress {
    return Intl.message(
      'Please enter email address',
      name: 'pleaseEnterEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get pleaseEnterPassword {
    return Intl.message(
      'Please enter password',
      name: 'pleaseEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter confirm password`
  String get pleaseEnterConfirmPassword {
    return Intl.message(
      'Please enter confirm password',
      name: 'pleaseEnterConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match`
  String get passwordDoesNotMatch {
    return Intl.message(
      'Password does not match',
      name: 'passwordDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `User Already Exist`
  String get userAlreadyExist {
    return Intl.message(
      'User Already Exist',
      name: 'userAlreadyExist',
      desc: '',
      args: [],
    );
  }

  /// `Location not Fount`
  String get locationNotFount {
    return Intl.message(
      'Location not Fount',
      name: 'locationNotFount',
      desc: '',
      args: [],
    );
  }

  /// `Location fetched`
  String get locationFetched {
    return Intl.message(
      'Location fetched',
      name: 'locationFetched',
      desc: '',
      args: [],
    );
  }

  /// `Please enter about salon`
  String get pleaseEnterAboutSalon {
    return Intl.message(
      'Please enter about salon',
      name: 'pleaseEnterAboutSalon',
      desc: '',
      args: [],
    );
  }

  /// `Please enter salon address`
  String get pleaseEnterSalonAddress {
    return Intl.message(
      'Please enter salon address',
      name: 'pleaseEnterSalonAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please enter salon phone`
  String get pleaseEnterSalonPhone {
    return Intl.message(
      'Please enter salon phone',
      name: 'pleaseEnterSalonPhone',
      desc: '',
      args: [],
    );
  }

  /// `Please select salon location`
  String get pleaseSelectSalonLocation {
    return Intl.message(
      'Please select salon location',
      name: 'pleaseSelectSalonLocation',
      desc: '',
      args: [],
    );
  }

  /// `Please select Monday-Friday open time`
  String get pleaseSelectMonFriFromTime {
    return Intl.message(
      'Please select Monday-Friday open time',
      name: 'pleaseSelectMonFriFromTime',
      desc: '',
      args: [],
    );
  }

  /// `Please select Monday-Friday close time`
  String get pleaseSelectMonFriToTime {
    return Intl.message(
      'Please select Monday-Friday close time',
      name: 'pleaseSelectMonFriToTime',
      desc: '',
      args: [],
    );
  }

  /// `Please select Saturday-Sunday open time`
  String get pleaseSelectSatSunFromTime {
    return Intl.message(
      'Please select Saturday-Sunday open time',
      name: 'pleaseSelectSatSunFromTime',
      desc: '',
      args: [],
    );
  }

  /// `Please select Saturday-Sunday close time`
  String get pleaseSelectSatSunToTime {
    return Intl.message(
      'Please select Saturday-Sunday close time',
      name: 'pleaseSelectSatSunToTime',
      desc: '',
      args: [],
    );
  }

  /// `Please select at least 1 category`
  String get pleaseSelectAtLeastOneCategory {
    return Intl.message(
      'Please select at least 1 category',
      name: 'pleaseSelectAtLeastOneCategory',
      desc: '',
      args: [],
    );
  }

  /// `Please select minimum 3 images`
  String get pleaseSelectMinimum3Images {
    return Intl.message(
      'Please select minimum 3 images',
      name: 'pleaseSelectMinimum3Images',
      desc: '',
      args: [],
    );
  }

  /// `Please enter bank name`
  String get pleaseEnterBankName {
    return Intl.message(
      'Please enter bank name',
      name: 'pleaseEnterBankName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter account number`
  String get pleaseEnterAccountNumber {
    return Intl.message(
      'Please enter account number',
      name: 'pleaseEnterAccountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Re-Enter account number`
  String get pleaseEnterRenterAccountNumber {
    return Intl.message(
      'Please enter Re-Enter account number',
      name: 'pleaseEnterRenterAccountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter  holders name`
  String get pleaseEnterHoldersName {
    return Intl.message(
      'Please enter  holders name',
      name: 'pleaseEnterHoldersName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter swift code`
  String get pleaseEnterSwiftCode {
    return Intl.message(
      'Please enter swift code',
      name: 'pleaseEnterSwiftCode',
      desc: '',
      args: [],
    );
  }

  /// `Account number does not matched`
  String get accountNumberDoesNotMatch {
    return Intl.message(
      'Account number does not matched',
      name: 'accountNumberDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Please select cancelled cheque photo.`
  String get selectCancelledCheque {
    return Intl.message(
      'Please select cancelled cheque photo.',
      name: 'selectCancelledCheque',
      desc: '',
      args: [],
    );
  }

  /// `Password reset link sent successfully...!`
  String get passwordResetLinkSentSuccessfully {
    return Intl.message(
      'Password reset link sent successfully...!',
      name: 'passwordResetLinkSentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Category`
  String get pleaseSelectCategory {
    return Intl.message(
      'Please Select Category',
      name: 'pleaseSelectCategory',
      desc: '',
      args: [],
    );
  }

  /// `Please enter service title`
  String get pleaseEnterServiceTitle {
    return Intl.message(
      'Please enter service title',
      name: 'pleaseEnterServiceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please enter price`
  String get pleaseEnterPrice {
    return Intl.message(
      'Please enter price',
      name: 'pleaseEnterPrice',
      desc: '',
      args: [],
    );
  }

  /// `Please enter time it takes`
  String get pleaseEnterTimeItTakes {
    return Intl.message(
      'Please enter time it takes',
      name: 'pleaseEnterTimeItTakes',
      desc: '',
      args: [],
    );
  }

  /// `Please enter award title`
  String get pleaseEnterAwardTitle {
    return Intl.message(
      'Please enter award title',
      name: 'pleaseEnterAwardTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please enter award by`
  String get pleaseEnterAwardBy {
    return Intl.message(
      'Please enter award by',
      name: 'pleaseEnterAwardBy',
      desc: '',
      args: [],
    );
  }

  /// `Please enter description`
  String get pleaseEnterDescription {
    return Intl.message(
      'Please enter description',
      name: 'pleaseEnterDescription',
      desc: '',
      args: [],
    );
  }

  /// `Please select image`
  String get pleaseSelectImage {
    return Intl.message(
      'Please select image',
      name: 'pleaseSelectImage',
      desc: '',
      args: [],
    );
  }

  /// `Select Month`
  String get selectMonth {
    return Intl.message(
      'Select Month',
      name: 'selectMonth',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw`
  String get withdraw {
    return Intl.message(
      'Withdraw',
      name: 'withdraw',
      desc: '',
      args: [],
    );
  }

  /// `Delete Image`
  String get deleteImage {
    return Intl.message(
      'Delete Image',
      name: 'deleteImage',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete image ?`
  String get deleteImageDes {
    return Intl.message(
      'Do you really want to delete image ?',
      name: 'deleteImageDes',
      desc: '',
      args: [],
    );
  }

  /// `Please try again...!`
  String get pleaseTryAgain {
    return Intl.message(
      'Please try again...!',
      name: 'pleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Jan`
  String get jan {
    return Intl.message(
      'Jan',
      name: 'jan',
      desc: '',
      args: [],
    );
  }

  /// `Feb`
  String get feb {
    return Intl.message(
      'Feb',
      name: 'feb',
      desc: '',
      args: [],
    );
  }

  /// `Mar`
  String get mar {
    return Intl.message(
      'Mar',
      name: 'mar',
      desc: '',
      args: [],
    );
  }

  /// `Apr`
  String get apr {
    return Intl.message(
      'Apr',
      name: 'apr',
      desc: '',
      args: [],
    );
  }

  /// `May`
  String get may {
    return Intl.message(
      'May',
      name: 'may',
      desc: '',
      args: [],
    );
  }

  /// `Jun`
  String get jun {
    return Intl.message(
      'Jun',
      name: 'jun',
      desc: '',
      args: [],
    );
  }

  /// `Jul`
  String get jul {
    return Intl.message(
      'Jul',
      name: 'jul',
      desc: '',
      args: [],
    );
  }

  /// `Aug`
  String get aug {
    return Intl.message(
      'Aug',
      name: 'aug',
      desc: '',
      args: [],
    );
  }

  /// `Sep`
  String get sep {
    return Intl.message(
      'Sep',
      name: 'sep',
      desc: '',
      args: [],
    );
  }

  /// `Oct`
  String get oct {
    return Intl.message(
      'Oct',
      name: 'oct',
      desc: '',
      args: [],
    );
  }

  /// `Nov`
  String get nov {
    return Intl.message(
      'Nov',
      name: 'nov',
      desc: '',
      args: [],
    );
  }

  /// `Dec`
  String get dec {
    return Intl.message(
      'Dec',
      name: 'dec',
      desc: '',
      args: [],
    );
  }

  /// `January`
  String get january {
    return Intl.message(
      'January',
      name: 'january',
      desc: '',
      args: [],
    );
  }

  /// `February`
  String get february {
    return Intl.message(
      'February',
      name: 'february',
      desc: '',
      args: [],
    );
  }

  /// `March`
  String get march {
    return Intl.message(
      'March',
      name: 'march',
      desc: '',
      args: [],
    );
  }

  /// `April`
  String get april {
    return Intl.message(
      'April',
      name: 'april',
      desc: '',
      args: [],
    );
  }

  /// `June`
  String get june {
    return Intl.message(
      'June',
      name: 'june',
      desc: '',
      args: [],
    );
  }

  /// `July`
  String get july {
    return Intl.message(
      'July',
      name: 'july',
      desc: '',
      args: [],
    );
  }

  /// `August`
  String get august {
    return Intl.message(
      'August',
      name: 'august',
      desc: '',
      args: [],
    );
  }

  /// `September`
  String get september {
    return Intl.message(
      'September',
      name: 'september',
      desc: '',
      args: [],
    );
  }

  /// `October`
  String get october {
    return Intl.message(
      'October',
      name: 'october',
      desc: '',
      args: [],
    );
  }

  /// `November`
  String get november {
    return Intl.message(
      'November',
      name: 'november',
      desc: '',
      args: [],
    );
  }

  /// `December`
  String get december {
    return Intl.message(
      'December',
      name: 'december',
      desc: '',
      args: [],
    );
  }

  /// `i`
  String get ij {
    return Intl.message(
      'i',
      name: 'ij',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `By`
  String get by {
    return Intl.message(
      'By',
      name: 'by',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw Request`
  String get withdrawTitle {
    return Intl.message(
      'Withdraw Request',
      name: 'withdrawTitle',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to withdraw all amount of your wallet?`
  String get withdrawDescription {
    return Intl.message(
      'Do you really want to withdraw all amount of your wallet?',
      name: 'withdrawDescription',
      desc: '',
      args: [],
    );
  }

  /// `Complete Booking`
  String get completeBooking {
    return Intl.message(
      'Complete Booking',
      name: 'completeBooking',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the completion OTP, below\nto complete the booking.\nAsk customer to provide the OTP.`
  String get pleaseEnterTheCompletionOtpBelowntoCompleteTheBookingnaskCustomer {
    return Intl.message(
      'Please enter the completion OTP, below\nto complete the booking.\nAsk customer to provide the OTP.',
      name: 'pleaseEnterTheCompletionOtpBelowntoCompleteTheBookingnaskCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Send Media`
  String get sendMedia {
    return Intl.message(
      'Send Media',
      name: 'sendMedia',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Too large...`
  String get tooLarge {
    return Intl.message(
      'Too large...',
      name: 'tooLarge',
      desc: '',
      args: [],
    );
  }

  /// `Video?`
  String get video {
    return Intl.message(
      'Video?',
      name: 'video',
      desc: '',
      args: [],
    );
  }

  /// `This video is greater than 15 mb\nPlease select another...`
  String get thisVideoIsGreaterThan15MbnpleaseSelectAnother {
    return Intl.message(
      'This video is greater than 15 mb\nPlease select another...',
      name: 'thisVideoIsGreaterThan15MbnpleaseSelectAnother',
      desc: '',
      args: [],
    );
  }

  /// `Select Another`
  String get selectAnother {
    return Intl.message(
      'Select Another',
      name: 'selectAnother',
      desc: '',
      args: [],
    );
  }

  /// `Select Message`
  String get selectMsg {
    return Intl.message(
      'Select Message',
      name: 'selectMsg',
      desc: '',
      args: [],
    );
  }

  /// `Delete Message`
  String get deleteMessage {
    return Intl.message(
      'Delete Message',
      name: 'deleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Delete for me`
  String get deleteForMe {
    return Intl.message(
      'Delete for me',
      name: 'deleteForMe',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Register your shop with us, find customers, manage appointments and grow business.`
  String get registerYourShopWithUsFindCustomersManageAppointmentsAnd {
    return Intl.message(
      'Register your shop with us, find customers, manage appointments and grow business.',
      name: 'registerYourShopWithUsFindCustomersManageAppointmentsAnd',
      desc: '',
      args: [],
    );
  }

  /// `Contact Number`
  String get contactDetail {
    return Intl.message(
      'Contact Number',
      name: 'contactDetail',
      desc: '',
      args: [],
    );
  }

  /// `Booking History`
  String get bookingHistory {
    return Intl.message(
      'Booking History',
      name: 'bookingHistory',
      desc: '',
      args: [],
    );
  }

  /// `Insufficient Amount to withdraw...!`
  String get insufficientAmountToWithdraw {
    return Intl.message(
      'Insufficient Amount to withdraw...!',
      name: 'insufficientAmountToWithdraw',
      desc: '',
      args: [],
    );
  }

  /// `Delete Service`
  String get deleteService {
    return Intl.message(
      'Delete Service',
      name: 'deleteService',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Banned`
  String get banned {
    return Intl.message(
      'Banned',
      name: 'banned',
      desc: '',
      args: [],
    );
  }

  /// `Your salon has been banned !`
  String get yourSalonHasBeenBanned {
    return Intl.message(
      'Your salon has been banned !',
      name: 'yourSalonHasBeenBanned',
      desc: '',
      args: [],
    );
  }

  /// `Your salon has been banned by super admin. Please contact on below email address to proceed further in this matter.`
  String get yourSalonHasBeenBannedBySuperAdminPleaseContact {
    return Intl.message(
      'Your salon has been banned by super admin. Please contact on below email address to proceed further in this matter.',
      name: 'yourSalonHasBeenBannedBySuperAdminPleaseContact',
      desc: '',
      args: [],
    );
  }

  /// `Add booking slots by week days`
  String get addBookingSlotsByWeekDays {
    return Intl.message(
      'Add booking slots by week days',
      name: 'addBookingSlotsByWeekDays',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get monday {
    return Intl.message(
      'Monday',
      name: 'monday',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `If you have added only 2 slots for Monday, then customers can select from those 2 slots for Monday.`
  String get ifYouHaveAddedOnly2SlotsForMondayThen {
    return Intl.message(
      'If you have added only 2 slots for Monday, then customers can select from those 2 slots for Monday.',
      name: 'ifYouHaveAddedOnly2SlotsForMondayThen',
      desc: '',
      args: [],
    );
  }

  /// `Please select from time first...!`
  String get pleaseSelectFromTimeFirst {
    return Intl.message(
      'Please select from time first...!',
      name: 'pleaseSelectFromTimeFirst',
      desc: '',
      args: [],
    );
  }

  /// `Select time after`
  String get selectTimeAfter {
    return Intl.message(
      'Select time after',
      name: 'selectTimeAfter',
      desc: '',
      args: [],
    );
  }

  /// `Select Time`
  String get selectTime {
    return Intl.message(
      'Select Time',
      name: 'selectTime',
      desc: '',
      args: [],
    );
  }

  /// `Add Slot`
  String get addSlot {
    return Intl.message(
      'Add Slot',
      name: 'addSlot',
      desc: '',
      args: [],
    );
  }

  /// `Please select slot time between your availability.`
  String get pleaseSelectSlotTimeBetweenYourAvailability {
    return Intl.message(
      'Please select slot time between your availability.',
      name: 'pleaseSelectSlotTimeBetweenYourAvailability',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Time...!`
  String get pleaseSelectTime {
    return Intl.message(
      'Please Select Time...!',
      name: 'pleaseSelectTime',
      desc: '',
      args: [],
    );
  }

  /// `Please complete availability first...!`
  String get pleaseCompleteAvailabilityFirst {
    return Intl.message(
      'Please complete availability first...!',
      name: 'pleaseCompleteAvailabilityFirst',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete this slot?`
  String get doYouReallyWantToDeleteThisSlot {
    return Intl.message(
      'Do you really want to delete this slot?',
      name: 'doYouReallyWantToDeleteThisSlot',
      desc: '',
      args: [],
    );
  }

  /// `Delete Slot`
  String get deleteSlot {
    return Intl.message(
      'Delete Slot',
      name: 'deleteSlot',
      desc: '',
      args: [],
    );
  }

  /// `Edit Availability & Slots`
  String get editAvailabilitySlots {
    return Intl.message(
      'Edit Availability & Slots',
      name: 'editAvailabilitySlots',
      desc: '',
      args: [],
    );
  }

  /// `Slots`
  String get slots {
    return Intl.message(
      'Slots',
      name: 'slots',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'da'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'el'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'nb'),
      Locale.fromSubtags(languageCode: 'nl'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'th'),
      Locale.fromSubtags(languageCode: 'tr'),
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
