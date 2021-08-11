import 'dart:async';
import 'dart:convert';

//import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  final respo = await http
      .get("https://dhanushad.pythonanywhere.com/api/keywords/dhanush/1");
  List jos = json.decode(respo.body);
  var lst = jos.map((e) => Movieapi.fromJson(e));
  print(lst);
}

class Movieapi {
  String genres;
  String keywords;
  String poster;
  var unnamed0;
  var budget;
  String casts;
  String contentBased;
  String crewDetails;
  String director;
  String homepage;
  String keywordBased;
  var movieId;
  String originalLanguage;
  String overview;
  String pcompany;
  double popularity;
  var profits;
  var revenue;
  var runtime;
  String tagline;
  String title;
  var voteAverage;
  var voteCount;

  Movieapi(
      {this.genres,
      this.keywords,
      this.poster,
      this.unnamed0,
      this.budget,
      this.casts,
      this.contentBased,
      this.crewDetails,
      this.director,
      this.homepage,
      this.keywordBased,
      this.movieId,
      this.originalLanguage,
      this.overview,
      this.pcompany,
      this.popularity,
      this.profits,
      this.revenue,
      this.runtime,
      this.tagline,
      this.title,
      this.voteAverage,
      this.voteCount});

  Movieapi.fromJson(Map<String, dynamic> json) {
    genres = json['Genres'];
    keywords = json['Keywords'];
    poster = json['Poster'];
    unnamed0 = json['Unnamed: 0'];
    budget = json['budget'];
    casts = json['casts'];
    contentBased = json['content_based'];
    crewDetails = json['crew_details'];
    director = json['director'];
    homepage = json['homepage'];
    keywordBased = json['keyword_based'];
    movieId = json['movie_id'];
    originalLanguage = json['original_language'];
    overview = json['overview'];
    pcompany = json['pcompany'];
    popularity = json['popularity'];
    profits = json['profits'];
    revenue = json['revenue'];
    runtime = json['runtime'];
    tagline = json['tagline'];
    title = json['title'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Genres'] = this.genres;
    data['Keywords'] = this.keywords;
    data['Poster'] = this.poster;
    data['Unnamed: 0'] = this.unnamed0;
    data['budget'] = this.budget;
    data['casts'] = this.casts;
    data['content_based'] = this.contentBased;
    data['crew_details'] = this.crewDetails;
    data['director'] = this.director;
    data['homepage'] = this.homepage;
    data['keyword_based'] = this.keywordBased;
    data['movie_id'] = this.movieId;
    data['original_language'] = this.originalLanguage;
    data['overview'] = this.overview;
    data['pcompany'] = this.pcompany;
    data['popularity'] = this.popularity;
    data['profits'] = this.profits;
    data['revenue'] = this.revenue;
    data['runtime'] = this.runtime;
    data['tagline'] = this.tagline;
    data['title'] = this.title;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    return data;
  }
}
