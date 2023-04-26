import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:localization_bloc/lang_bloc/lang_bloc.dart';
import 'package:localization_bloc/theme_bloc/theme_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LangBloc(),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: BlocBuilder<LangBloc, LangState>(
        builder: (context, lang) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme:
                state is ThemeLightState ? ThemeData.light() : ThemeData.dark(),
                title: 'Localization App',
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                home: const HomeScreen(),
                locale:
                lang is MSLangState ? const Locale('ms') : const Locale('en'),
              );
            },
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appbar),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.body),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () => context.read<LangBloc>().add(MSLangEvent()),
                  child: const Text('Bahasa Melayu')),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () => context.read<LangBloc>().add(ENLangEvent()),
                  child: const Text('English')),
              Divider(),
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  return state is ThemeLightState
                      ? Text(AppLocalizations.of(context)!.lightMode)
                      : Text(AppLocalizations.of(context)!.darkMode);
                },
              ),
              const SizedBox(height: 10,),
              ElevatedButton(onPressed: () =>
                  context.read<ThemeBloc>().add(ThemeChangeEvent()),
                  child: Text(AppLocalizations.of(context)!.toggleMode))
            ],
          ),
        ),
      ),
    );
  }
}
