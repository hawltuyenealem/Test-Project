import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:google_fonts/google_fonts.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Products / Gaming Headsets & Audio / ${product.name}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
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
                      flex: 5,
                      child: Container(
                        constraints: const BoxConstraints(maxHeight: 500),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                product.imageUrl,
                                fit: BoxFit.contain,
                                height: 400,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: IconButton(
                                icon: Icon(
                                  isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : Colors.grey,
                                  size: 30,
                                ),
                                onPressed: () {
                                  sl<ProductBloc>().add(ToggleFavorite(productId: product.id, isFavorite: !isFavorite));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: GoogleFonts.hammersmithOne(
                                fontWeight: FontWeight.w400,
                                color: Color(0xff190D26),
                                fontSize: 20
                            ),
                          ),
                          Text(
                            'LIGHTSPEED Wireless Gaming Headset + Base Station',
                            style: GoogleFonts.readexPro(
                                color: Color(0xff190D26),
                                fontSize: 13,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          const SizedBox(height: 8),
                          RatingWidget(rating: state.product.rating, reviewCount: state.product.reviewCount),
                          const SizedBox(height: 16),
                          Dash(
                            direction: Axis.horizontal,
                            length: MediaQuery.of(context).size.width * 0.4, // 90% width
                            dashLength: 5,
                            dashColor: Colors.black26,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${product.price}',
                            style: GoogleFonts.readexPro(
                                color: Color(0xff0D2612),
                                fontWeight: FontWeight.w700,
                                fontSize: 13
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Suggested payments with 6 month special financing',style: GoogleFonts.readexPro(
                              color: Color(0xff0D2612),
                              fontSize: 9,
                              fontWeight: FontWeight.w500
                          ),),
                          const SizedBox(height: 16),

                          const Text(
                            'Choose a color',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Dash(
                            direction: Axis.horizontal,
                            length: MediaQuery.of(context).size.width * 0.4,
                            dashLength: 5,
                            dashColor: Colors.black26,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {

                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 8),
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                        border: Border.all(color: Colors.black, width: 2),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {

                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 8),
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black, width: 2),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Only 16 items left!',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Don\'t miss it!',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              BlocBuilder<CartBloc, CartState>(
                                builder: (context, cartState) {
                                  final quantity = cartState.items[product.id] ?? 0;

                                  if (quantity > 0) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove),
                                            onPressed: () {
                                              sl<CartBloc>().add(RemoveFromCart(product.id));
                                            },
                                          ),
                                          Text('$quantity'),
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: () {
                                              sl<CartBloc>().add(AddToCart(product.id));
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return ElevatedButton(
                                      onPressed: () {
                                        sl<CartBloc>().add(AddToCart(product.id));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xff0BA42D),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 32,
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.shopping_cart_outlined),
                                          SizedBox(width: 8),
                                          Text(
                                            'Add to Cart',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                              const SizedBox(width: 16),
                              GestureDetector(
                                onTap: () {
                                  context.read<ProductBloc>().add(
                                    ToggleFavorite(
                                      productId: product.id,
                                      isFavorite: !isFavorite,
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: const Color(0xff0D2612)),
                                  ),
                                  child: Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorite ? Colors.red : const Color(0xff0D2612),
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          DottedBorder(
                            options: RectDottedBorderOptions(
                              color: Colors.grey,
                              strokeWidth: 1,
                              dashPattern: const [6, 3],
                            ),

                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  _buildDeliveryInfo(
                                    icon: Icons.local_shipping,
                                    title: "Free delivery",
                                    subtitle: "Enter your Postal Code for Delivery Availability",
                                  ),
                                  const SizedBox(height: 16),
                                  Divider(height: 1, color: Colors.grey.shade300),
                                  const SizedBox(height: 16),
                                  _buildDeliveryInfo(
                                    icon: Icons.assignment_return,
                                    title: "Return Delivery",
                                    subtitle: "Free delivery 30 Days return",
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Dash(
                  direction: Axis.horizontal,
                  length: MediaQuery.of(context).size.width * 0.9, // 90% width
                  dashLength: 5,
                  dashColor: Colors.black26,
                ),
                ListTile(
                  title: Text(
                    'Specification and details',
                    style: GoogleFonts.hammersmithOne(
                      fontWeight: FontWeight.w400,
                      color: Color(0xff0D2612),
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_drop_down,
                    color: Color(0xff0D2612),
                  ),
                  onTap: () {
                  },
                ),
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
        );
      },
    );
  }

  Widget _buildDeliveryInfo({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
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
    );
  }
}