import 'package:flutter/material.dart';
import 'menu.dart';
import 'product_form.dart';
import 'product_entry_list.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
            ),
            child: Text(
              'Toko Kaki Bola',
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: theme.colorScheme.primary,
            ),
            title: Text(
              'Halaman Utama',
              style: TextStyle(
                color: theme.colorScheme.onSurface,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.add_shopping_cart,
              color: theme.colorScheme.primary, 
            ),
            title: Text(
              'Tambah Produk',
              style: TextStyle(
                color: theme.colorScheme.onSurface,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProductFormPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_reaction_rounded),
            title: const Text('Product List'),
            onTap: () {
                // Route to news list page
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProductEntryListPage()),
                );
            },
        ),
        ],
      ),
    );
  }
}