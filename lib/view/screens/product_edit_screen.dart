
import 'package:flutter/material.dart';
import 'package:kings_lab_test/controller/provider/product_provider.dart';
import 'package:kings_lab_test/model/product_model.dart';
import 'package:provider/provider.dart';

class ProductEditScreen extends StatefulWidget {
  final Product product;

  const ProductEditScreen({super.key, required this.product});

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.product.title);
    _descriptionController =
        TextEditingController(text: widget.product.description);
    _priceController =
        TextEditingController(text: widget.product.price.toString());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _updateProduct() async {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedData = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'price': double.parse(_priceController.text),
      };

      try {
        final productProvider =
            Provider.of<ProductProvider>(context, listen: false);
        bool success =
            await productProvider.updateProduct(widget.product.id, updatedData);

        if (success) {
          Navigator.pop(context, true);
        } else {
          _showErrorDialog('Failed to update product');
        }
      } catch (e) {
        _showErrorDialog('Error: $e');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Title Field
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Price Field
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Price cannot be empty';
                  } else if (double.tryParse(value) == null) {
                    return 'Enter a valid number for price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: _updateProduct,
                child: const Text('Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
