import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velinno_assestment_task/core/theme/theme_cubit.dart';
import 'package:velinno_assestment_task/features/home/model/top_stories_model.dart';
import 'package:velinno_assestment_task/features/home/view_model/home_screen_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeScreenCubit>().getTopStories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Top Stories",
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, state) {
                return Icon(
                  state == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
                );
              },
            ),
            onPressed: context
                .read<ThemeCubit>()
                .toggleTheme, // 👈 toggle theme
          ),
        ],
      ),
      body: BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.errorMessage.isNotEmpty) {
            return _buildErrorState(state.errorMessage, Theme.of(context));
          } else if (state.topStoriesModel != null) {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.topStoriesModel!.results.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final article = state.topStoriesModel!.results[index];
                return _ArticleCard(article: article);
              },
            );
          } else {
            return _buildEmptyState(Theme.of(context));
          }
        },
      ),
    );
  }

  Widget _buildErrorState(String error, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 48, color: theme.colorScheme.error),
          const SizedBox(height: 12),
          Text(error, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => context.read<HomeScreenCubit>().getTopStories(),
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.article_outlined, size: 48, color: theme.iconTheme.color),
          const SizedBox(height: 12),
          Text("No articles available", style: theme.textTheme.bodyLarge),
        ],
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final Result article;

  const _ArticleCard({required this.article});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        // TODO: Navigate to detail page
      },
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: article.multimedia[0].url,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: theme.dividerColor),
                  errorWidget: (context, url, error) => Container(
                    color: theme.dividerColor,
                    child: Icon(
                      Icons.broken_image,
                      color: theme.iconTheme.color,
                    ),
                  ),
                ),
              ),

              // Gradient overlay (keep for readability)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.surface.withOpacity(0.8),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),

              // Article content
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (article.byline.isNotEmpty)
                      Text(article.byline, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
