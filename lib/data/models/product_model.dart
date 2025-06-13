class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final int rating;
  final int reviewCount;
  final int stock;
  final List<String> colors;
  final List<String> features;
  final List<String> optionImages;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.stock,
    required this.colors,
    required this.features,
    required this.imageUrl,
    required this.optionImages
  });

  factory Product.fromFirestore(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      name: data['name'] as String? ?? '',
      description: data['description'] as String? ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      rating: (data['rating'] as int?) ?? 0,
      reviewCount: (data['reviewCount'] as int?) ?? 0,
      stock: (data['stock'] as int?) ?? 0,
      colors: List<String>.from(data['colors'] as List<dynamic>? ?? []),
      features: List<String>.from(data['features'] as List<dynamic>? ?? []),
      optionImages: List<String>.from(data['optionImages'] as List<dynamic>? ?? []),
      imageUrl: data['imageUrl'] as String? ?? '',
    );
  }

  // Optionally add a toMap method for Firestore writes
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'rating': rating,
      'reviewCount': reviewCount,
      'stock': stock,
      'colors': colors,
      'features': features,
      'optionImages': optionImages,
      'imageUrl': imageUrl,
    };
  }
}