import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velinno_assestment_task/features/home/view/widget/article_card.dart';
import 'package:velinno_assestment_task/features/home/view/widget/featured_article_card.dart';
import 'package:velinno_assestment_task/features/home/view/widget/filter_button.dart';
import 'package:velinno_assestment_task/features/home/view/widget/search_bar.dart';
import 'package:velinno_assestment_task/features/home/view_model/home_screen_cubit.dart';

class BuildArticlesList extends StatelessWidget {
  const BuildArticlesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const SearchBarWidget(), const FilterButton()],
              ),
              const SizedBox(height: 24),
              context.select<HomeScreenCubit, bool>(
                    (cubit) => cubit.state.showFilters,
                  )
                  ? const FiltersList()
                  : const SizedBox.shrink(),
              if (state.topStoriesModel?.results.isNotEmpty ?? false) ...[
                FeaturedArticleCard(article: state.topStoriesModel!.results[0]),
                const SizedBox(height: 24),
              ],

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: state.topStoriesModel!.results.length - 1,
                itemBuilder: (context, index) {
                  return ArticleCard(
                    article: state.topStoriesModel!.results[index + 1],
                    index: index,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
