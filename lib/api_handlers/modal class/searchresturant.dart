class Restaurant {
  final String id;
  final String name;
  final String url;
  final String address;
  //final Location location;
  final String averageCostForTwo;
  final String priceRange;
  final String currency;
  final String thumb;
  final String featuredImage;
  final String photosUrl;
  final String menuUrl;
  final String eventsUrl;
  //final UserRating userRating;
  final String hasOnlineDelivery;
  final String isDeliveringNow;
  final String hasTableBooking;
  final String deeplink;
  final String cuisines;
  final String allReviewsCount;
  final String photoCount;
  final String phoneNumbers;
  final String localityVerbose;
  final String thumnail;
  //final List<Photo> photos;
  //final List<AllReview> allReviews;

  Restaurant._({
    this.thumnail,
    this.localityVerbose,
    this.address,
    this.id,
    this.name,
    this.url,
    //this.location,
    this.averageCostForTwo,
    this.priceRange,
    this.currency,
    this.thumb,
    this.featuredImage,
    this.photosUrl,
    this.menuUrl,
    this.eventsUrl,
    //this.userRating,
    this.hasOnlineDelivery,
    this.isDeliveringNow,
    this.hasTableBooking,
    this.deeplink,
    this.cuisines,
    this.allReviewsCount,
    this.photoCount,
    this.phoneNumbers,
    // this.photos,
    // this.allReviews,
  });

  factory Restaurant(Map json) => Restaurant._(
        id: json['restaurant']['id'],
        name: json['restaurant']["name"],
        address: json['restaurant']['location']['address'],
        thumnail:
            json['restaurant']['featured_image'] ?? json['restaurant']['thumb'],
        localityVerbose: json['restaurant']['location']['locality_verbose'],
        cuisines: json['restaurant']['cuisines'],
      );
}
