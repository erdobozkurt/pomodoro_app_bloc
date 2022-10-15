class TimeQuoteModel {
  final String quote;
  final String imageName;

  TimeQuoteModel(this.quote, this.imageName);

  String get imageAsset => 'assets/images/$imageName';
}

class TimeQuoteList {
  static final List<TimeQuoteModel> quotes = [
    TimeQuoteModel(
        'Master your minutes to \nmaster your life.', 'ic_time_manage.png'),
    TimeQuoteModel(
        'You can only manage time if you track it right.', 'ic_time_track.png'),
    TimeQuoteModel('Time management is life management.', 'ic_time_life.png'),
  ];
}
