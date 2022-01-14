import 'dart:convert';

class UserSettings {
  final bool isSkipIntroScreen;
  final int levelId;
  final int themeId;
  final int timeMinutes;

  UserSettings({
    required this.isSkipIntroScreen,
    required this.levelId,
    required this.themeId,
    required this.timeMinutes,
  });

  UserSettings copyWith({
    bool? isSkipIntroScreen,
    int? levelId,
    int? themeId,
    int? timeMinutes,
  }) {
    return UserSettings(
      isSkipIntroScreen: isSkipIntroScreen ?? this.isSkipIntroScreen,
      levelId: levelId ?? this.levelId,
      themeId: themeId ?? this.themeId,
      timeMinutes: timeMinutes ?? this.timeMinutes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isSkipIntroScreen': isSkipIntroScreen,
      'levelId': levelId,
      'themeId': themeId,
      'timeMinutes': timeMinutes,
    };
  }

  factory UserSettings.fromMap(Map<String, dynamic> map) {
    return UserSettings(
      isSkipIntroScreen: map['isSkipIntroScreen'] ?? false,
      levelId: map['levelId']?.toInt() ?? 0,
      themeId: map['themeId']?.toInt() ?? 0,
      timeMinutes: map['timeMinutes']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSettings.fromJson(String source) =>
      UserSettings.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserSettings(isSkipIntroScreen: $isSkipIntroScreen, levelId: $levelId, themeId: $themeId, timeMinutes: $timeMinutes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserSettings &&
        other.isSkipIntroScreen == isSkipIntroScreen &&
        other.levelId == levelId &&
        other.themeId == themeId &&
        other.timeMinutes == timeMinutes;
  }

  @override
  int get hashCode {
    return isSkipIntroScreen.hashCode ^
        levelId.hashCode ^
        themeId.hashCode ^
        timeMinutes.hashCode;
  }
}
