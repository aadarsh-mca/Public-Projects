class AudioModel {
  /// Contains an int [id] of audio file
  int id;

  /// Contains a String [Title] of audio file
  String title;
  
  /// Contains a String containing name of [Singer] of audio file
  String singer;
  
  /// Contains a String containing name of [Lyricist] of audio file
  String lyricist;
  
  /// Contains a String containing name of [Music Label] of audio file
  String musicLabel;
  
  /// Contains a String [Path] of audio file
  String sourcePath;
  
  /// Contains a String [Url] of audio file
  String coverPhotoUrl;

  AudioModel({
    required this.id,
    required this.title,
    required this.singer,
    required this.lyricist,
    required this.musicLabel,
    required this.sourcePath,
    required this.coverPhotoUrl,
  });
}
