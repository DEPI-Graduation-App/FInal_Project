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
