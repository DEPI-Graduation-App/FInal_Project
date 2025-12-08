// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(category) => "Category ${category} added to Favorites";

  static String m1(category) => "Category ${category} removed from Favorites";

  static String m2(error) => "Failed to generate summary: ${error}";

  static String m3(maxWidth, maxHeight) =>
      "Image dimensions exceed ${maxWidth} x ${maxHeight}. Please choose a smaller image.";

  static String m4(topic) => "${topic} summary is ready";

  static String m5(error) => "Unexpected error: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Account created successfully!",
    ),
    "added": MessageLookupByLibrary.simpleMessage("Added"),
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account? ",
    ),
    "authenticationError": MessageLookupByLibrary.simpleMessage(
      "Authentication Error",
    ),
    "briefingReady": MessageLookupByLibrary.simpleMessage(
      "Your briefing is read",
    ),
    "categoryAddedToFavorites": m0,
    "categoryRemovedFromFavorites": m1,
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirm Password"),
    "create": MessageLookupByLibrary.simpleMessage("create"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage(
      "don\'t have an account? ",
    ),
    "emailAddress": MessageLookupByLibrary.simpleMessage("Email Address"),
    "emailAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Email already registered. Try logging in.",
    ),
    "emailAlreadyRegistered": MessageLookupByLibrary.simpleMessage(
      "Email is already registered or invalid",
    ),
    "emailNotFound": MessageLookupByLibrary.simpleMessage("Email not found"),
    "enterEmail": MessageLookupByLibrary.simpleMessage("Enter your email"),
    "enterPassword": MessageLookupByLibrary.simpleMessage(
      "Enter your password",
    ),
    "enterUsername": MessageLookupByLibrary.simpleMessage(
      "Enter your username",
    ),
    "error": MessageLookupByLibrary.simpleMessage("Error"),
    "failedToGenerateSummary": m2,
    "imageDimensionsExceed": m3,
    "imageTooLarge": MessageLookupByLibrary.simpleMessage("Image too large"),
    "invalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Invalid credentials",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid email",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "loginSuccessful": MessageLookupByLibrary.simpleMessage("Login Successful"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordLengthError": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 6 characters",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "pleaseFillAllFields": MessageLookupByLibrary.simpleMessage(
      "Please fill all fields",
    ),
    "pleaseTryAgain": MessageLookupByLibrary.simpleMessage("Please try again"),
    "reEnterPassword": MessageLookupByLibrary.simpleMessage(
      "Re-enter your password",
    ),
    "register": MessageLookupByLibrary.simpleMessage("Register"),
    "removed": MessageLookupByLibrary.simpleMessage("Removed"),
    "success": MessageLookupByLibrary.simpleMessage("Success"),
    "summaryReady": m4,
    "trySigningUp": MessageLookupByLibrary.simpleMessage("Try signing up"),
    "unableToReadImage": MessageLookupByLibrary.simpleMessage(
      "Unable to read image. Please choose another picture.",
    ),
    "unexpectedError": m5,
    "userNotLoggedIn": MessageLookupByLibrary.simpleMessage(
      "User not logged in",
    ),
    "username": MessageLookupByLibrary.simpleMessage("Username"),
    "usernameUpdated": MessageLookupByLibrary.simpleMessage("Username updated"),
    "weakPassword": MessageLookupByLibrary.simpleMessage(
      "Weak password. Try a stronger password.",
    ),
    "welcomeToApp": MessageLookupByLibrary.simpleMessage("welcome to our app"),
    "wrongPassword": MessageLookupByLibrary.simpleMessage("Wrong password"),
    "youDidntUpdateNothing": MessageLookupByLibrary.simpleMessage(
      "You didn\'t update nothing",
    ),
  };
}
