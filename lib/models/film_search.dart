class FilmSearch {
  final String imdbId;
  final String title;
  final String year;
  final String type;
  final String poster;

  FilmSearch({this.imdbId, this.title, this.year, this.poster, this.type});

  factory FilmSearch.fromJson(Map<String,dynamic> json){
    return FilmSearch(
      title: json["Title"],
      year:json["Year"],
      type:json["Type"],
      imdbId: json["imdbID"],
      poster: json["Poster"]
    );
  }
}