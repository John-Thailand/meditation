import 'dart:convert';

const int THEME_ID_SILENCE = 0;
const int THEME_ID_CAVE = 1;
const int THEME_ID_SPRING = 2;
const int THEME_ID_SUMMER = 3;
const int THEME_ID_AUTUMN = 4;
const int THEME_ID_STREAM = 5;
const int THEME_ID_WIND_BELLS = 6;
const int THEME_ID_BONFIRE = 7;

class MeisoTheme {
  final int themeId;
  final String themeName;
  final String imagePath;
  final String? soundPath;

  MeisoTheme({
    required this.themeId,
    required this.themeName,
    required this.imagePath,
    this.soundPath,
  });

  MeisoTheme copyWith({
    int? themeId,
    String? themeName,
    String? imagePath,
    String? soundPath,
  }) {
    return MeisoTheme(
      themeId: themeId ?? this.themeId,
      themeName: themeName ?? this.themeName,
      imagePath: imagePath ?? this.imagePath,
      soundPath: soundPath ?? this.soundPath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'themeId': themeId,
      'themeName': themeName,
      'imagePath': imagePath,
      'soundPath': soundPath,
    };
  }

  factory MeisoTheme.fromMap(Map<String, dynamic> map) {
    return MeisoTheme(
      themeId: map['themeId']?.toInt() ?? 0,
      themeName: map['themeName'] ?? '',
      imagePath: map['imagePath'] ?? '',
      soundPath: map['soundPath'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MeisoTheme.fromJson(String source) =>
      MeisoTheme.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MeisoTheme(themeId: $themeId, themeName: $themeName, imagePath: $imagePath, soundPath: $soundPath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MeisoTheme &&
        other.themeId == themeId &&
        other.themeName == themeName &&
        other.imagePath == imagePath &&
        other.soundPath == soundPath;
  }

  @override
  int get hashCode {
    return themeId.hashCode ^
        themeName.hashCode ^
        imagePath.hashCode ^
        soundPath.hashCode;
  }
}
