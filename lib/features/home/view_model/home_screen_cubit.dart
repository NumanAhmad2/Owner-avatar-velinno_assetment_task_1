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
}
