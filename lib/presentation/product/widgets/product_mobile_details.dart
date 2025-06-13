import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/presentation/product/widgets/rating.dart';
import '../../../service_locator.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/product/product_bloc.dart';
import 'color_selector.dart';

class ProductDetailsMobile extends StatelessWidget {
  ProductDetailsMobile({super.key});
  int cartLength = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
  listener: (context, state) {
    if(state is CartAdded){
      cartLength += 1;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added to cart'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  },
  child: BlocBuilder<ProductBloc, ProductState>(
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
              Container(
                padding: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                decoration: BoxDecoration(
                  color: Color(0xff0D2612)
                ),
                child: Text('Astro series',style: GoogleFonts.readexPro(
                  fontWeight: FontWeight.w500,
                  fontSize: 9,
                  color: Colors.white
                ),),
              ),
              const SizedBox(height: 16),
              Text('Products / Gaming Headsets & Audio / ${product.name}',
                  style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
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
                length: MediaQuery.of(context).size.width * 0.9, // 90% width
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

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      // Image
                      Image.network(
                        state.product.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),

                      // Favorite Icon
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            context.read<ProductBloc>().add(
                              ToggleFavorite(
                                productId: product.id,
                                isFavorite: !isFavorite,
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        top: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: MediaQuery.of(context).size.width * 0.6,
                          children: [
                            IconButton(
                              icon: Icon(Icons.chevron_left, size: 32,color: Colors.grey,),
                              onPressed: () {

                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.chevron_right, size: 32,color:
                                Colors.grey,),
                              onPressed: () {

                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),


                  SizedBox(height: 10),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == 0 ? Colors.black : Colors.transparent,
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: 20),


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
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                                border: Border.all(color: Colors.black, width: 2),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text("Black", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {

                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              width: 20,
                              height: 20,
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
                ],
              ),


              const SizedBox(height: 16),

              Center(
                  child: Text(
                      'In stock. Ready for shipping.',
                      style: GoogleFonts.readexPro(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff0BA42D)
                      )
                  )
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
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
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.local_shipping_outlined),
                  SizedBox(width: 8),
                  Text('Free shipping and returns',style: GoogleFonts.readexPro(
                    fontWeight: FontWeight.w500,
                    fontSize: 13
                  ),),
                  Icon(Icons.info_outline_rounded,size: 18,),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.only(left: 32.0),
                child: Text('Made to play with the innovative PLAYSYNC. Connect Xbox + PS5 + PC/mac at the same time and play on all 3 systems. PRO-G GRAPHENE audio transducers achieve unprecedented clarity and response. LIGHTSPEED enables the highest levels of wireless audio performance.',
                  style: GoogleFonts.readexPro(
                    fontWeight: FontWeight.w300,
                    fontSize: 13
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.local_offer_outlined, color: Color(0xff0BA42D),),
                  SizedBox(width: 8),
                  Text('Free express shipping',style: GoogleFonts.readexPro(
                      fontWeight: FontWeight.w300,
                      fontSize: 13
                  ),),
                ],
              ),
              const SizedBox(height: 16),
              Text('Items we suggest',
                  style: GoogleFonts.readexPro(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,

                  )
              ),

              _buildSuggestedItem('GS02 X PLUS GAMING HOUSE', '\$98.00'),
              _buildSuggestedItem('GS02 X PLUS GAMING HOUSE', '\$98.00'),
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
              Dash(
                direction: Axis.horizontal,
                length: MediaQuery.of(context).size.width * 0.9, // 90% width
                dashLength: 5,
                dashColor: Colors.black26,
              ),
            ],
          ),
        );
      },
    ),
);
  }

  Widget _buildSuggestedItem(String name, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [

          Image.network(
            "https://m.media-amazon.com/images/I/7185qYEwIEL._AC_SL1500_.jpg",
            fit: BoxFit.cover,
            width: 60,
            height: 60,

          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name),
                Text(price),
                SizedBox(height: 10,),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xff0BA42D))
                    ),
                    child: Text('options', style: GoogleFonts.readexPro(
                        color: Color(0xff0BA42D),
                        fontSize: 9,
                        fontWeight: FontWeight.w600
                    ),)
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}