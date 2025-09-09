import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velinno_assestment_task/features/home/view_model/home_screen_cubit.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.76,
      child: SearchBar(
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        elevation: WidgetStateProperty.all(0),
        hintText: 'Search articles...',
        onChanged: (value) {
          context.read<HomeScreenCubit>().searchArticles(value);
        },
      ),
    );
  }
}
