import 'package:news_depi_final_project/generated/l10n.dart';

/// Base class for all API-related exceptions.
abstract class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  @override
  String toString() {
    final code = statusCode != null ? ' (HTTP $statusCode)' : '';
    return '[$runtimeType] $message$code';
  }
}

/// Thrown for server-side errors (HTTP 5xx).
class ServerException extends ApiException {
  ServerException({String? message, super.statusCode = 500})
    : super(message: message ?? S.current.internalServerError);
}

/// Thrown when a resource is not found (HTTP 404).
class NotFoundException extends ApiException {
  NotFoundException({String? message, super.statusCode = 404})
    : super(message: message ?? S.current.resourceNotFound);
}

/// Thrown for bad requests from the client (HTTP 400).
class BadRequestException extends ApiException {
  BadRequestException({String? message, super.statusCode = 400})
    : super(message: message ?? S.current.badRequest);
}

/// Thrown for unauthorized access (HTTP 401).
class UnauthorizedException extends ApiException {
  UnauthorizedException({String? message, super.statusCode = 401})
    : super(message: message ?? S.current.unauthorizedAccess);
}

/// Thrown when access is forbidden (HTTP 403).
class ForbiddenException extends ApiException {
  ForbiddenException({String? message, super.statusCode = 403})
    : super(message: message ?? S.current.accessForbidden);
}

/// Thrown when the API rate limit is exceeded (HTTP 429).
class RateLimitException extends ApiException {
  final Duration? retryAfter;

  RateLimitException({String? message, super.statusCode = 429, this.retryAfter})
    : super(message: message ?? S.current.tooManyRequests);
}

/// Thrown for network connectivity issues or timeouts.
class NetworkException extends ApiException {
  NetworkException({String? message})
    : super(message: message ?? S.current.noInternetConnection);
}

/// Thrown when a request is actively cancelled.
class RequestCancelledException extends ApiException {
  RequestCancelledException({String? message})
    : super(message: message ?? S.current.requestCancelled);
}

/// Thrown for any other unknown error.
class UnknownException extends ApiException {
  UnknownException({String? message})
    : super(message: message ?? S.current.unknownError);
}
