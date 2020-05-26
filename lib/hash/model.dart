import 'package:sha256/hash/hash_value.dart';

class ShaMessage {
  ShaMessage._(this.input, this.foldedMessage, this.paddedMessage, this.messageBlocs, this.messageSchedule,
      this.tempWord1, this.tempWord2, this.hashValue);

  factory ShaMessage.empty() => ShaMessage._('', '', '', <String>[], <int>[], <int>[], <int>[], HashValue());

  final String input;
  final String foldedMessage;
  final String paddedMessage;
  final List<String> messageBlocs;
  final List<int> messageSchedule;

  final List<int> tempWord1;
  final List<int> tempWord2;

  final HashValue hashValue;

  ShaMessage copyWith({
    String input,
    String foldedMessage,
    String paddedMessage,
    List<String> messageBlocs,
    List<int> messageSchedule,
    List<int> tempWord1,
    List<int> tempWord2,
    HashValue hashValue,
  }) {
    return ShaMessage._(
      input ?? this.input,
      foldedMessage ?? this.foldedMessage,
      paddedMessage ?? this.paddedMessage,
      messageBlocs ?? this.messageBlocs,
      messageSchedule ?? this.messageSchedule,
      tempWord1 ?? this.tempWord1,
      tempWord2 ?? this.tempWord2,
      hashValue ?? this.hashValue,
    );
  }
}
