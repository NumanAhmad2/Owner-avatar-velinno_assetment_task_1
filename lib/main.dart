import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velinno_assestment_task/core/theme/theme_cubit.dart';
import 'package:velinno_assestment_task/features/home/view_model/home_screen_cubit.dart';

import 'features/home/view/home_screen.dart';
import 'package:velinno_assestment_task/core/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeScreenCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Velinno Assestment Task',
            darkTheme: AppThemes.dark,
            theme: AppThemes.light,
            themeMode: themeMode,
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
