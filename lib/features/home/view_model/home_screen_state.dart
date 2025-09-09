part of 'home_screen_cubit.dart';

class HomeScreenState extends Equatable {
  final bool isLoading;
  final TopStoriesModel? topStoriesModel;
  final String errorMessage;
  final Map<String, List<Result>> newsCategories;

  const HomeScreenState({
    this.topStoriesModel,
    this.isLoading = false,
    this.errorMessage = '',
    this.newsCategories = const {},
  });

  HomeScreenState copyWith({
    bool? isLoading,
    TopStoriesModel? topStoriesModel,
    String? errorMessage,
    Map<String, List<Result>>? newsCategories,
  }) {
    return HomeScreenState(
      isLoading: isLoading ?? this.isLoading,
      topStoriesModel: topStoriesModel ?? this.topStoriesModel,
      errorMessage: errorMessage ?? this.errorMessage,
      newsCategories: newsCategories ?? this.newsCategories,
    );
  }

  @override
  List<Object> get props => [
    isLoading,
    ?topStoriesModel,
    errorMessage,
    newsCategories,
  ];
}
