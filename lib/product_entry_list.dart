import 'package:flutter/material.dart';
import 'package:toko_kaki_bola/models/product_entry.dart';
import 'package:toko_kaki_bola/drawer.dart';
import 'product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'product_detail.dart';
import 'product_form.dart';

class ProductEntryListPage extends StatefulWidget {
  const ProductEntryListPage({super.key});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  bool _showMyProductsOnly = true;
  Future<List<ProductEntry>>? futureProducts;

  Future<List<ProductEntry>> fetchProduct(CookieRequest request, bool myProductsOnly) async {
    final url = myProductsOnly 
      ? 'http://localhost:8000/get-user-products/'
      : 'http://localhost:8000/json/';
    
    final response = await request.get(url);
    
    List<ProductEntry> listProduct = [];
    for (var d in response) {
      if (d != null) {
        listProduct.add(ProductEntry.fromJson(d));
      }
    }
    return listProduct;
  }

  void _toggleViewMode() {
    setState(() {
      _showMyProductsOnly = !_showMyProductsOnly;
      final request = Provider.of<CookieRequest>(context, listen: false);
      futureProducts = fetchProduct(request, _showMyProductsOnly);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final request = Provider.of<CookieRequest>(context, listen: false);
    futureProducts = fetchProduct(request, _showMyProductsOnly);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_showMyProductsOnly ? 'My Products' : 'All Products'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: Icon(_showMyProductsOnly ? Icons.person : Icons.people),
            tooltip: _showMyProductsOnly ? 'Show All Products' : 'Show My Products',
            onPressed: _toggleViewMode,
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder<List<ProductEntry>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _showMyProductsOnly ? Icons.inventory_2_outlined : Icons.store_mall_directory_outlined,
                    size: 64,
                    color: colorScheme.secondary, 
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _showMyProductsOnly 
                      ? 'You have no products yet.' 
                      : 'No products available.',
                    style: TextStyle(
                      fontSize: 20,
                      color: colorScheme.secondary, 
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _showMyProductsOnly 
                      ? 'Create your first product!' 
                      : 'Check back later or create one.',
                    style: TextStyle(color: colorScheme.onSurfaceVariant), 
                  ),
                ],
              ),
            );
          }
          
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) => ProductEntryCard(
              product: snapshot.data![index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(product: snapshot.data![index]),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProductFormPage()),
          );
        },
        backgroundColor: colorScheme.primary, 
        child: Icon(Icons.add, color: colorScheme.onPrimary), 
      ),
    );
  }
}