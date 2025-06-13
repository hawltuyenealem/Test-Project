import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/product_model.dart';

class ProductRepository {
  final FirebaseFirestore firestore;

  ProductRepository({required this.firestore});

  Future<Product> getProduct(String productId) async {
    try {
      final doc = await firestore.collection('products').doc(productId).get();
      debugPrint('Fetching product : ${doc.data()}');
      if (!doc.exists) {
        throw Exception('Product not found');
      }
      return Product.fromFirestore(doc.data()!, doc.id);
    } catch (e) {
      debugPrint('Error fetching product: $e');
      throw Exception('Failed to load product: $e');
    }
  }

  Future<bool> isFavorite(String productId) async {
    try {
      final doc = await firestore.collection('user_favorites').doc('anonymous_user').get();
      final favorites = doc.data()?['products'] as List<dynamic>? ?? [];
      return favorites.contains(productId);
    } catch (e) {
      throw Exception('Failed to check favorite status: $e');
    }
  }

  Future<bool> setFavorite(String productId, bool isFavorite) async {
    try {
      final userRef = firestore.collection('user_favorites').doc('anonymous_user');

      if (isFavorite) {
        await userRef.set({
          'products': FieldValue.arrayUnion([productId])
        }, SetOptions(merge: true));
      } else {
        await userRef.set({
          'products': FieldValue.arrayRemove([productId])
        }, SetOptions(merge: true));
      }
      return true;
    } catch (e) {
      throw Exception('Failed to update favorite: $e');
    }
  }
}