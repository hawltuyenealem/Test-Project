import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/presentation/product/blocs/cart/cart_bloc.dart';
import 'package:test_project/presentation/product/blocs/product/product_bloc.dart';
import 'package:test_project/presentation/product/screens/product_screen.dart';
import 'package:test_project/service_locator.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final userId = 'anonymous_user';

  await initServiceLocator(userId: userId);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(create: (_) => sl<ProductBloc>()..add(LoadProduct('astro_a50_x'))),
        BlocProvider<CartBloc>(create: (_)=> sl<CartBloc>()),
      ],
  child: MaterialApp(
      title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(fontSize: 16, color: Colors.grey),
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
      ),
    ),
      home: ProductScreen(),
    ),
);
  }
}

