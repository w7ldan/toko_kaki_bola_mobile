import 'package:flutter/material.dart';
import 'menu.dart';
import 'drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'product_entry_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _thumbnailController = TextEditingController();
  
  String _selectedCategory = 'sepatu';
  bool _isFeatured = false;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _thumbnailController.dispose();
    super.dispose();
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;
    
    final request = context.read<CookieRequest>();
    
    try {
      final response = await request.postJson(
        "http://localhost:8000/create-product-flutter/",
        jsonEncode({
          "name": _nameController.text,
          "description": _descriptionController.text,
          "price": int.parse(_priceController.text),
          "thumbnail": _thumbnailController.text,
          "category": _selectedCategory, // Use dropdown value
          "is_featured": _isFeatured,
        }),
      );
      
      if (!mounted) return; // More robust check
      
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product successfully saved!")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProductEntryListPage()),
        );
      } else {
        String errorMsg = response['message'] ?? "Something went wrong, please try again.";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMsg)),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk Baru'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Produk',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama produk tidak boleh kosong';
                  }
                  if (value.length < 3) {
                    return 'Nama produk minimal 3 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Price Field
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Harga',
                  border: OutlineInputBorder(),
                  prefixText: 'Rp ',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga tidak boleh kosong';
                  }
                  final price = int.tryParse(value);
                  if (price == null) {
                    return 'Harga harus berupa angka';
                  }
                  if (price <= 0) {
                    return 'Harga harus lebih dari 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi tidak boleh kosong';
                  }
                  if (value.length < 10) {
                    return 'Deskripsi minimal 10 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Thumbnail URL Field
              TextFormField(
                controller: _thumbnailController,
                decoration: const InputDecoration(
                  labelText: 'URL Thumbnail',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Thumbnail tidak boleh kosong';
                  }
                  if (!Uri.parse(value).isAbsolute) {
                    return 'Format URL tidak valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Category Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'sepatu', child: Text('Sepatu')),
                  DropdownMenuItem(value: 'jersey', child: Text('Jersey')),
                  DropdownMenuItem(value: 'celana', child: Text('Celana')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pilih kategori';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Featured Switch
              SwitchListTile(
                title: const Text('Featured Product'),
                value: _isFeatured,
                onChanged: (value) {
                  setState(() {
                    _isFeatured = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              
              // Submit Button
              ElevatedButton(
                onPressed: _saveProduct, // ✅ Calls the correct async method
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}