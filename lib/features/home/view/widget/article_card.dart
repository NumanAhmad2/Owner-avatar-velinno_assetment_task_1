import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velinno_assestment_task/features/details/view/details_screen.dart';
import 'package:velinno_assestment_task/features/home/model/top_stories_model.dart';

class ArticleCard extends StatefulWidget {
  final Result article;
  final int index;

  const ArticleCard({super.key, required this.article, required this.index});

  @override
  State<ArticleCard> createState() => ArticleCardState();
}

class ArticleCardState extends State<ArticleCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: (_) => _hoverController.forward(),
            onTapUp: (_) => _hoverController.reverse(),
            onTapCancel: () => _hoverController.reverse(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(url: widget.article.url),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withValues(alpha: 0.12),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 3,
                      child: CachedNetworkImage(
                        imageUrl: widget.article.multimedia.isNotEmpty
                            ? widget.article.multimedia[0].url
                            : '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.1,
                          ),
                          child: Center(
                            child: CupertinoActivityIndicator(
                              color: theme.colorScheme.primary,
                              radius: 12,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.1,
                          ),
                          child: Icon(
                            Icons.image_not_supported_rounded,
                            color: theme.colorScheme.primary,
                            size: 32,
                          ),
                        ),
                      ),
                    ),

                    // Content section
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.article.title,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  height: 1.3,
                                ),
                              ),
                            ),
                            if (widget.article.byline.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                widget.article.byline,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
