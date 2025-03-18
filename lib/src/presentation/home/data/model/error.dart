import 'package:freezed_annotation/freezed_annotation.dart';
part 'error.freezed.dart';

@freezed
class MainHomeStateError with _$MainHomeStateError {
  const factory MainHomeStateError({
    required String message,
    required String title,
  }) = _MainHomeStateError;
}
