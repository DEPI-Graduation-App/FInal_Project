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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `welcome to our app`
  String get welcomeToApp {
    return Intl.message(
      'welcome to our app',
      name: 'welcomeToApp',
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
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `don't have an account? `
  String get dontHaveAccount {
    return Intl.message(
      'don\'t have an account? ',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `create`
  String get create {
    return Intl.message('create', name: 'create', desc: '', args: []);
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
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

  /// `Enter your email`
  String get enterEmail {
    return Intl.message(
      'Enter your email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter your username`
  String get enterUsername {
    return Intl.message(
      'Enter your username',
      name: 'enterUsername',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enterPassword {
    return Intl.message(
      'Enter your password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter your password`
  String get reEnterPassword {
    return Intl.message(
      'Re-enter your password',
      name: 'reEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Success`
  String get success {
    return Intl.message('Success', name: 'success', desc: '', args: []);
  }

  /// `Please fill all fields`
  String get pleaseFillAllFields {
    return Intl.message(
      'Please fill all fields',
      name: 'pleaseFillAllFields',
      desc: '',
      args: [],
    );
  }

  /// `Login Successful`
  String get loginSuccessful {
    return Intl.message(
      'Login Successful',
      name: 'loginSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Invalid credentials`
  String get invalidCredentials {
    return Intl.message(
      'Invalid credentials',
      name: 'invalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password`
  String get wrongPassword {
    return Intl.message(
      'Wrong password',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please try again`
  String get pleaseTryAgain {
    return Intl.message(
      'Please try again',
      name: 'pleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Email not found`
  String get emailNotFound {
    return Intl.message(
      'Email not found',
      name: 'emailNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Try signing up`
  String get trySigningUp {
    return Intl.message(
      'Try signing up',
      name: 'trySigningUp',
      desc: '',
      args: [],
    );
  }

  /// `Authentication Error`
  String get authenticationError {
    return Intl.message(
      'Authentication Error',
      name: 'authenticationError',
      desc: '',
      args: [],
    );
  }

  /// `Account created successfully!`
  String get accountCreatedSuccessfully {
    return Intl.message(
      'Account created successfully!',
      name: 'accountCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Email is already registered or invalid`
  String get emailAlreadyRegistered {
    return Intl.message(
      'Email is already registered or invalid',
      name: 'emailAlreadyRegistered',
      desc: '',
      args: [],
    );
  }

  /// `Email already registered. Try logging in.`
  String get emailAlreadyExists {
    return Intl.message(
      'Email already registered. Try logging in.',
      name: 'emailAlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `Weak password. Try a stronger password.`
  String get weakPassword {
    return Intl.message(
      'Weak password. Try a stronger password.',
      name: 'weakPassword',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error: {error}`
  String unexpectedError(Object error) {
    return Intl.message(
      'Unexpected error: $error',
      name: 'unexpectedError',
      desc: '',
      args: [error],
    );
  }

  /// `Image too large`
  String get imageTooLarge {
    return Intl.message(
      'Image too large',
      name: 'imageTooLarge',
      desc: '',
      args: [],
    );
  }

  /// `Image dimensions exceed {maxWidth} x {maxHeight}. Please choose a smaller image.`
  String imageDimensionsExceed(Object maxWidth, Object maxHeight) {
    return Intl.message(
      'Image dimensions exceed $maxWidth x $maxHeight. Please choose a smaller image.',
      name: 'imageDimensionsExceed',
      desc: '',
      args: [maxWidth, maxHeight],
    );
  }

  /// `Unable to read image. Please choose another picture.`
  String get unableToReadImage {
    return Intl.message(
      'Unable to read image. Please choose another picture.',
      name: 'unableToReadImage',
      desc: '',
      args: [],
    );
  }

  /// `User not logged in`
  String get userNotLoggedIn {
    return Intl.message(
      'User not logged in',
      name: 'userNotLoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Username updated`
  String get usernameUpdated {
    return Intl.message(
      'Username updated',
      name: 'usernameUpdated',
      desc: '',
      args: [],
    );
  }

  /// `You didn't update nothing`
  String get youDidntUpdateNothing {
    return Intl.message(
      'You didn\'t update nothing',
      name: 'youDidntUpdateNothing',
      desc: '',
      args: [],
    );
  }

  /// `Added`
  String get added {
    return Intl.message('Added', name: 'added', desc: '', args: []);
  }

  /// `Category {category} added to Favorites`
  String categoryAddedToFavorites(Object category) {
    return Intl.message(
      'Category $category added to Favorites',
      name: 'categoryAddedToFavorites',
      desc: '',
      args: [category],
    );
  }

  /// `Removed`
  String get removed {
    return Intl.message('Removed', name: 'removed', desc: '', args: []);
  }

  /// `Category {category} removed from Favorites`
  String categoryRemovedFromFavorites(Object category) {
    return Intl.message(
      'Category $category removed from Favorites',
      name: 'categoryRemovedFromFavorites',
      desc: '',
      args: [category],
    );
  }

  /// `Your briefing is read`
  String get briefingReady {
    return Intl.message(
      'Your briefing is read',
      name: 'briefingReady',
      desc: '',
      args: [],
    );
  }

  /// `{topic} summary is ready`
  String summaryReady(Object topic) {
    return Intl.message(
      '$topic summary is ready',
      name: 'summaryReady',
      desc: '',
      args: [topic],
    );
  }

  /// `Failed to generate summary: {error}`
  String failedToGenerateSummary(Object error) {
    return Intl.message(
      'Failed to generate summary: $error',
      name: 'failedToGenerateSummary',
      desc: '',
      args: [error],
    );
  }

  /// `Password must be at least 6 characters`
  String get passwordLengthError {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordLengthError',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get invalidEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homeTitle {
    return Intl.message('Home', name: 'homeTitle', desc: '', args: []);
  }

  /// `News categories`
  String get newsCategories {
    return Intl.message(
      'News categories',
      name: 'newsCategories',
      desc: '',
      args: [],
    );
  }

  /// `No description available.`
  String get noDescriptionAvailable {
    return Intl.message(
      'No description available.',
      name: 'noDescriptionAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favoritesTitle {
    return Intl.message(
      'Favorites',
      name: 'favoritesTitle',
      desc: '',
      args: [],
    );
  }

  /// `No favorites yet`
  String get noFavoritesYet {
    return Intl.message(
      'No favorites yet',
      name: 'noFavoritesYet',
      desc: '',
      args: [],
    );
  }

  /// `Add categories to see them here`
  String get addCategoriesToSeeThem {
    return Intl.message(
      'Add categories to see them here',
      name: 'addCategoriesToSeeThem',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profileTitle {
    return Intl.message('Profile', name: 'profileTitle', desc: '', args: []);
  }

  /// `Choose profile picture`
  String get chooseProfilePicture {
    return Intl.message(
      'Choose profile picture',
      name: 'chooseProfilePicture',
      desc: '',
      args: [],
    );
  }

  /// `Upload from Gallery`
  String get uploadFromGallery {
    return Intl.message(
      'Upload from Gallery',
      name: 'uploadFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Take a Photo`
  String get takeAPhoto {
    return Intl.message('Take a Photo', name: 'takeAPhoto', desc: '', args: []);
  }

  /// `Email`
  String get emailLabel {
    return Intl.message('Email', name: 'emailLabel', desc: '', args: []);
  }

  /// `Username: {username}`
  String usernameLabel(Object username) {
    return Intl.message(
      'Username: $username',
      name: 'usernameLabel',
      desc: '',
      args: [username],
    );
  }

  /// `Edit username`
  String get editUsernameHint {
    return Intl.message(
      'Edit username',
      name: 'editUsernameHint',
      desc: '',
      args: [],
    );
  }

  /// `Update / Save`
  String get updateSaveButton {
    return Intl.message(
      'Update / Save',
      name: 'updateSaveButton',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logoutButton {
    return Intl.message('Log out', name: 'logoutButton', desc: '', args: []);
  }

  /// `No news found`
  String get noNewsFound {
    return Intl.message(
      'No news found',
      name: 'noNewsFound',
      desc: '',
      args: [],
    );
  }

  /// `Search news...`
  String get searchNewsHint {
    return Intl.message(
      'Search news...',
      name: 'searchNewsHint',
      desc: '',
      args: [],
    );
  }

  /// `Source1`
  String get source1 {
    return Intl.message('Source1', name: 'source1', desc: '', args: []);
  }

  /// `Source2`
  String get source2 {
    return Intl.message('Source2', name: 'source2', desc: '', args: []);
  }

  /// `No summary available`
  String get noSummaryAvailable {
    return Intl.message(
      'No summary available',
      name: 'noSummaryAvailable',
      desc: '',
      args: [],
    );
  }

  /// `View article`
  String get viewArticle {
    return Intl.message(
      'View article',
      name: 'viewArticle',
      desc: '',
      args: [],
    );
  }

  /// `Similar News`
  String get similarNews {
    return Intl.message(
      'Similar News',
      name: 'similarNews',
      desc: '',
      args: [],
    );
  }

  /// `No similar news found`
  String get noSimilarNewsFound {
    return Intl.message(
      'No similar news found',
      name: 'noSimilarNewsFound',
      desc: '',
      args: [],
    );
  }

  /// `Cannot open this article`
  String get cannotOpenArticle {
    return Intl.message(
      'Cannot open this article',
      name: 'cannotOpenArticle',
      desc: '',
      args: [],
    );
  }

  /// `No categories available`
  String get noCategoriesAvailable {
    return Intl.message(
      'No categories available',
      name: 'noCategoriesAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load categories`
  String get failedToLoadCategories {
    return Intl.message(
      'Failed to load categories',
      name: 'failedToLoadCategories',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load news for {category}`
  String failedToLoadNewsFor(Object category) {
    return Intl.message(
      'Failed to load news for $category',
      name: 'failedToLoadNewsFor',
      desc: '',
      args: [category],
    );
  }

  /// `Business`
  String get business {
    return Intl.message('Business', name: 'business', desc: '', args: []);
  }

  /// `Entertainment`
  String get entertainment {
    return Intl.message(
      'Entertainment',
      name: 'entertainment',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message('General', name: 'general', desc: '', args: []);
  }

  /// `Health`
  String get health {
    return Intl.message('Health', name: 'health', desc: '', args: []);
  }

  /// `Science`
  String get science {
    return Intl.message('Science', name: 'science', desc: '', args: []);
  }

  /// `Sports`
  String get sports {
    return Intl.message('Sports', name: 'sports', desc: '', args: []);
  }

  /// `Technology`
  String get technology {
    return Intl.message('Technology', name: 'technology', desc: '', args: []);
  }

  /// `Internal server error`
  String get internalServerError {
    return Intl.message(
      'Internal server error',
      name: 'internalServerError',
      desc: '',
      args: [],
    );
  }

  /// `Resource not found`
  String get resourceNotFound {
    return Intl.message(
      'Resource not found',
      name: 'resourceNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Bad request`
  String get badRequest {
    return Intl.message('Bad request', name: 'badRequest', desc: '', args: []);
  }

  /// `Unauthorized access`
  String get unauthorizedAccess {
    return Intl.message(
      'Unauthorized access',
      name: 'unauthorizedAccess',
      desc: '',
      args: [],
    );
  }

  /// `Access forbidden. Please check your API key.`
  String get accessForbidden {
    return Intl.message(
      'Access forbidden. Please check your API key.',
      name: 'accessForbidden',
      desc: '',
      args: [],
    );
  }

  /// `Too many requests. Please try again later.`
  String get tooManyRequests {
    return Intl.message(
      'Too many requests. Please try again later.',
      name: 'tooManyRequests',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get noInternetConnection {
    return Intl.message(
      'No internet connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Request was cancelled`
  String get requestCancelled {
    return Intl.message(
      'Request was cancelled',
      name: 'requestCancelled',
      desc: '',
      args: [],
    );
  }

  /// `An unknown error occurred`
  String get unknownError {
    return Intl.message(
      'An unknown error occurred',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `News Notifications`
  String get newsNotifications {
    return Intl.message(
      'News Notifications',
      name: 'newsNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Notifications for favorite categories`
  String get notificationsChannelDescription {
    return Intl.message(
      'Notifications for favorite categories',
      name: 'notificationsChannelDescription',
      desc: '',
      args: [],
    );
  }

  /// `AI News Briefing`
  String get aiNewsBriefing {
    return Intl.message(
      'AI News Briefing',
      name: 'aiNewsBriefing',
      desc: '',
      args: [],
    );
  }

  /// `Briefing: {label}`
  String briefingTitle(Object label) {
    return Intl.message(
      'Briefing: $label',
      name: 'briefingTitle',
      desc: '',
      args: [label],
    );
  }

  /// `No recent articles found regarding this topic.`
  String get noRecentArticles {
    return Intl.message(
      'No recent articles found regarding this topic.',
      name: 'noRecentArticles',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while analyzing news.`
  String get errorAnalyzingNews {
    return Intl.message(
      'An error occurred while analyzing news.',
      name: 'errorAnalyzingNews',
      desc: '',
      args: [],
    );
  }

  /// `AI Briefing`
  String get aiBriefingSource {
    return Intl.message(
      'AI Briefing',
      name: 'aiBriefingSource',
      desc: '',
      args: [],
    );
  }

  /// `Gemini AI`
  String get geminiAiAuthor {
    return Intl.message(
      'Gemini AI',
      name: 'geminiAiAuthor',
      desc: '',
      args: [],
    );
  }

  /// `NewsAPI`
  String get newsApiSource {
    return Intl.message('NewsAPI', name: 'newsApiSource', desc: '', args: []);
  }

  /// `No Title`
  String get noTitle {
    return Intl.message('No Title', name: 'noTitle', desc: '', args: []);
  }

  /// `GNews Source`
  String get gnewsSource {
    return Intl.message(
      'GNews Source',
      name: 'gnewsSource',
      desc: '',
      args: [],
    );
  }

  /// `Gemini returned an empty response.`
  String get geminiEmptyResponse {
    return Intl.message(
      'Gemini returned an empty response.',
      name: 'geminiEmptyResponse',
      desc: '',
      args: [],
    );
  }

  /// `Gemini API Error: {error}`
  String geminiApiError(Object error) {
    return Intl.message(
      'Gemini API Error: $error',
      name: 'geminiApiError',
      desc: '',
      args: [error],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
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

  /// `Analyzing...`
  String get analyzing {
    return Intl.message('Analyzing...', name: 'analyzing', desc: '', args: []);
  }

  /// `Ready`
  String get briefingReadyShort {
    return Intl.message(
      'Ready',
      name: 'briefingReadyShort',
      desc: '',
      args: [],
    );
  }

  /// `Generate Summary`
  String get generateSummary {
    return Intl.message(
      'Generate Summary',
      name: 'generateSummary',
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
