// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(label) => "ملخص: ${label}";

  static String m1(category) => "تم إضافة الفئة ${category} إلى المفضلة";

  static String m2(category) => "تم إزالة الفئة ${category} من المفضلة";

  static String m3(error) => "فشل في إنشاء الملخص: ${error}";

  static String m4(category) => "فشل تحميل الأخبار لـ ${category}";

  static String m5(error) => "خطأ في Gemini API: ${error}";

  static String m6(maxWidth, maxHeight) =>
      "أبعاد الصورة تتجاوز ${maxWidth} x ${maxHeight}. يرجى اختيار صورة أصغر.";

  static String m7(topic) => "ملخص ${topic} جاهز";

  static String m8(error) => "خطأ غير متوقع: ${error}";

  static String m9(username) => "اسم المستخدم: ${username}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accessForbidden": MessageLookupByLibrary.simpleMessage(
      "الدخول ممنوع. يرجى التحقق من مفتاح API.",
    ),
    "accountCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "تم إنشاء الحساب بنجاح!",
    ),
    "addCategoriesToSeeThem": MessageLookupByLibrary.simpleMessage(
      "أضف فئات لرؤيتها هنا",
    ),
    "added": MessageLookupByLibrary.simpleMessage("تم الإضافة"),
    "aiBriefingSource": MessageLookupByLibrary.simpleMessage(
      "ملخص الذكاء الاصطناعي",
    ),
    "aiNewsBriefing": MessageLookupByLibrary.simpleMessage(
      "ملخص أخبار الذكاء الاصطناعي",
    ),
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "لديك حساب بالفعل؟ ",
    ),
    "authenticationError": MessageLookupByLibrary.simpleMessage(
      "خطأ في المصادقة",
    ),
    "badRequest": MessageLookupByLibrary.simpleMessage("طلب غير صالح"),
    "briefingReady": MessageLookupByLibrary.simpleMessage("ملخصك جاهز"),
    "briefingTitle": m0,
    "business": MessageLookupByLibrary.simpleMessage("أعمال"),
    "cannotOpenArticle": MessageLookupByLibrary.simpleMessage(
      "لا يمكن فتح هذا المقال",
    ),
    "categoryAddedToFavorites": m1,
    "categoryRemovedFromFavorites": m2,
    "changeLanguage": MessageLookupByLibrary.simpleMessage("تغيير اللغة"),
    "chooseProfilePicture": MessageLookupByLibrary.simpleMessage(
      "اختر صورة الملف الشخصي",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "تأكيد كلمة المرور",
    ),
    "create": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage("ليس لديك حساب؟ "),
    "editUsernameHint": MessageLookupByLibrary.simpleMessage(
      "تعديل اسم المستخدم",
    ),
    "emailAddress": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
    "emailAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني مسجل بالفعل. حاول تسجيل الدخول.",
    ),
    "emailAlreadyRegistered": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني مسجل بالفعل أو غير صالح",
    ),
    "emailLabel": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
    "emailNotFound": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني غير موجود",
    ),
    "enterEmail": MessageLookupByLibrary.simpleMessage("أدخل بريدك الإلكتروني"),
    "enterPassword": MessageLookupByLibrary.simpleMessage("أدخل كلمة المرور"),
    "enterUsername": MessageLookupByLibrary.simpleMessage("أدخل اسم المستخدم"),
    "entertainment": MessageLookupByLibrary.simpleMessage("ترفيه"),
    "error": MessageLookupByLibrary.simpleMessage("خطأ"),
    "errorAnalyzingNews": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ أثناء تحليل الأخبار.",
    ),
    "failedToGenerateSummary": m3,
    "failedToLoadCategories": MessageLookupByLibrary.simpleMessage(
      "فشل تحميل الفئات",
    ),
    "failedToLoadNewsFor": m4,
    "favoritesTitle": MessageLookupByLibrary.simpleMessage("المفضلة"),
    "geminiAiAuthor": MessageLookupByLibrary.simpleMessage("Gemini AI"),
    "geminiApiError": m5,
    "geminiEmptyResponse": MessageLookupByLibrary.simpleMessage(
      "أعاد Gemini استجابة فارغة.",
    ),
    "general": MessageLookupByLibrary.simpleMessage("عام"),
    "gnewsSource": MessageLookupByLibrary.simpleMessage("مصدر GNews"),
    "health": MessageLookupByLibrary.simpleMessage("صحة"),
    "homeTitle": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "imageDimensionsExceed": m6,
    "imageTooLarge": MessageLookupByLibrary.simpleMessage("الصورة كبيرة جداً"),
    "internalServerError": MessageLookupByLibrary.simpleMessage(
      "خطأ داخلي في الخادم",
    ),
    "invalidCredentials": MessageLookupByLibrary.simpleMessage(
      "بيانات الاعتماد غير صالحة",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال بريد إلكتروني صالح",
    ),
    "language": MessageLookupByLibrary.simpleMessage("اللغة"),
    "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "loginSuccessful": MessageLookupByLibrary.simpleMessage(
      "تم تسجيل الدخول بنجاح",
    ),
    "logoutButton": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "newsApiSource": MessageLookupByLibrary.simpleMessage("NewsAPI"),
    "newsCategories": MessageLookupByLibrary.simpleMessage("فئات الأخبار"),
    "newsNotifications": MessageLookupByLibrary.simpleMessage(
      "إشعارات الأخبار",
    ),
    "noCategoriesAvailable": MessageLookupByLibrary.simpleMessage(
      "لا توجد فئات متاحة",
    ),
    "noDescriptionAvailable": MessageLookupByLibrary.simpleMessage(
      "لا يوجد وصف متاح.",
    ),
    "noFavoritesYet": MessageLookupByLibrary.simpleMessage("لا توجد مفضلة بعد"),
    "noInternetConnection": MessageLookupByLibrary.simpleMessage(
      "لا يوجد اتصال بالإنترنت",
    ),
    "noNewsFound": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على أخبار",
    ),
    "noRecentArticles": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على مقالات حديثة حول هذا الموضوع.",
    ),
    "noSimilarNewsFound": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على أخبار مشابهة",
    ),
    "noSummaryAvailable": MessageLookupByLibrary.simpleMessage(
      "لا يوجد ملخص متاح",
    ),
    "noTitle": MessageLookupByLibrary.simpleMessage("بدون عنوان"),
    "notificationsChannelDescription": MessageLookupByLibrary.simpleMessage(
      "إشعارات للفئات المفضلة",
    ),
    "password": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
    "passwordLengthError": MessageLookupByLibrary.simpleMessage(
      "يجب أن تكون كلمة المرور 6 أحرف على الأقل",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "كلمات المرور غير متطابقة",
    ),
    "pleaseFillAllFields": MessageLookupByLibrary.simpleMessage(
      "يرجى ملء جميع الحقول",
    ),
    "pleaseTryAgain": MessageLookupByLibrary.simpleMessage("حاول مرة أخرى"),
    "profileTitle": MessageLookupByLibrary.simpleMessage("الملف الشخصي"),
    "reEnterPassword": MessageLookupByLibrary.simpleMessage(
      "أعد إدخال كلمة المرور",
    ),
    "register": MessageLookupByLibrary.simpleMessage("تسجيل حساب جديد"),
    "removed": MessageLookupByLibrary.simpleMessage("تم الإزالة"),
    "requestCancelled": MessageLookupByLibrary.simpleMessage("تم إلغاء الطلب"),
    "resourceNotFound": MessageLookupByLibrary.simpleMessage(
      "المورد غير موجود",
    ),
    "science": MessageLookupByLibrary.simpleMessage("علوم"),
    "searchNewsHint": MessageLookupByLibrary.simpleMessage("بحث في الأخبار..."),
    "similarNews": MessageLookupByLibrary.simpleMessage("أخبار مشابهة"),
    "source1": MessageLookupByLibrary.simpleMessage("المصدر 1"),
    "source2": MessageLookupByLibrary.simpleMessage("المصدر 2"),
    "sports": MessageLookupByLibrary.simpleMessage("رياضة"),
    "success": MessageLookupByLibrary.simpleMessage("نجاح"),
    "summaryReady": m7,
    "takeAPhoto": MessageLookupByLibrary.simpleMessage("التقاط صورة"),
    "technology": MessageLookupByLibrary.simpleMessage("تكنولوجيا"),
    "tooManyRequests": MessageLookupByLibrary.simpleMessage(
      "طلبات كثيرة جداً. يرجى المحاولة لاحقاً.",
    ),
    "trySigningUp": MessageLookupByLibrary.simpleMessage("حاول التسجيل"),
    "unableToReadImage": MessageLookupByLibrary.simpleMessage(
      "تعذر قراءة الصورة. يرجى اختيار صورة أخرى.",
    ),
    "unauthorizedAccess": MessageLookupByLibrary.simpleMessage(
      "دخول غير مصرح به",
    ),
    "unexpectedError": m8,
    "unknownError": MessageLookupByLibrary.simpleMessage("حدث خطأ غير معروف"),
    "updateSaveButton": MessageLookupByLibrary.simpleMessage("تحديث / حفظ"),
    "uploadFromGallery": MessageLookupByLibrary.simpleMessage(
      "تحميل من المعرض",
    ),
    "userNotLoggedIn": MessageLookupByLibrary.simpleMessage(
      "المستخدم لم يسجل الدخول",
    ),
    "username": MessageLookupByLibrary.simpleMessage("اسم المستخدم"),
    "usernameLabel": m9,
    "usernameUpdated": MessageLookupByLibrary.simpleMessage(
      "تم تحديث اسم المستخدم",
    ),
    "viewArticle": MessageLookupByLibrary.simpleMessage("عرض المقال"),
    "weakPassword": MessageLookupByLibrary.simpleMessage(
      "كلمة المرور ضعيفة. جرب كلمة مرور أقوى.",
    ),
    "welcomeToApp": MessageLookupByLibrary.simpleMessage("مرحبا بك في تطبيقنا"),
    "wrongPassword": MessageLookupByLibrary.simpleMessage("كلمة المرور خاطئة"),
    "youDidntUpdateNothing": MessageLookupByLibrary.simpleMessage(
      "لم تقم بتحديث أي شيء",
    ),
  };
}
