import 'package:cloud_firestore/cloud_firestore.dart';

class CartRepository {
  final FirebaseFirestore firestore;
  final String userId;

  CartRepository({
    required this.firestore,
    required this.userId,
  });

  Future<Map<String, int>> getCartItems() async {
    try {
      final doc = await firestore.collection('user_cart').doc(userId).get();
      if (!doc.exists) {
        return {};
      }
      return Map<String, int>.from(doc.data()?['items'] ?? {});
    } catch (e) {
      throw Exception('Failed to get cart items: $e');
    }
  }

  Future<bool> addToCart(String productId) async {
    try {
      await firestore.collection('user_cart').doc(userId).set({
        'items': {
          productId: FieldValue.increment(1)
        }
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  Future<bool> removeFromCart(String productId) async {
    try {
      final currentItems = await getCartItems();
      final currentQty = currentItems[productId] ?? 0;

      if (currentQty <= 1) {
        await firestore.collection('user_cart').doc(userId).update({
          'items.$productId': FieldValue.delete()
        });
      } else {
        await firestore.collection('user_cart').doc(userId).set({
          'items': {
            productId: FieldValue.increment(-1)
          }
        }, SetOptions(merge: true));
      }
      return true;
    } catch (e) {
      throw Exception('Failed to remove from cart: $e');
    }
  }
}