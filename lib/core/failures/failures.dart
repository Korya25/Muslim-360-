abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure([String? msg]) : super(msg ?? 'حدث خطأ في الخادم، حاول لاحقًا');
}

class NetworkFailure extends Failure {
  NetworkFailure([String? msg]) : super(msg ?? 'لا يوجد اتصال بالإنترنت');
}

class TimeoutFailure extends Failure {
  TimeoutFailure() : super('انتهى وقت الاتصال بالخادم');
}

class UnknownFailure extends Failure {
  UnknownFailure() : super('حدث خطأ غير متوقع');
}
