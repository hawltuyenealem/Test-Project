import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:test_project/presentation/product/widgets/rating.dart';
import '../../../service_locator.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/product/product_bloc.dart';
import 'color_selector.dart';

class ProductDetailsDesktop extends StatelessWidget {
  const ProductDetailsDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductError) {
          return Center(child: Text(state.errorMessage));
        } else if (state is! ProductLoaded) {
          return const Center(child: Text('Product not found'));
        }

        final product = state.product;
        final isFavorite = state.isFavorite;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Products / Gaming Headsets & Audio / ${product.name}',
                  style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              const Text(
                'ASTRO SERIES',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Stack(
                      children: [
                        Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                          height: 400,
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              sl<ProductBloc>().add(ToggleFavorite(productId: product.id, isFavorite: !isFavorite));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'LIGHTSPEED Wireless Gaming Headset + Base Station',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const RatingWidget(rating: 5, reviewCount: 121),
                        const SizedBox(height: 16),
                        Text(
                          '\$${product.price}',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text('Suggested payments with 6 month special financing'),
                        const SizedBox(height: 24),
                        const Text('Choose a color', style: TextStyle(fontWeight: FontWeight.bold)),
                        Dash(
                          direction: Axis.horizontal,
                          length: MediaQuery.of(context).size.width * 0.9, // 90% width
                          dashLength: 5,
                          dashColor: Colors.black26,
                        ),
                        const SizedBox(height: 8),
                        ColorSelector(colors: product.colors),
                        const SizedBox(height: 16),
                        const Text('Only 16 items left!', style: TextStyle(color: Colors.red)),
                        const Text('Don\'t miss it!'),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                sl<CartBloc>().add(AddToCart(product.id));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff0BA42D),
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 100)
                              ),
                              child: Center(
                                child: Row(
                                  spacing: 5,
                                  children: [
                                    Icon(Icons.shopping_cart_outlined),
                                    const Text('Add to Cart'),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                context.read<ProductBloc>().add(
                                  ToggleFavorite(
                                    productId: product.id,
                                    isFavorite: !isFavorite,
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Color(0xff0D2612))
                                ),
                                child:  Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorite ? Colors.red : Color(0xff0D2612),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        DottedBorder(
                          options: RectDottedBorderOptions(
                            dashPattern: [6, 3],
                            color: Colors.black54,
                            strokeWidth: 1,
                            padding: EdgeInsets.all(16),
                          ),
                          child: Column(
                            children: [
                              _buildItem(
                                icon: Icons.local_shipping,
                                title: "Free delivery",
                                subtitle: "Enter your Postal Code for Delivery Availability",
                              ),
                              Divider(color: Colors.grey.shade400, height: 1),
                              _buildItem(
                                icon: Icons.assignment_return,
                                title: "Return Delivery",
                                subtitle: "Free delivery 30 Days return",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Icon(Icons.assignment_return),
                            SizedBox(width: 8),
                            Text('Free delivery 30 Days return'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Dash(
                          direction: Axis.horizontal,
                          length: MediaQuery.of(context).size.width * 0.9, // 90% width
                          dashLength: 5,
                          dashColor: Colors.black26,
                        ),
                        const SizedBox(height: 16),
                        const Text('Specification and details', style: TextStyle(fontWeight: FontWeight.bold)),
                        ...product.features.map((feature) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text('• $feature'),
                        )),
                        const SizedBox(height: 16),
                        Dash(
                          direction: Axis.horizontal,
                          length: MediaQuery.of(context).size.width * 0.9, // 90% width
                          dashLength: 5,
                          dashColor: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }


  Widget _buildItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}