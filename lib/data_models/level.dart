import 'dart:convert';

const LEVEL_ID_EASY = 0;
const LEVEL_ID_NORMAL = 1;
const LEVEL_ID_MID = 2;
const LEVEL_ID_HIGH = 3;

class Level {
  final int levelId;
  final String levelName;
  final String explanation;
  final String bellPath;
  final int totalInterval;
  final int inhaleInterval;
  final int holdInterval;
  final int exhaleInterval;

  Level({
    required this.levelId,
    required this.levelName,
    required this.explanation,
    required this.bellPath,
    required this.totalInterval,
    required this.inhaleInterval,
    required this.holdInterval,
    required this.exhaleInterval,
  });

  Level copyWith({
    int? levelId,
    String? levelName,
    String? explanation,
    String? bellPath,
    int? totalInterval,
    int? inhaleInterval,
    int? holdInterval,
    int? exhaleInterval,
  }) {
    return Level(
      levelId: levelId ?? this.levelId,
      levelName: levelName ?? this.levelName,
      explanation: explanation ?? this.explanation,
      bellPath: bellPath ?? this.bellPath,
      totalInterval: totalInterval ?? this.totalInterval,
      inhaleInterval: inhaleInterval ?? this.inhaleInterval,
      holdInterval: holdInterval ?? this.holdInterval,
      exhaleInterval: exhaleInterval ?? this.exhaleInterval,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'levelId': levelId,
      'levelName': levelName,
      'explanation': explanation,
      'bellPath': bellPath,
      'totalInterval': totalInterval,
      'inhaleInterval': inhaleInterval,
      'holdInterval': holdInterval,
      'exhaleInterval': exhaleInterval,
    };
  }

  factory Level.fromMap(Map<String, dynamic> map) {
    return Level(
      levelId: map['levelId']?.toInt() ?? 0,
      levelName: map['levelName'] ?? '',
      explanation: map['explanation'] ?? '',
      bellPath: map['bellPath'] ?? '',
      totalInterval: map['totalInterval']?.toInt() ?? 0,
      inhaleInterval: map['inhaleInterval']?.toInt() ?? 0,
      holdInterval: map['holdInterval']?.toInt() ?? 0,
      exhaleInterval: map['exhaleInterval']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Level.fromJson(String source) => Level.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Level(levelId: $levelId, levelName: $levelName, explanation: $explanation, bellPath: $bellPath, totalInterval: $totalInterval, inhaleInterval: $inhaleInterval, holdInterval: $holdInterval, exhaleInterval: $exhaleInterval)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Level &&
        other.levelId == levelId &&
        other.levelName == levelName &&
        other.explanation == explanation &&
        other.bellPath == bellPath &&
        other.totalInterval == totalInterval &&
        other.inhaleInterval == inhaleInterval &&
        other.holdInterval == holdInterval &&
        other.exhaleInterval == exhaleInterval;
  }

  @override
  int get hashCode {
    return levelId.hashCode ^
        levelName.hashCode ^
        explanation.hashCode ^
        bellPath.hashCode ^
        totalInterval.hashCode ^
        inhaleInterval.hashCode ^
        holdInterval.hashCode ^
        exhaleInterval.hashCode;
  }
}
