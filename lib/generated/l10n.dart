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

  /// `Welcome To Irrigalink App`
  String get welcome_splash {
    return Intl.message(
      'Welcome To Irrigalink App',
      name: 'welcome_splash',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get language1 {
    return Intl.message(
      'English',
      name: 'language1',
      desc: '',
      args: [],
    );
  }

  /// `Amharic`
  String get language2 {
    return Intl.message(
      'Amharic',
      name: 'language2',
      desc: '',
      args: [],
    );
  }

  /// `Get Started `
  String get get_started {
    return Intl.message(
      'Get Started ',
      name: 'get_started',
      desc: '',
      args: [],
    );
  }

  /// `I am Farmer`
  String get i_am_farmer {
    return Intl.message(
      'I am Farmer',
      name: 'i_am_farmer',
      desc: '',
      args: [],
    );
  }

  /// `I am Distributor`
  String get i_am_dist {
    return Intl.message(
      'I am Distributor',
      name: 'i_am_dist',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message(
      'Sign Up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message(
      'Or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Farmer Signup`
  String get farmer_signup {
    return Intl.message(
      'Farmer Signup',
      name: 'farmer_signup',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get full_name {
    return Intl.message(
      'Full Name',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your full name`
  String get enter_full_name {
    return Intl.message(
      'Please enter your full name',
      name: 'enter_full_name',
      desc: '',
      args: [],
    );
  }

  /// `Name should contain only alphabet characters`
  String get name_alphabet_characters {
    return Intl.message(
      'Name should contain only alphabet characters',
      name: 'name_alphabet_characters',
      desc: '',
      args: [],
    );
  }

  /// `Profile Picture`
  String get profile_picture {
    return Intl.message(
      'Profile Picture',
      name: 'profile_picture',
      desc: '',
      args: [],
    );
  }

  /// `Please select a profile picture`
  String get select_profile_picture {
    return Intl.message(
      'Please select a profile picture',
      name: 'select_profile_picture',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get valid_email_address {
    return Intl.message(
      'Please enter a valid email address',
      name: 'valid_email_address',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone_number {
    return Intl.message(
      'Phone Number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number`
  String get enter_phone_number {
    return Intl.message(
      'Please enter your phone number',
      name: 'enter_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Phone number should contain only numbers`
  String get phone_number_numbers {
    return Intl.message(
      'Phone number should contain only numbers',
      name: 'phone_number_numbers',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your address`
  String get enter_address {
    return Intl.message(
      'Please enter your address',
      name: 'enter_address',
      desc: '',
      args: [],
    );
  }

  /// `Crops you Produce`
  String get crops_you_produce {
    return Intl.message(
      'Crops you Produce',
      name: 'crops_you_produce',
      desc: '',
      args: [],
    );
  }

  /// `Crops you Produce`
  String get crops_produced {
    return Intl.message(
      'Crops you Produce',
      name: 'crops_produced',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the crops you produce`
  String get enter_crops_produced {
    return Intl.message(
      'Please enter the crops you produce',
      name: 'enter_crops_produced',
      desc: '',
      args: [],
    );
  }

  /// `Land Size`
  String get land_size {
    return Intl.message(
      'Land Size',
      name: 'land_size',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your land size`
  String get enter_land_size {
    return Intl.message(
      'Please enter your land size',
      name: 'enter_land_size',
      desc: '',
      args: [],
    );
  }

  /// `Land size should contain only numbers`
  String get land_size_numbers {
    return Intl.message(
      'Land size should contain only numbers',
      name: 'land_size_numbers',
      desc: '',
      args: [],
    );
  }

  /// `Farming Experience (years)`
  String get farming_experience {
    return Intl.message(
      'Farming Experience (years)',
      name: 'farming_experience',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your farming experience`
  String get enter_farming_experience {
    return Intl.message(
      'Please enter your farming experience',
      name: 'enter_farming_experience',
      desc: '',
      args: [],
    );
  }

  /// `Experience should contain only numbers`
  String get experience_numbers {
    return Intl.message(
      'Experience should contain only numbers',
      name: 'experience_numbers',
      desc: '',
      args: [],
    );
  }

  /// `Farm Land Picture`
  String get farm_land_picture {
    return Intl.message(
      'Farm Land Picture',
      name: 'farm_land_picture',
      desc: '',
      args: [],
    );
  }

  /// `Please select a farm land picture`
  String get select_farm_land_picture {
    return Intl.message(
      'Please select a farm land picture',
      name: 'select_farm_land_picture',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next_step {
    return Intl.message(
      'Next',
      name: 'next_step',
      desc: '',
      args: [],
    );
  }

  /// `OTP Verification`
  String get otp_verification {
    return Intl.message(
      'OTP Verification',
      name: 'otp_verification',
      desc: '',
      args: [],
    );
  }

  /// `Enter the OTP sent to your mobile number`
  String get enter_otp_message {
    return Intl.message(
      'Enter the OTP sent to your mobile number',
      name: 'enter_otp_message',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect OTP. Please try again.`
  String get incorrect_otp_message {
    return Intl.message(
      'Incorrect OTP. Please try again.',
      name: 'incorrect_otp_message',
      desc: '',
      args: [],
    );
  }

  /// `Verify OTP`
  String get verify_otp {
    return Intl.message(
      'Verify OTP',
      name: 'verify_otp',
      desc: '',
      args: [],
    );
  }

  /// `Next Screen`
  String get next_screen {
    return Intl.message(
      'Next Screen',
      name: 'next_screen',
      desc: '',
      args: [],
    );
  }

  /// `OTP Verified!`
  String get otp_verified_message {
    return Intl.message(
      'OTP Verified!',
      name: 'otp_verified_message',
      desc: '',
      args: [],
    );
  }

  /// `IrrigaLink`
  String get irrigaLink {
    return Intl.message(
      'IrrigaLink',
      name: 'irrigaLink',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get chats {
    return Intl.message(
      'Chats',
      name: 'chats',
      desc: '',
      args: [],
    );
  }

  /// `Sensor Data`
  String get sensorData {
    return Intl.message(
      'Sensor Data',
      name: 'sensorData',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Distributors`
  String get distributors {
    return Intl.message(
      'Distributors',
      name: 'distributors',
      desc: '',
      args: [],
    );
  }

  /// `Market Price`
  String get marketPrice {
    return Intl.message(
      'Market Price',
      name: 'marketPrice',
      desc: '',
      args: [],
    );
  }

  /// `Chats Section Coming Soon...`
  String get chatsSectionComingSoon {
    return Intl.message(
      'Chats Section Coming Soon...',
      name: 'chatsSectionComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Sensor Data Section Coming Soon...`
  String get sensorDataSectionComingSoon {
    return Intl.message(
      'Sensor Data Section Coming Soon...',
      name: 'sensorDataSectionComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Home Page Section Coming Soon...`
  String get homePageSectionComingSoon {
    return Intl.message(
      'Home Page Section Coming Soon...',
      name: 'homePageSectionComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Distributors Section Coming Soon...`
  String get distributorsSectionComingSoon {
    return Intl.message(
      'Distributors Section Coming Soon...',
      name: 'distributorsSectionComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Market Prices Section Coming Soon...`
  String get marketPricesSectionComingSoon {
    return Intl.message(
      'Market Prices Section Coming Soon...',
      name: 'marketPricesSectionComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Mahfouz Teyib`
  String get drawer_account_name {
    return Intl.message(
      'Mahfouz Teyib',
      name: 'drawer_account_name',
      desc: '',
      args: [],
    );
  }

  /// `+251-929-146-352`
  String get drawer_account_email {
    return Intl.message(
      '+251-929-146-352',
      name: 'drawer_account_email',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get drawer_home {
    return Intl.message(
      'Home',
      name: 'drawer_home',
      desc: '',
      args: [],
    );
  }

  /// `My Books`
  String get drawer_my_books {
    return Intl.message(
      'My Books',
      name: 'drawer_my_books',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get drawer_favorites {
    return Intl.message(
      'Favorites',
      name: 'drawer_favorites',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get drawer_change_language {
    return Intl.message(
      'Change Language',
      name: 'drawer_change_language',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get drawer_settings {
    return Intl.message(
      'Settings',
      name: 'drawer_settings',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `ID Number`
  String get idNumber {
    return Intl.message(
      'ID Number',
      name: 'idNumber',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Experience`
  String get experience {
    return Intl.message(
      'Experience',
      name: 'experience',
      desc: '',
      args: [],
    );
  }

  /// `years`
  String get years {
    return Intl.message(
      'years',
      name: 'years',
      desc: '',
      args: [],
    );
  }

  /// `Online`
  String get online {
    return Intl.message(
      'Online',
      name: 'online',
      desc: '',
      args: [],
    );
  }

  /// `Offline`
  String get offline {
    return Intl.message(
      'Offline',
      name: 'offline',
      desc: '',
      args: [],
    );
  }

  /// `Living In`
  String get livingIn {
    return Intl.message(
      'Living In',
      name: 'livingIn',
      desc: '',
      args: [],
    );
  }

  /// `Phone No`
  String get phoneNo {
    return Intl.message(
      'Phone No',
      name: 'phoneNo',
      desc: '',
      args: [],
    );
  }

  /// `Crops Produced`
  String get cropsProduced {
    return Intl.message(
      'Crops Produced',
      name: 'cropsProduced',
      desc: '',
      args: [],
    );
  }

  /// `No Farmers Yet`
  String get no_farmers_yet {
    return Intl.message(
      'No Farmers Yet',
      name: 'no_farmers_yet',
      desc: '',
      args: [],
    );
  }

  /// `Farmer Detail`
  String get farmer_detail {
    return Intl.message(
      'Farmer Detail',
      name: 'farmer_detail',
      desc: '',
      args: [],
    );
  }

  /// `Distributor Detail`
  String get distributor_detail {
    return Intl.message(
      'Distributor Detail',
      name: 'distributor_detail',
      desc: '',
      args: [],
    );
  }

  /// `Farm Image`
  String get farmImage {
    return Intl.message(
      'Farm Image',
      name: 'farmImage',
      desc: '',
      args: [],
    );
  }

  /// `Start Chat`
  String get startChat {
    return Intl.message(
      'Start Chat',
      name: 'startChat',
      desc: '',
      args: [],
    );
  }

  /// `birr`
  String get birr {
    return Intl.message(
      'birr',
      name: 'birr',
      desc: '',
      args: [],
    );
  }

  /// `Current Price`
  String get current_price {
    return Intl.message(
      'Current Price',
      name: 'current_price',
      desc: '',
      args: [],
    );
  }

  /// `Price Unit`
  String get price_unit {
    return Intl.message(
      'Price Unit',
      name: 'price_unit',
      desc: '',
      args: [],
    );
  }

  /// `Update Time`
  String get update_time {
    return Intl.message(
      'Update Time',
      name: 'update_time',
      desc: '',
      args: [],
    );
  }

  /// `Manage Profile`
  String get manageProfile {
    return Intl.message(
      'Manage Profile',
      name: 'manageProfile',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logout {
    return Intl.message(
      'Log Out',
      name: 'logout',
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

  /// `Addis Ababa`
  String get addis_ababa {
    return Intl.message(
      'Addis Ababa',
      name: 'addis_ababa',
      desc: '',
      args: [],
    );
  }

  /// `Afar`
  String get afar {
    return Intl.message(
      'Afar',
      name: 'afar',
      desc: '',
      args: [],
    );
  }

  /// `Amhara`
  String get amhara {
    return Intl.message(
      'Amhara',
      name: 'amhara',
      desc: '',
      args: [],
    );
  }

  /// `Benishangul-Gumuz`
  String get benishangul_gumuz {
    return Intl.message(
      'Benishangul-Gumuz',
      name: 'benishangul_gumuz',
      desc: '',
      args: [],
    );
  }

  /// `Dire Dawa`
  String get dire_dawa {
    return Intl.message(
      'Dire Dawa',
      name: 'dire_dawa',
      desc: '',
      args: [],
    );
  }

  /// `Gambela`
  String get gambela {
    return Intl.message(
      'Gambela',
      name: 'gambela',
      desc: '',
      args: [],
    );
  }

  /// `Harari`
  String get harari {
    return Intl.message(
      'Harari',
      name: 'harari',
      desc: '',
      args: [],
    );
  }

  /// `Oromia`
  String get oromia {
    return Intl.message(
      'Oromia',
      name: 'oromia',
      desc: '',
      args: [],
    );
  }

  /// `Sidama`
  String get sidama {
    return Intl.message(
      'Sidama',
      name: 'sidama',
      desc: '',
      args: [],
    );
  }

  /// `Somali`
  String get somali {
    return Intl.message(
      'Somali',
      name: 'somali',
      desc: '',
      args: [],
    );
  }

  /// `Tigray`
  String get tigray {
    return Intl.message(
      'Tigray',
      name: 'tigray',
      desc: '',
      args: [],
    );
  }

  /// `Onions`
  String get onion {
    return Intl.message(
      'Onions',
      name: 'onion',
      desc: '',
      args: [],
    );
  }

  /// `Tomato`
  String get tomato {
    return Intl.message(
      'Tomato',
      name: 'tomato',
      desc: '',
      args: [],
    );
  }

  /// `Wheat`
  String get wheat {
    return Intl.message(
      'Wheat',
      name: 'wheat',
      desc: '',
      args: [],
    );
  }

  /// `Corn`
  String get corn {
    return Intl.message(
      'Corn',
      name: 'corn',
      desc: '',
      args: [],
    );
  }

  /// `Rice`
  String get rice {
    return Intl.message(
      'Rice',
      name: 'rice',
      desc: '',
      args: [],
    );
  }

  /// `Barley`
  String get barley {
    return Intl.message(
      'Barley',
      name: 'barley',
      desc: '',
      args: [],
    );
  }

  /// `Teff`
  String get teff {
    return Intl.message(
      'Teff',
      name: 'teff',
      desc: '',
      args: [],
    );
  }

  /// `Sorghum`
  String get sorghum {
    return Intl.message(
      'Sorghum',
      name: 'sorghum',
      desc: '',
      args: [],
    );
  }

  /// `Coffee`
  String get cofee {
    return Intl.message(
      'Coffee',
      name: 'cofee',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get khat {
    return Intl.message(
      'Chat',
      name: 'khat',
      desc: '',
      args: [],
    );
  }

  /// `Potato`
  String get potato {
    return Intl.message(
      'Potato',
      name: 'potato',
      desc: '',
      args: [],
    );
  }

  /// `Looking for ...`
  String get looking_for {
    return Intl.message(
      'Looking for ...',
      name: 'looking_for',
      desc: '',
      args: [],
    );
  }

  /// `Save Cahnges`
  String get save_changes {
    return Intl.message(
      'Save Cahnges',
      name: 'save_changes',
      desc: '',
      args: [],
    );
  }

  /// `Distributing Experience (years)`
  String get distributing_experience {
    return Intl.message(
      'Distributing Experience (years)',
      name: 'distributing_experience',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your distributing experience`
  String get enter_distributing_experience {
    return Intl.message(
      'Please enter your distributing experience',
      name: 'enter_distributing_experience',
      desc: '',
      args: [],
    );
  }

  /// `Store Picture`
  String get store_picture {
    return Intl.message(
      'Store Picture',
      name: 'store_picture',
      desc: '',
      args: [],
    );
  }

  /// `Please select a store picture`
  String get select_store_picture {
    return Intl.message(
      'Please select a store picture',
      name: 'select_store_picture',
      desc: '',
      args: [],
    );
  }

  /// `Distributor Signup`
  String get dist_signup {
    return Intl.message(
      'Distributor Signup',
      name: 'dist_signup',
      desc: '',
      args: [],
    );
  }

  /// `Farmers`
  String get farmers {
    return Intl.message(
      'Farmers',
      name: 'farmers',
      desc: '',
      args: [],
    );
  }

  /// `Crops you Sell`
  String get crops_you_sell {
    return Intl.message(
      'Crops you Sell',
      name: 'crops_you_sell',
      desc: '',
      args: [],
    );
  }

  /// `Crops Selled`
  String get crops_selled {
    return Intl.message(
      'Crops Selled',
      name: 'crops_selled',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the crops you sell`
  String get enter_crops_selled {
    return Intl.message(
      'Please enter the crops you sell',
      name: 'enter_crops_selled',
      desc: '',
      args: [],
    );
  }

  /// `Addis Ababa, Ethiopia`
  String get addisAbabaEthiopia {
    return Intl.message(
      'Addis Ababa, Ethiopia',
      name: 'addisAbabaEthiopia',
      desc: '',
      args: [],
    );
  }

  /// `Ethiopia`
  String get ethiopia {
    return Intl.message(
      'Ethiopia',
      name: 'ethiopia',
      desc: '',
      args: [],
    );
  }

  /// `Farm not configured yet, please configure it to use this service`
  String get farmNotConfiguredMessage {
    return Intl.message(
      'Farm not configured yet, please configure it to use this service',
      name: 'farmNotConfiguredMessage',
      desc: '',
      args: [],
    );
  }

  /// `Watering`
  String get watering {
    return Intl.message(
      'Watering',
      name: 'watering',
      desc: '',
      args: [],
    );
  }

  /// `Enable manual mode for better efficiency`
  String get manualModeRecommendation {
    return Intl.message(
      'Enable manual mode for better efficiency',
      name: 'manualModeRecommendation',
      desc: '',
      args: [],
    );
  }

  /// `Enable automatic mode for better efficiency`
  String get automaticModeRecommendation {
    return Intl.message(
      'Enable automatic mode for better efficiency',
      name: 'automaticModeRecommendation',
      desc: '',
      args: [],
    );
  }

  /// `Current Weather`
  String get currentWeather {
    return Intl.message(
      'Current Weather',
      name: 'currentWeather',
      desc: '',
      args: [],
    );
  }

  /// `Soil Moisture Sensor Data`
  String get soilMoistureSensorData {
    return Intl.message(
      'Soil Moisture Sensor Data',
      name: 'soilMoistureSensorData',
      desc: '',
      args: [],
    );
  }

  /// `Moisture Level`
  String get moistureLevel {
    return Intl.message(
      'Moisture Level',
      name: 'moistureLevel',
      desc: '',
      args: [],
    );
  }

  /// `Switch Modes`
  String get switchModes {
    return Intl.message(
      'Switch Modes',
      name: 'switchModes',
      desc: '',
      args: [],
    );
  }

  /// `Auto`
  String get auto {
    return Intl.message(
      'Auto',
      name: 'auto',
      desc: '',
      args: [],
    );
  }

  /// `Manual`
  String get manual {
    return Intl.message(
      'Manual',
      name: 'manual',
      desc: '',
      args: [],
    );
  }

  /// `Automatic Mode Enabled`
  String get automaticModeEnabled {
    return Intl.message(
      'Automatic Mode Enabled',
      name: 'automaticModeEnabled',
      desc: '',
      args: [],
    );
  }

  /// `Manual Mode Enabled\nTurn the pump on and off`
  String get manualModeEnabled {
    return Intl.message(
      'Manual Mode Enabled\nTurn the pump on and off',
      name: 'manualModeEnabled',
      desc: '',
      args: [],
    );
  }

  /// `Last 7 days Soil Moisture`
  String get last7DaysSoilMoisture {
    return Intl.message(
      'Last 7 days Soil Moisture',
      name: 'last7DaysSoilMoisture',
      desc: '',
      args: [],
    );
  }

  /// `Turn On`
  String get turnOn {
    return Intl.message(
      'Turn On',
      name: 'turnOn',
      desc: '',
      args: [],
    );
  }

  /// `Turn Off`
  String get turnOff {
    return Intl.message(
      'Turn Off',
      name: 'turnOff',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `all`
  String get all {
    return Intl.message(
      'all',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Fruits`
  String get fruits {
    return Intl.message(
      'Fruits',
      name: 'fruits',
      desc: '',
      args: [],
    );
  }

  /// `Vegetables`
  String get vegetables {
    return Intl.message(
      'Vegetables',
      name: 'vegetables',
      desc: '',
      args: [],
    );
  }

  /// `other`
  String get other {
    return Intl.message(
      'other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `connect with distributors seamlessly.manage orders,track deliveries, and streamline your distribution process.`
  String get distributors_message {
    return Intl.message(
      'connect with distributors seamlessly.manage orders,track deliveries, and streamline your distribution process.',
      name: 'distributors_message',
      desc: '',
      args: [],
    );
  }

  /// `Weather`
  String get weather {
    return Intl.message(
      'Weather',
      name: 'weather',
      desc: '',
      args: [],
    );
  }

  /// `Testimony`
  String get testimony {
    return Intl.message(
      'Testimony',
      name: 'testimony',
      desc: '',
      args: [],
    );
  }

  /// `rainy day`
  String get rainy_day {
    return Intl.message(
      'rainy day',
      name: 'rainy_day',
      desc: '',
      args: [],
    );
  }

  /// `cloudy day`
  String get cloudy_day {
    return Intl.message(
      'cloudy day',
      name: 'cloudy_day',
      desc: '',
      args: [],
    );
  }

  /// `sunny day`
  String get sunny_day {
    return Intl.message(
      'sunny day',
      name: 'sunny_day',
      desc: '',
      args: [],
    );
  }

  /// `feels like`
  String get feels_like {
    return Intl.message(
      'feels like',
      name: 'feels_like',
      desc: '',
      args: [],
    );
  }

  /// `Explore market prices in real-time. Make informed decisions with accurate and up-to-date market information.`
  String get marketPriceMessage {
    return Intl.message(
      'Explore market prices in real-time. Make informed decisions with accurate and up-to-date market information.',
      name: 'marketPriceMessage',
      desc: '',
      args: [],
    );
  }

  /// `Add More`
  String get add_more {
    return Intl.message(
      'Add More',
      name: 'add_more',
      desc: '',
      args: [],
    );
  }

  /// `Explore now`
  String get explore {
    return Intl.message(
      'Explore now',
      name: 'explore',
      desc: '',
      args: [],
    );
  }

  /// `connect with farmers seamlessly.manage orders,track deliveries, and streamline your distribution process.`
  String get farmers_message {
    return Intl.message(
      'connect with farmers seamlessly.manage orders,track deliveries, and streamline your distribution process.',
      name: 'farmers_message',
      desc: '',
      args: [],
    );
  }

  /// `Soil Study Info`
  String get soilStudyInfo {
    return Intl.message(
      'Soil Study Info',
      name: 'soilStudyInfo',
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
      Locale.fromSubtags(languageCode: 'am'),
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
