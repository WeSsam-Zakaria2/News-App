import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api/api.dart';
import 'package:news_app/core/api/result_api.dart';
import 'package:news_app/features/Home/data/models/news_models.dart';
import 'package:news_app/features/Home/view_model/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  Future<void> intent(HomeIntent intent) async {
    switch (intent) {
      case FetchNewsIntent():
        await _fetchNews(intent.id);
      case FetchSourceIntent():
        await _getSource();
    }
  }

  Future<void> _fetchNews(String id) async {
    emit(HomeLoading());

    var result = await Api.getNews();

    switch (result) {
      case Success<NewsModel?>():
        emit(HomeSuccess(result.data?.articles ?? []));
      case Failure<NewsModel?>():
        emit(HomeError(result.errorMessage));
    }
  }

  Future<void> _getSource() async {}
}

sealed class HomeIntent {}

class FetchNewsIntent extends HomeIntent {
  String id;
  FetchNewsIntent({required this.id});
}

class FetchSourceIntent extends HomeIntent {}
