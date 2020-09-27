class ReviewModel {
  String title;
  String deskripsi;
  double artRating;
  double storyRating;
  String link;
  String comic;
  List<dynamic> tag;

  ReviewModel(
      {this.title,
      this.deskripsi,
      this.artRating,
      this.storyRating,
      this.link,
      this.comic,
      this.tag});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    this.title = json['title'];
    this.deskripsi = json['deskripsi'];
    this.artRating = json['artRating'];
    this.storyRating = json['storyRating'];
    this.link = json['link'];
    this.comic = json['comic'];
    this.tag = json['tag'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'deskripsi': deskripsi,
        'artRating': artRating,
        'storyRating': storyRating,
        'link': link,
        'comic': comic,
        'tag': tag
      };
}
