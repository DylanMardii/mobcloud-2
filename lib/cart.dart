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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: productProvider.cart.length,
              itemBuilder: (context, index) {
                final product = productProvider.cart[index];
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(product.imageUrl),
                    height: 50,
                    placeholder: const AssetImage('assets/img/fallback.png'),
                    imageErrorBuilder: (context, error, stacktrace) {
                      return Image.asset(
                        'assets/img/fallback.png',
                        height: 50,
                      );
                    },
                  ),
                  title: Text(product.name),
                  subtitle: Text('Rp.${product.price}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      productProvider.removeProductFromCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Item berhasil dihapus.'),
                        ),
                      );
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
        ),
      ),
    );
  }
}
