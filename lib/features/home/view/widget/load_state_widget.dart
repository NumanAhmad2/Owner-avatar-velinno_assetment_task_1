import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingStateWidget extends StatelessWidget {
  final ThemeData theme;
  final String loadingText;
  const LoadingStateWidget({
    super.key,
    required this.theme,
    this.loadingText = "Loading stories...",
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: CupertinoActivityIndicator(
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              loadingText,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
