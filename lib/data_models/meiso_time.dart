import 'dart:convert';

class MeisoTime {
  final int timeMinutes;
  final String timeDisplayString;

  MeisoTime({
    required this.timeMinutes,
    required this.timeDisplayString,
  });

  MeisoTime copyWith({
    int? timeMinutes,
    String? timeDisplayString,
  }) {
    return MeisoTime(
      timeMinutes: timeMinutes ?? this.timeMinutes,
      timeDisplayString: timeDisplayString ?? this.timeDisplayString,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timeMinutes': timeMinutes,
      'timeDisplayString': timeDisplayString,
    };
  }

  factory MeisoTime.fromMap(Map<String, dynamic> map) {
    return MeisoTime(
      timeMinutes: map['timeMinutes']?.toInt() ?? 0,
      timeDisplayString: map['timeDisplayString'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MeisoTime.fromJson(String source) =>
      MeisoTime.fromMap(json.decode(source));

  @override
  String toString() =>
      'MeisoTime(timeMinutes: $timeMinutes, timeDisplayString: $timeDisplayString)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MeisoTime &&
        other.timeMinutes == timeMinutes &&
        other.timeDisplayString == timeDisplayString;
  }

  @override
  int get hashCode => timeMinutes.hashCode ^ timeDisplayString.hashCode;
}
