import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzia/application/home/bloc/home_bloc.dart';
import 'package:newzia/domain/core/di/injectable.dart';
import 'package:newzia/presentation/home/article_screen.dart';
import 'package:newzia/presentation/home/home_screen.dart';
import 'package:newzia/presentation/onboarding/onboarding_screen.dart';
import 'package:newzia/presentation/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => getIt<HomeBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          backgroundColor: Colors.white,
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/home': (context) => HomeScreen(),
          // '/article': (context) => ArticleScreen(),
        },
      ),
    );
  }
}
