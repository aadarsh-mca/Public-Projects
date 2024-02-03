class TimelineModel {
  String startChildText;
  String endChildText;
  String decriptionText;
  String? decriptionImage;
  bool showDescription;

  TimelineModel({
    required this.startChildText,
    required this.endChildText,
    required this.decriptionText,
    this.showDescription = false,
  });
}
