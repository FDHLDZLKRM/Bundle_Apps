import 'package:flutter/material.dart';
import 'package:shrine/cart_page.dart';
import 'package:shrine/model/product.dart';


class Details extends StatelessWidget {
  final Product product;
  final Function(Product) addToCart;
  final List<Product> cartItems;


  Details({required this.product, required this.addToCart, required this.cartItems,});
  @override
  Widget build(BuildContext context) {
    final imageWidget = Image.asset(
      product.assetName,
      package: product.assetPackage,
      fit: BoxFit.cover,
    );
    List<int> sizeList = [7, 8, 9, 10];
    List<Color> colorsList = [Colors.black, Colors.blue, Colors.red];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('${product.name}'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              tooltip: 'Show Snackbar',
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage(cartItems: cartItems)),
                );
              },
            ),
          ],
          backgroundColor: const Color(0xff4626c5),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: AspectRatio(
                            child: imageWidget,
                            aspectRatio: 33 / 9,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: RawMaterialButton(
                            onPressed: () {},
                            child: const Icon(
                              Icons.crop_rotate,
                              color: Colors.blue,
                            ),
                            shape: const CircleBorder(),
                            elevation: 2.0,
                            fillColor: Colors.white,
                            padding: const EdgeInsets.all(3.0),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -1),
                      blurRadius: 5,
                      color: Colors.black12,
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding:
                        const EdgeInsets.only(top: 25, left: 25, right: 25),
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: <Widget>[ // TODO : HERE
                            ListTile(
                              leading: Icon(Icons.content_cut_outlined, color: Colors.black,),
                              title: Text('The Enchanted Nightingale'),
                              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                    child: const Text('BUY TICKETS'),
                                    onPressed: () {/* ... */},
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    child: const Text('LISTEN'),
                                    onPressed: () {/* ... */},
                                  ),
                                  const SizedBox(width: 8),
                                ],
                                ),
                            const SizedBox(height: 15),
                            Row(
                              children: <Widget>[
                                const Text(
                                  "Size:",
                                  style: TextStyle(fontSize: 21),
                                ),
                                const SizedBox(width: 15),
                                for (var item in sizeList)
                                  Container(
                                    margin:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      shape: BoxShape.circle,
                                    ),
                                    height: 25,
                                    width: 25,
                                    child: Text("$item"),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: <Widget>[
                                const Text(
                                  "Colors:",
                                  style: TextStyle(fontSize: 21),
                                ),
                                const SizedBox(width: 15),
                                for (var item in colorsList)
                                  Container(
                                    margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: item,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Description",
                              style: TextStyle(fontSize: 21),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '${product.description}',
                              style: const TextStyle(fontSize: 17),
                            )
                          ],
                        ), //col
                      ),
                    ),
                    FloatingActionButton.extended(
                      onPressed: () {
                        addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Item added to cart')),
                        );
                      },
                      extendedPadding: const EdgeInsets.all(120),
                      backgroundColor: Colors.indigo,
                      label: const Text("Add to Cart"),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

