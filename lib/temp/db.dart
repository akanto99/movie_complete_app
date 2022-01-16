class Movie {
  int id;
  String name;
  String category;
  int releaseYear;
  double rating;
  String description;
  String image;
  double budget;
  double boxOffice;
  String language;
  String country;
  String production;
  int runningTime;
  String director;
  String producer;

  Movie(
      {required this.id,
        required this.name,
        required this.category,
        required this.releaseYear,
        required this.rating,
        required this.description,
        required this.image,
        this.budget = 1215,
        this.boxOffice = 950,
        this.language = "English",
        this.country = 'United States',
        this.production = 'Marvel Studios',
        this.runningTime = 140,
        this.director = 'Joss Whedon',
        this.producer = 'Kevin Feige'});
}
