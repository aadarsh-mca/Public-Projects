import 'dart:collection';
import 'package:ram_mandir_history_project/Model/timeline_model.dart';

class TimelineData {

  /// [Return] the length of Ram Mandir History timeline
  static int get getTimelineListLength => _timelineDataList.length;

  /// [Return] a [String] containing complete path of Image Asset  
  static String _createImageUrl(String imgName) {
    return 'assets/images/$imgName';
  }

  /// [Return] an unmodifiable [List] view of [TimelineModel] data
  static UnmodifiableListView<TimelineModel> get getTimelineData {
    return UnmodifiableListView(_timelineDataList);
  }

  /// List containing all the Ram Mandir History timeline data
  static final List<TimelineModel> _timelineDataList = [
    TimelineModel(
      year: '1528',
      descriptionHeadingText: 'Temple Demolished',
      decriptionText:
          'A mosque was built on the site by Mughal emperor Babar which Hindus allege to be the birth place of Lord Ram and where a temple earlier existed.',
      decriptionImage: _createImageUrl('temple_demolished.jpeg'),
      isFirst: true,
    ),
    TimelineModel(
      year: '1853-1949',
      descriptionHeadingText: 'Dark Period',
      decriptionText:
          'Communal riots occurred around the site where the mosque was constructed in 1853. Subsequently, in 1859, the British administration erected a fence around the disputed area, allowing Muslims to worship inside the mosque and granting Hindus permission to worship near the courtyard.',
      decriptionImage: _createImageUrl('dark_period.webp'),
    ),
    TimelineModel(
      year: '1949',
      descriptionHeadingText: 'Idols found in Mosque',
      decriptionText:
          'The actual dispute over Ayodhya Ram Janmabhoomi began on September 23, 1949, when idols of Lord Rama were found inside the mosque. Hindus claimed that Lord Rama had manifested himself there. The Uttar Pradesh government ordered the immediate removal of the idols, but the District Magistrate K.K. Nayar expressed his inability to implement the order due to the fear of hurting religious sentiments and inciting violence.',
      decriptionImage: _createImageUrl('lord_found_inside_mosque.webp'),
    ),
    TimelineModel(
        year: '1984',
        descriptionHeadingText: 'Permission to Worship',
        decriptionText:
            'On February 1, 1986, based on a petition by Umesh Chandra Pandey, a Faizabad district judge, K.M. Pandey granted permission for Hindus to worship and ordered the removal of the locks from the structure.'),
    TimelineModel(
      year: '1992',
      descriptionHeadingText: 'Disputed Structure Demolished',
      decriptionText:
          'A historic event occurred on December 6, 1992, when thousands of activists, including those from the Vishwa Hindu Parishad (VHP) and Shiv Sena, demolished the disputed structure. This led to nationwide communal riots and the loss of thousands of lives.',
      decriptionImage: _createImageUrl('disputed_structure_demolished.jpg'),
    ),
    TimelineModel(
        year: '2010',
        descriptionHeadingText: 'Division',
        decriptionText:
            'The Allahabad High Court divided the disputed land into three equal parts among the Sunni Waqf Board, Ram Lalla Virajman, and the Nirmohi Akhara.'),
    TimelineModel(
      year: '2019',
      descriptionHeadingText: 'Supreme Court Verdict',
      decriptionText:
          'The almost 70-year long dispute came to an end. The five-judge bench ordered setting up of a trust that paved the way for construction of a temple at Ayodhya. It also ordered allotting 5 acres to Muslims in Ayodhya for building a mosque.',
      decriptionImage: _createImageUrl('court_verdict.jpeg'),
    ),
    TimelineModel(
      year: '2020',
      descriptionHeadingText: 'BhoomiPoojan',
      decriptionText:
          'Prime Minister Narendra Modi laid the foundation stone for a Ram temple in Ayodhya, marking a historic accomplishment for his party. He had siad that a grand temple would be constructed for RAM LALLA, the infant Ram, who had been living in a tent for years.',
      decriptionImage: _createImageUrl('bhumi_pujan.webp'),
    ),
    TimelineModel(
      year: '2024',
      descriptionHeadingText: 'Consecration',
      decriptionText:
          'The new Ram Lalla idol was consecrated at the Ayodhya temple, an event watched by lakhs of people on television at their homes and in temples across the country. PM Modi took part in the pran pratishtha rituals in the presence of Uttar Pradesh Governor Anandiben Patel, Uttar Pradesh Chief Minister Yogi Adityanath and RSS chief Mohan Bhagwat',
      decriptionImage: _createImageUrl('consecration.webp'),
      isLast: true,
    ),
  ];
}
