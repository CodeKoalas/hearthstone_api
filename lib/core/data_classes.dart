import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_classes.freezed.dart';

class Void {
  const Void._();
}

const kVoid = Void._();

@freezed
class ActionResult<E, T> with _$ActionResult<E, T> {
  const factory ActionResult.failure(E exception, StackTrace trace) = ActionResultFailure<E, T>;
  const factory ActionResult.success(T data) = ActionResultSuccess<E, T>;
}
