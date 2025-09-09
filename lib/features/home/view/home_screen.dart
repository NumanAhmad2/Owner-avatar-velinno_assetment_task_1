import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velinno_assestment_task/features/home/view/widget/article_list.dart';
import 'package:velinno_assestment_task/features/home/view/widget/error_builder_state.dart';
import 'package:velinno_assestment_task/features/home/view/widget/load_state_widget.dart';
import 'package:velinno_assestment_task/features/home/view/widget/theme_toggle_button.dart';
import 'package:velinno_assestment_task/features/home/view_model/home_screen_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.elasticOut,
          ),
        );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeScreenCubit>().getTopStories();
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<HomeScreenCubit>().getTopStories();
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              elevation: 0,
              backgroundColor: theme.scaffoldBackgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
                title: AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: isDark
                              ? [Colors.white, Colors.white70]
                              : [
                                  theme.colorScheme.primary,
                                  theme.colorScheme.secondary,
                                ],
                        ).createShader(bounds),
                        child: Text(
                          "Top Stories",
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isDark
                          ? [
                              theme.colorScheme.surface,
                              theme.colorScheme.surface.withValues(alpha: 0.8),
                            ]
                          : [
                              theme.colorScheme.primary.withValues(alpha: 0.1),
                              theme.colorScheme.secondary.withValues(
                                alpha: 0.05,
                              ),
                            ],
                    ),
                  ),
                ),
              ),
              actions: [const ThemeToggleButton()],
            ),

            // Content
            SliverToBoxAdapter(
              child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return LoadingStateWidget(theme: theme);
                  } else if (state.errorMessage.isNotEmpty) {
                    return ErrorBuilderState(
                      error: state.errorMessage,
                      theme: theme,
                    );
                  } else if (state.topStoriesModel != null) {
                    return AnimatedBuilder(
                      animation: _slideAnimation,
                      builder: (context, child) {
                        return SlideTransition(
                          position: _slideAnimation,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: const BuildArticlesList(),
                          ),
                        );
                      },
                    );
                  } else {
                    return _buildEmptyState(theme);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.article_rounded,
              size: 48,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "No Stories Available",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Check back later for new articles",
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
