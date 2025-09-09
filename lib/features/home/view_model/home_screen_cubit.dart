// home_screen_cubit.dart
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:velinno_assestment_task/features/home/model/top_stories_model.dart';
import 'package:velinno_assestment_task/services/api_provider.dart';
import 'package:velinno_assestment_task/services/api_service.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(const HomeScreenState());

  TopStoriesModel? _originalTopStoriesModel;
  bool _hasFetchedData = false;

  Future<void> getTopStories() async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: ''));

      final Either<Failure, Response<dynamic>> response = await ApiProvider()
          .getApi(
            queryParameters: {"api-key": "BE2uWdO8BqsCUAMHk3ZWcDM4wehtYre3"},
            endpoint: '',
          );

      response.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, errorMessage: failure.message));
        },
        (success) {
          final topStoriesModel = TopStoriesModel.fromJson(success.data);
          _originalTopStoriesModel = topStoriesModel;
          _hasFetchedData = true;
          Map<String, List<Result>>? updatedCategories = {};

          for (final article in topStoriesModel.results) {
            updatedCategories.update(
              article.section,
              (existing) => [...existing, article],
              ifAbsent: () => [article],
            );
          }

          log("these are the categories: $updatedCategories");

          emit(
            state.copyWith(
              isLoading: false,
              topStoriesModel: topStoriesModel,
              errorMessage: '',
              newsCategories: updatedCategories,
            ),
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void searchArticles(String query) {
    if (query.isEmpty) {
      emit(
        state.copyWith(
          isLoading: false,
          topStoriesModel: _originalTopStoriesModel,
          errorMessage: '',
        ),
      );
      return;
    }

    final filteredArticles = state.topStoriesModel?.results.where((article) {
      return article.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    emit(
      state.copyWith(
        isLoading: false,
        topStoriesModel: TopStoriesModel(
          results: filteredArticles ?? [],
          status: '',
          copyright: '',
          section: '',
          lastUpdated: DateTime.now(),
          numResults: 4,
        ),
        errorMessage: '',
      ),
    );
  }

  void filterByCategory(String category) {
    if (!_hasFetchedData || _originalTopStoriesModel == null) return;

    if (category == "all") {
      emit(
        state.copyWith(
          isLoading: false,
          topStoriesModel: _originalTopStoriesModel,
          errorMessage: '',
          appliedFilter: '',
        ),
      );
      return;
    }

    final filteredArticles = state.newsCategories[category] ?? [];

    emit(
      state.copyWith(
        isLoading: false,
        appliedFilter: category,
        topStoriesModel: TopStoriesModel(
          results: filteredArticles,
          status: '',
          copyright: '',
          section: '',
          lastUpdated: DateTime.now(),
          numResults: filteredArticles.length,
        ),
        errorMessage: '',
      ),
    );
  }

  void toggleFiltersVisibility() {
    emit(state.copyWith(showFilters: !state.showFilters));
  }
}
