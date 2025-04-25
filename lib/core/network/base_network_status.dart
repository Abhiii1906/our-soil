class ApiResult<T> {
  final ApiStatus status;
  final T response;

  ApiResult({required this.status, required this.response});

  T get responseValue => response;
  ApiStatus get statusValue => status;
}

enum ApiStatus {
  success,
  noContent,
  failed,
  forbidden,
  unAuthorized,
  badRequest,
  resourceNotFound,
  mediaNotSupported,
}

class ApiStatusCode {
  static const int SUCCESS = 200;
  static const int NO_CONTENT = 204;
  static const int FAILED = 400;
  static const int FORBIDDEN = 403;
  static const int UNAUTHORIZED = 401;
  static const int BAD_REQUEST = 400;
  static const int RESOURCE_NOT_FOUND = 404;
  static const int MEDIA_NOT_SUPPORTED = 415;
}