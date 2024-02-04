class TimelineModel {
  /// Contains a String [year] of event in Ram Mandir Timeline
  String year;
  
  /// Contains a String [Decription Heading] of event in Ram Mandir Timeline
  String descriptionHeadingText;
  
  /// Contains a String [Decription Text] of event in Ram Mandir Timeline
  String decriptionText;
  
  /// Contains a String [Decription Image] of event in Ram Mandir Timeline
  String? decriptionImage;
  
  /// Contains a bool [Show Description] to store the state of Descrition Visibility
  bool showDescription;
  
  /// Contains a bool [isFirst] to store the state of First element [TimelineTile]
  bool isFirst;
  
  /// Contains a bool [isFirst] to store the state of Last element [TimelineTile]
  bool isLast;

  TimelineModel({
    required this.year,
    required this.descriptionHeadingText,
    required this.decriptionText,
    this.decriptionImage,
    this.showDescription = false,
    this.isFirst = false,
    this.isLast = false,
  });
}
