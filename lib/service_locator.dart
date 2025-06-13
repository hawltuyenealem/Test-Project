import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:test_project/data/repositories/cart_repository.dart';
import 'package:test_project/data/repositories/product_repository.dart';
import 'package:test_project/presentation/product/blocs/cart/cart_bloc.dart';
import 'package:test_project/presentation/product/blocs/product/product_bloc.dart';

final sl = GetIt.instance;

Future initServiceLocator() async {
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  sl.registerFactory<ProductRepository>(() => ProductRepository(firestore: sl()));
  sl.registerFactory<CartRepository>(() => CartRepository(firestore: sl(),userId: sl()));


  sl.registerLazySingleton<ProductBloc>(() => ProductBloc(productRepository: sl()));
  sl.registerLazySingleton<CartBloc>(() => CartBloc(cartRepository: sl()));
}