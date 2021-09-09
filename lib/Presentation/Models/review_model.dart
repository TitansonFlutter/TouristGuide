class Review {
  final int reviewId;
  final String comment;
  final double rate;
  final int userId;
  final int tourId;
  final String date;
  final String name;

  Review(
    this.reviewId,
    this.comment,
    this.rate,
    this.userId,
    this.tourId,
    this.date,
    this.name,
  );

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      json['ReviewId'],
      json['Comment'],
      json['Rate'],
      json["UserId"],
      json["TourId"],
      json["Date"],
      json["Name"],
    );
  }
}
