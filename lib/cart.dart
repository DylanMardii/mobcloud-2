import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'providers/ProductProvider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: Column(
          children: [
            ListView.builder(
              itemCount: productProvider.cart.length,
              itemBuilder: (context, index) {
                final product = productProvider.cart[index];
                return ListTile(
                  leading: Image.network(product.imageUrl),
                  title: Text(product.name),
                  subtitle: Text('Rp.${product.price}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      productProvider.removeProductFromCart(product);
                    },
                  ),
                );
              },
            ),
            Text('Total: \$${productProvider.totalPrice}'),
            ElevatedButton(
              onPressed: () {
                productProvider.checkout();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Checkout berhasil.'),
                  ),
                );
              },
              child: const Text('Checkout'),
            )
          ],
        ));
  }
}
