import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api/api.dart';
import 'package:news_app/core/api/result_api.dart';
import 'package:news_app/features/Home/data/models/news_models.dart';
import 'package:news_app/features/Home/view_model/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  void fetchNews() async {
    emit(HomeLoading());

    var result = await Api.getNews();

    switch (result) {
      case Success<NewsModel?>():
        emit(HomeSuccess(result.data?.articles ?? []));
      case Failure<NewsModel?>():
        emit(HomeError(result.errorMessage));
    }
  }
}
