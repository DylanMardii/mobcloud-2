import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'models/product.dart';
import 'package:provider/provider.dart';
import 'providers/ProductProvider.dart';
import 'cart.dart';

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daftar Produk',
      home: ChangeNotifierProvider(
        create: (Context) => ProductProvider(),
        child: const Skeleton(),
      ),
    );
  }
}

class Skeleton extends StatelessWidget {
  const Skeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("E-Commerce Flutter"),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreen()));
              },
            )
          ],
        ),
        body: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _stream = supabase.from('products').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return StreamBuilder(
      stream: _stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(
              "Terdapat error ketika hendak mengambil data",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          );
        }

        // Return your widget with the data from the snapshot
        return ListView.builder(
          itemCount: snapshot.data!.length,
          padding: const EdgeInsets.all(30),
          itemBuilder: (context, index) {
            final product = Product.fromMap(snapshot.data![index]);
            return Card(
              color: Color.fromARGB(0, 112, 112, 112),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: FadeInImage(
                              image: NetworkImage(product.imageUrl),
                              height: 50,
                              placeholder:
                                  const AssetImage('assets/img/fallback.png'),
                              imageErrorBuilder: (context, error, stacktrace) {
                                return Image.asset(
                                  'assets/img/fallback.png',
                                  height: 50,
                                );
                              },
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              "Rp.${product.price.toString()}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        productProvider.addProductToCart(product);
                      },
                      icon: const Icon(Icons.add_shopping_cart),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
