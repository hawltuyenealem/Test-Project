import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/product_desktop_details.dart';
import '../widgets/product_mobile_details.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(
      ),
      appBar: AppBar(
        title: const HeaderBar(),
        backgroundColor: const Color(0xff0D2613),
        actions: [
          IconButton(
            icon: const Icon(Icons.search,color: Colors.white
              ,),
            onPressed: () {},
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined,color: Colors.white,),
                onPressed: () {},
              ),
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Center(
                    child: Text(
                      '1',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return const Column(
              children: [
                DesktopNavigationBar(),
                Expanded(child: ProductDetailsDesktop()),
              ],
            );
          } else {
            return ProductDetailsMobile();
          }
        },
      ),
    );
  }
}

class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return  Row(
            children: [
              Expanded(
                child: Row(
                  spacing: 10,
                  children: [
                    Text(
                      'GG',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Nico Moji',
                        color: Colors.white,
                      ),
                    ),
                    Icon(Icons.dialer_sip,color: Colors.white,),
                    Text(
                      '+4904-049-950',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  spacing: 10,
                  children: [
                    Text(
                      'Get 50% Off on the Selected items ',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '|',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      'Shop now',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,),
                    SizedBox(width: 8),
                    Text(
                        'English',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                        color: Colors.white
                    ),),
                    SizedBox(width: 10),
                    Icon(Icons.language, size: 20,color: Colors.white,),
                    SizedBox(width: 4),
                    Text(
                        'Location',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.white
                        )
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: Text('GG',
            style: TextStyle(
              fontFamily: 'Nico Moji',
              fontSize: 28,
              color: Color(0xff0D2612)
            ),),
          );
        }
      },
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Text(
              'GameGeek',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categories'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.branding_watermark),
            title: const Text('Brands'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.new_releases),
            title: const Text('What\'s New'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.local_offer),
            title: const Text('Sales'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class DesktopNavigationBar extends StatelessWidget {
  const DesktopNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
    decoration: const BoxDecoration(
    border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('GameGeek',
          style: TextStyle(
            fontFamily: 'Nico Moji',
            fontWeight: FontWeight.w400,
            fontSize: 30,
            color: const Color(0xff0D2612),
          ),
        ),
        Row(
          children: [
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 40),
            TextButton(
              onPressed: () {},
              child: const Text('Brands'),
            ),
            const SizedBox(width: 20),
            TextButton(
              onPressed: () {},
              child: const Text('What\'s New'),
            ),
            const SizedBox(width: 20),
            TextButton(
              onPressed: () {},
              child: const Text('Sales'),
            ),
            const SizedBox(width: 20),
            TextButton(
              onPressed: () {},
              child: const Text('Help'),
            ),
            const SizedBox(width: 20),
            TextButton(
              onPressed: () {},
              child: const Text('About'),
            ),
            const SizedBox(width: 40),
            Icon(Icons.search),
            const SizedBox(width: 20),
            Icon(Icons.person_outline),
            const SizedBox(width: 20),
            Icon(Icons.shopping_cart_outlined),



          ],
        ),
      ],
    ),
    );
  }
}