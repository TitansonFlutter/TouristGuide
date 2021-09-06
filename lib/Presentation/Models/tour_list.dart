class Tour {
  final int tourId;
  final String tourName;
  final String tourImage;
  final String country;
  final String region;
  final String city;
  final String whatToInclude;
  final String whatToExclude;
  final String tourDescription;
  final String whatToBring;
  final String itinerary;
  final String duration;
  final String startingDate;
  final String price;
  final bool updated;

  Tour(
      this.tourId,
      this.tourName,
      this.tourImage,
      this.country,
      this.region,
      this.city,
      this.whatToInclude,
      this.whatToExclude,
      this.tourDescription,
      this.whatToBring,
      this.itinerary,
      this.duration,
      this.startingDate,
      this.price,
      this.updated);

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      json['TourId'],
      json['TourName'],
      json['TourImage'],
      json["Country"],
      json["Region"],
      json['City'],
      json['WhatToInclude'],
      json['WhatToExclude'],
      json['TourDescription'],
      json['WhatToBring'],
      json['Itinerary'],
      json['Duration'],
      json['StartingDate'],
      json['Price'],
      json['Updated'],
    );
  }
}
