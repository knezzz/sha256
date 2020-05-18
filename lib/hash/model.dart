import 'package:sha256/hash/hash_value.dart';

class ShaMessage {
  ShaMessage._(this.input, this.bytes, this.message, this.foldedMessage, this.paddedMessage, this.messageBlocs,
      this.messageSchedule, this.hashValue);

  factory ShaMessage.empty() => ShaMessage._('', <int>[], <String>[], '', '', <String>[], <int>[], HashValue());

  final String input;

  final List<int> bytes;
  final List<String> message;
  final String foldedMessage;
  final String paddedMessage;
  final List<String> messageBlocs;
  final List<int> messageSchedule;

  final HashValue hashValue;

  ShaMessage copyWith({
    String input,
    List<int> bytes,
    List<String> message,
    String foldedMessage,
    String paddedMessage,
    List<String> messageBlocs,
    List<int> messageSchedule,
    HashValue hashValue,
  }) {
    return ShaMessage._(
      input ?? this.input,
      bytes ?? this.bytes,
      message ?? this.message,
      foldedMessage ?? this.foldedMessage,
      paddedMessage ?? this.paddedMessage,
      messageBlocs ?? this.messageBlocs,
      messageSchedule ?? this.messageSchedule,
      hashValue ?? this.hashValue,
    );
  }
}
