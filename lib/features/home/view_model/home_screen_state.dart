part of 'home_screen_cubit.dart';

class HomeScreenState extends Equatable {
  final bool isLoading;
  final TopStoriesModel? topStoriesModel;
  final String errorMessage;
  final String appliedFilter;
  final Map<String, List<Result>> newsCategories;
  final bool showFilters;

  const HomeScreenState({
    this.topStoriesModel,
    this.isLoading = false,
    this.errorMessage = '',
    this.newsCategories = const {},
    this.appliedFilter = '',
    this.showFilters = false,
  });

  HomeScreenState copyWith({
    bool? isLoading,
    TopStoriesModel? topStoriesModel,
    String? errorMessage,
    Map<String, List<Result>>? newsCategories,
    String? appliedFilter,
    bool? showFilters,
  }) {
    return HomeScreenState(
      isLoading: isLoading ?? this.isLoading,
      topStoriesModel: topStoriesModel ?? this.topStoriesModel,
      errorMessage: errorMessage ?? this.errorMessage,
      newsCategories: newsCategories ?? this.newsCategories,
      appliedFilter: appliedFilter ?? this.appliedFilter,
      showFilters: showFilters ?? this.showFilters,
    );
  }

  @override
  List<Object> get props => [
    isLoading,
    ?topStoriesModel,
    errorMessage,
    newsCategories,
    appliedFilter,
    showFilters,
  ];
}
