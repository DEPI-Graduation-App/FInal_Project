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

  static String m0(category) => "تم إضافة الفئة ${category} إلى المفضلة";

  static String m1(category) => "تم إزالة الفئة ${category} من المفضلة";

  static String m2(error) => "فشل في إنشاء الملخص: ${error}";

  static String m3(maxWidth, maxHeight) =>
      "أبعاد الصورة تتجاوز ${maxWidth} x ${maxHeight}. يرجى اختيار صورة أصغر.";

  static String m4(topic) => "ملخص ${topic} جاهز";

  static String m5(error) => "خطأ غير متوقع: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "تم إنشاء الحساب بنجاح!",
    ),
    "added": MessageLookupByLibrary.simpleMessage("تم الإضافة"),
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "لديك حساب بالفعل؟ ",
    ),
    "authenticationError": MessageLookupByLibrary.simpleMessage(
      "خطأ في المصادقة",
    ),
    "briefingReady": MessageLookupByLibrary.simpleMessage("ملخصك جاهز"),
    "categoryAddedToFavorites": m0,
    "categoryRemovedFromFavorites": m1,
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "تأكيد كلمة المرور",
    ),
    "create": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage("ليس لديك حساب؟ "),
    "emailAddress": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
    "emailAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني مسجل بالفعل. حاول تسجيل الدخول.",
    ),
    "emailAlreadyRegistered": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني مسجل بالفعل أو غير صالح",
    ),
    "emailNotFound": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني غير موجود",
    ),
    "enterEmail": MessageLookupByLibrary.simpleMessage("أدخل بريدك الإلكتروني"),
    "enterPassword": MessageLookupByLibrary.simpleMessage("أدخل كلمة المرور"),
    "enterUsername": MessageLookupByLibrary.simpleMessage("أدخل اسم المستخدم"),
    "error": MessageLookupByLibrary.simpleMessage("خطأ"),
    "failedToGenerateSummary": m2,
    "imageDimensionsExceed": m3,
    "imageTooLarge": MessageLookupByLibrary.simpleMessage("الصورة كبيرة جداً"),
    "invalidCredentials": MessageLookupByLibrary.simpleMessage(
      "بيانات الاعتماد غير صالحة",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال بريد إلكتروني صالح",
    ),
    "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "loginSuccessful": MessageLookupByLibrary.simpleMessage(
      "تم تسجيل الدخول بنجاح",
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
    "reEnterPassword": MessageLookupByLibrary.simpleMessage(
      "أعد إدخال كلمة المرور",
    ),
    "register": MessageLookupByLibrary.simpleMessage("تسجيل حساب جديد"),
    "removed": MessageLookupByLibrary.simpleMessage("تم الإزالة"),
    "success": MessageLookupByLibrary.simpleMessage("نجاح"),
    "summaryReady": m4,
    "trySigningUp": MessageLookupByLibrary.simpleMessage("حاول التسجيل"),
    "unableToReadImage": MessageLookupByLibrary.simpleMessage(
      "تعذر قراءة الصورة. يرجى اختيار صورة أخرى.",
    ),
    "unexpectedError": m5,
    "userNotLoggedIn": MessageLookupByLibrary.simpleMessage(
      "المستخدم لم يسجل الدخول",
    ),
    "username": MessageLookupByLibrary.simpleMessage("اسم المستخدم"),
    "usernameUpdated": MessageLookupByLibrary.simpleMessage(
      "تم تحديث اسم المستخدم",
    ),
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
