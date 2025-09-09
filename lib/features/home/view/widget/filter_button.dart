import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velinno_assestment_task/features/home/view_model/home_screen_cubit.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        return Badge(
          smallSize: 16,
          largeSize: 16,
          isLabelVisible:
              state.appliedFilter.isNotEmpty && state.appliedFilter != 'all',
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {
                context.read<HomeScreenCubit>().toggleFiltersVisibility();
              },
              icon: Icon(
                Icons.filter_alt_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}

class FiltersList extends StatelessWidget {
  const FiltersList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: state.newsCategories.length,
            itemBuilder: (context, index) {
              String itemKey = state.newsCategories.keys.elementAt(index);
              return Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 16, right: 12),
                decoration: BoxDecoration(
                  color: state.appliedFilter == itemKey
                      ? Theme.of(context).primaryColor.withValues(alpha: 0.8)
                      : Theme.of(
                          context,
                        ).colorScheme.surface.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).shadowColor.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      log('Filter by: ${index == 0 ? 'all' : itemKey}');
                      log('Current State Filter: ${state.appliedFilter}');
                      context.read<HomeScreenCubit>().filterByCategory(
                        index == 0 ? 'all' : itemKey,
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      ),
                      child: index == 0 ? const Text('All') : Text(itemKey),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
