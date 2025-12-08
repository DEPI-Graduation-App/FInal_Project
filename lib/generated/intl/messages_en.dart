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

  static String m0(label) => "Briefing: ${label}";

  static String m1(category) => "Category ${category} added to Favorites";

  static String m2(category) => "Category ${category} removed from Favorites";

  static String m3(error) => "Failed to generate summary: ${error}";

  static String m4(category) => "Failed to load news for ${category}";

  static String m5(error) => "Gemini API Error: ${error}";

  static String m6(maxWidth, maxHeight) =>
      "Image dimensions exceed ${maxWidth} x ${maxHeight}. Please choose a smaller image.";

  static String m7(topic) => "${topic} summary is ready";

  static String m8(error) => "Unexpected error: ${error}";

  static String m9(username) => "Username: ${username}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accessForbidden": MessageLookupByLibrary.simpleMessage(
      "Access forbidden. Please check your API key.",
    ),
    "accountCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Account created successfully!",
    ),
    "addCategoriesToSeeThem": MessageLookupByLibrary.simpleMessage(
      "Add categories to see them here",
    ),
    "added": MessageLookupByLibrary.simpleMessage("Added"),
    "aiBriefingSource": MessageLookupByLibrary.simpleMessage("AI Briefing"),
    "aiNewsBriefing": MessageLookupByLibrary.simpleMessage("AI News Briefing"),
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account? ",
    ),
    "authenticationError": MessageLookupByLibrary.simpleMessage(
      "Authentication Error",
    ),
    "badRequest": MessageLookupByLibrary.simpleMessage("Bad request"),
    "briefingReady": MessageLookupByLibrary.simpleMessage(
      "Your briefing is read",
    ),
    "briefingTitle": m0,
    "business": MessageLookupByLibrary.simpleMessage("Business"),
    "cannotOpenArticle": MessageLookupByLibrary.simpleMessage(
      "Cannot open this article",
    ),
    "categoryAddedToFavorites": m1,
    "categoryRemovedFromFavorites": m2,
    "chooseProfilePicture": MessageLookupByLibrary.simpleMessage(
      "Choose profile picture",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirm Password"),
    "create": MessageLookupByLibrary.simpleMessage("create"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage(
      "don\'t have an account? ",
    ),
    "editUsernameHint": MessageLookupByLibrary.simpleMessage("Edit username"),
    "emailAddress": MessageLookupByLibrary.simpleMessage("Email Address"),
    "emailAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Email already registered. Try logging in.",
    ),
    "emailAlreadyRegistered": MessageLookupByLibrary.simpleMessage(
      "Email is already registered or invalid",
    ),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "emailNotFound": MessageLookupByLibrary.simpleMessage("Email not found"),
    "enterEmail": MessageLookupByLibrary.simpleMessage("Enter your email"),
    "enterPassword": MessageLookupByLibrary.simpleMessage(
      "Enter your password",
    ),
    "enterUsername": MessageLookupByLibrary.simpleMessage(
      "Enter your username",
    ),
    "entertainment": MessageLookupByLibrary.simpleMessage("Entertainment"),
    "error": MessageLookupByLibrary.simpleMessage("Error"),
    "errorAnalyzingNews": MessageLookupByLibrary.simpleMessage(
      "An error occurred while analyzing news.",
    ),
    "failedToGenerateSummary": m3,
    "failedToLoadCategories": MessageLookupByLibrary.simpleMessage(
      "Failed to load categories",
    ),
    "failedToLoadNewsFor": m4,
    "favoritesTitle": MessageLookupByLibrary.simpleMessage("Favorites"),
    "geminiAiAuthor": MessageLookupByLibrary.simpleMessage("Gemini AI"),
    "geminiApiError": m5,
    "geminiEmptyResponse": MessageLookupByLibrary.simpleMessage(
      "Gemini returned an empty response.",
    ),
    "general": MessageLookupByLibrary.simpleMessage("General"),
    "gnewsSource": MessageLookupByLibrary.simpleMessage("GNews Source"),
    "health": MessageLookupByLibrary.simpleMessage("Health"),
    "homeTitle": MessageLookupByLibrary.simpleMessage("Home"),
    "imageDimensionsExceed": m6,
    "imageTooLarge": MessageLookupByLibrary.simpleMessage("Image too large"),
    "internalServerError": MessageLookupByLibrary.simpleMessage(
      "Internal server error",
    ),
    "invalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Invalid credentials",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid email",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "loginSuccessful": MessageLookupByLibrary.simpleMessage("Login Successful"),
    "logoutButton": MessageLookupByLibrary.simpleMessage("Log out"),
    "newsApiSource": MessageLookupByLibrary.simpleMessage("NewsAPI"),
    "newsCategories": MessageLookupByLibrary.simpleMessage("News categories"),
    "newsNotifications": MessageLookupByLibrary.simpleMessage(
      "News Notifications",
    ),
    "noCategoriesAvailable": MessageLookupByLibrary.simpleMessage(
      "No categories available",
    ),
    "noDescriptionAvailable": MessageLookupByLibrary.simpleMessage(
      "No description available.",
    ),
    "noFavoritesYet": MessageLookupByLibrary.simpleMessage("No favorites yet"),
    "noInternetConnection": MessageLookupByLibrary.simpleMessage(
      "No internet connection",
    ),
    "noNewsFound": MessageLookupByLibrary.simpleMessage("No news found"),
    "noRecentArticles": MessageLookupByLibrary.simpleMessage(
      "No recent articles found regarding this topic.",
    ),
    "noSimilarNewsFound": MessageLookupByLibrary.simpleMessage(
      "No similar news found",
    ),
    "noSummaryAvailable": MessageLookupByLibrary.simpleMessage(
      "No summary available",
    ),
    "noTitle": MessageLookupByLibrary.simpleMessage("No Title"),
    "notificationsChannelDescription": MessageLookupByLibrary.simpleMessage(
      "Notifications for favorite categories",
    ),
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
    "profileTitle": MessageLookupByLibrary.simpleMessage("Profile"),
    "reEnterPassword": MessageLookupByLibrary.simpleMessage(
      "Re-enter your password",
    ),
    "register": MessageLookupByLibrary.simpleMessage("Register"),
    "removed": MessageLookupByLibrary.simpleMessage("Removed"),
    "requestCancelled": MessageLookupByLibrary.simpleMessage(
      "Request was cancelled",
    ),
    "resourceNotFound": MessageLookupByLibrary.simpleMessage(
      "Resource not found",
    ),
    "science": MessageLookupByLibrary.simpleMessage("Science"),
    "searchNewsHint": MessageLookupByLibrary.simpleMessage("Search news..."),
    "similarNews": MessageLookupByLibrary.simpleMessage("Similar News"),
    "source1": MessageLookupByLibrary.simpleMessage("Source1"),
    "source2": MessageLookupByLibrary.simpleMessage("Source2"),
    "sports": MessageLookupByLibrary.simpleMessage("Sports"),
    "success": MessageLookupByLibrary.simpleMessage("Success"),
    "summaryReady": m7,
    "takeAPhoto": MessageLookupByLibrary.simpleMessage("Take a Photo"),
    "technology": MessageLookupByLibrary.simpleMessage("Technology"),
    "tooManyRequests": MessageLookupByLibrary.simpleMessage(
      "Too many requests. Please try again later.",
    ),
    "trySigningUp": MessageLookupByLibrary.simpleMessage("Try signing up"),
    "unableToReadImage": MessageLookupByLibrary.simpleMessage(
      "Unable to read image. Please choose another picture.",
    ),
    "unauthorizedAccess": MessageLookupByLibrary.simpleMessage(
      "Unauthorized access",
    ),
    "unexpectedError": m8,
    "unknownError": MessageLookupByLibrary.simpleMessage(
      "An unknown error occurred",
    ),
    "updateSaveButton": MessageLookupByLibrary.simpleMessage("Update / Save"),
    "uploadFromGallery": MessageLookupByLibrary.simpleMessage(
      "Upload from Gallery",
    ),
    "userNotLoggedIn": MessageLookupByLibrary.simpleMessage(
      "User not logged in",
    ),
    "username": MessageLookupByLibrary.simpleMessage("Username"),
    "usernameLabel": m9,
    "usernameUpdated": MessageLookupByLibrary.simpleMessage("Username updated"),
    "viewArticle": MessageLookupByLibrary.simpleMessage("View article"),
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
