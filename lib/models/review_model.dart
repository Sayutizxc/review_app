class ReviewModel {
  String title;
  String deskripsi;
  double artRating;
  double storyRating;
  String link;

  ReviewModel(
      {this.title,
      this.deskripsi,
      this.artRating,
      this.storyRating,
      this.link});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    this.title = json['title'];
    this.deskripsi = json['deskripsi'];
    this.artRating = json['artRating'];
    this.storyRating = json['storyRating'];
    this.link = json['link'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'deskripsi': deskripsi,
        'artRating': artRating,
        'storyRating': storyRating,
        'link': link
      };
}
