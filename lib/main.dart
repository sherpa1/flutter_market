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

  runApp(
    MarketApp(
      products: products,
    ),
  );
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

class ProductsMaster extends StatefulWidget {
  const ProductsMaster({Key? key, required this.products}) : super(key: key);

  final List<Product> products;

  @override
  State<ProductsMaster> createState() => _ProductsMasterState();
}

class _ProductsMasterState extends State<ProductsMaster> {
  Product? selectedProduct; //product will be null initially

  void onProductSelected(Product product) {
    setState(() {
      selectedProduct = product;
      //when selectedProduct has a value, ProductDetails widget is displayed
    });
  }

  void hideDetails() {
    setState(() {
      selectedProduct = null;
      //when selectedProduct is null ProductDetails widget is hidden
    });
  }

  //affichage conditionnel
  Widget _showDetailsWhenProductIsSelected() {
    return (selectedProduct != null)
        ? ProductDetails(product: selectedProduct, onHide: hideDetails)
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _showDetailsWhenProductIsSelected(),
        Expanded(
          child: ListView.builder(
            itemCount: widget.products.length,
            itemBuilder: (context, index) {
              return ProductPreview(
                product: widget.products[index],
                onSelect: onProductSelected,
              );
            },
          ),
        ),
      ],
    );
  }
}

//aperçu de 1 produit
class ProductPreview extends StatelessWidget {
  const ProductPreview(
      {Key? key, required this.product, required this.onSelect})
      : super(key: key);

  final Product product;
  final Function onSelect;

  void onTap() {
    onSelect(product);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      onTap: () => onTap(),
    );
  }
}

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key, required this.product, required this.onHide})
      : super(key: key);

  final Product? product;
  final Function onHide;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                product!.id.toString(),
              ),
              Text(product!.name),
              Text(
                faker.lorem.sentence(),
              ),
              IconButton(
                  onPressed: () => onHide(), icon: const Icon(Icons.close))
            ],
          ),
        ),
      ),
    );
  }
}
