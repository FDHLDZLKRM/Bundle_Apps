import 'package:flutter/material.dart';
import 'package:shrine/cart_page.dart';
import 'package:shrine/detail_page.dart';
import 'package:shrine/login.dart';
import 'package:shrine/model/product.dart';
import 'package:shrine/model/products_repository.dart';

class HomePage extends StatefulWidget {
  String username;
   HomePage({Key? key, required this.username}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> cartItems = <Product>[];


  //FUNCTION ADD PRODUCT TO CART
  void addToCart(Product product) {
    setState(() {
      cartItems.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Techie Bundle',
        ),
        backgroundColor: const Color(0xff4626c5),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Show Snackbar',
            onPressed: () {
              //ScaffoldMessenger.of(context).showSnackBar(
              //  const SnackBar(content: Text('Add Cart Button')),
              //);
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(cartItems: cartItems,),),);

            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: const Color(0xff4626c5)),
              accountName: Text(
                "Hello, Welcome ${widget.username}",
                style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 17,
                ),
              ),

              currentAccountPicture: FlutterLogo(), accountEmail: Text(''),
            ),
            ListTile(
              leading: Icon(
                Icons.favorite_outlined,
                color: const Color(0xff4626c5),
              ),
              title: const Text('Wishlist'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout_outlined,
                color: const Color(0xff4626c5),
              ),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>LoginPage()),(Route<dynamic>route)=>false);
              },
            ),
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        children: _buildGridCards(context),
      ),
      resizeToAvoidBottomInset: false,
    );
  }


//SUSUNAN CARD
  //SBB KITA RETURN category.all KAT PRODUCT REPOSITORY TADI
  // SO KITA PAKAI ProductsRepository.loadProducts(Category.all);

  List<StatelessWidget> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);

    return products.map((product) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Details(
                product: product,
                addToCart: addToCart, // Pass the addToCart method to the Details page
                cartItems: cartItems,
              ),
            ),
          ).then((value) {
            if (value != null) {
              setState(() {
                cartItems = value;
              });
            }
          });
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 18 / 11,
                child: Image.asset(
                  product.assetName,
                  package: product.assetPackage,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        product.name,
                        style: theme.textTheme.titleLarge,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'RM ${product.price}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
