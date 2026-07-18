import 'package:news_app/features/Home/data/models/news_models.dart';

sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  List<Articles> articles;
  HomeSuccess(this.articles);
}

class HomeError extends HomeState {
  String errorMessage;
  HomeError(this.errorMessage);
}
