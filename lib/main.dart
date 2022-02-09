import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

void main() {
//source de données statiques générées aléatoirement
  var products = List<Product>.generate(
    30,
    (index) => Product(
      index + 1,
      faker.food.dish(),
    ),
  );

  runApp(MarketApp(
    products: products,
  ));
}

//utilisation de la bibliothèque Faker pour obtenir des données fictives
var faker = Faker();

class Product {
  int id;
  String name;
  double price = 0.0;
  //String category; //fruits / vegetables

  Product(this.id, this.name);
}

class MarketApp extends StatelessWidget {
  const MarketApp({Key? key, required this.products}) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductsScreen(title: 'Flutter Market', products: products),
    );
  }
}

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key, required this.title, required this.products})
      : super(key: key);

  final String title;

  final List<Product> products;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late List<Product> products;

  @override
  void initState() {
    super.initState();
    //products = widget.products;

    //source de données statiques générées aléatoirement
    products = List<Product>.generate(
      30,
      (index) => Product(
        index + 1,
        faker.food.dish(),
      ),
    );
  }

  void _addProduct() {
    setState(() {
      products.insert(0, Product(77, faker.food.dish()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ProductsMaster(
          products: products,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addProduct(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//liste de tous les produits
class ProductsMaster extends StatelessWidget {
  const ProductsMaster({Key? key, required this.products}) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductPreview(product: products[index]);
      },
    );
  }
}

//aperçu de 1 produit
class ProductPreview extends StatelessWidget {
  const ProductPreview({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
    );
  }
}

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
