class TimelineModel {
  String startChildText;
  String endChildText;
  String decriptionText;
  String? decriptionImage;
  bool showDescription;
  bool isFirst;
  bool isLast;

  TimelineModel({
    required this.startChildText,
    required this.endChildText,
    required this.decriptionText,
    this.decriptionImage,
    this.showDescription = false,
    this.isFirst = false,
    this.isLast = false,
  });
}
