import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shop_app/model/model.dart';
import '../app.dart';
import '../main.dart';
import 'cart.dart';
import 'log_in_page.dart';

class Homes extends StatelessWidget {
  const Homes({Key? key}) : super(key: key);

  void logout() async {
    auth.clearUser().then((value) {
      Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (_) => const LogIn()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDP NOUT Shop"),
        actions: [
          Badge(
            alignment: const Alignment(0.8, -0.8),
            label: StreamBuilder(
              initialData: cartController.state,
              stream: cartController.stream,
              builder: (context, _) {
                final cart = cartController.state.items.length;
                return Text(cart.toString());
              },
            ),
            child: IconButton.filled(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
              },
              icon: const Icon(
                CupertinoIcons.shopping_cart,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.6,
        children: products.map((product) {
          return DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 5,
                                child: Text(
                                  product.name,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  maxLines: 2,
                                )),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  "${product.price}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton.filled(onPressed: () {
                              print("object");
                              cartController.addToCard(product: product, quantity: 1);
                            }, icon: const Icon(Icons.add)),
                            IconButton.filled(onPressed: () {

                              cartController.addToCard(product: product, quantity: -1);
                            }, icon: const Icon(Icons.remove)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(onPressed: logout, child: const Icon(Icons.logout),),
    );
  }
}

//import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:learn_stream/stream%20three/app.dart';
// import 'package:learn_stream/stream%20three/model.dart';
// import 'package:learn_stream/stream%20three/screen/cart.dart';
//
// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("PDP NOUT Shop"),
//         actions: [
//           Badge(
//             alignment: const Alignment(0.8, -0.8),
//             label: StreamBuilder<Cart>(
//               initialData: cartController.cart,
//               stream: cartController.stream,
//               builder: (context, snapshot) {
//                 return Text(snapshot.data?.items.length.toString() ?? "");
//               }
//             ),
//             child: IconButton.filled(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
//               },
//               icon: const Icon(
//                 CupertinoIcons.shopping_cart,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           const SizedBox(width: 10),
//         ],
//       ),
//       body: GridView.count(
//         padding: const EdgeInsets.all(20),
//         crossAxisCount: 2,
//         mainAxisSpacing: 10,
//         crossAxisSpacing: 10,
//         childAspectRatio: 0.6,
//         children: products.map((product) {
//           return DecoratedBox(
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.black, width: 2),
//             ),
//             child: Column(
//               children: [
//                 Expanded(
//                   flex: 3,
//                   child: DecoratedBox(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black, width: 2),
//                     ),
//                     child: Image.network(
//                       product.imageUrl,
//                       fit: BoxFit.fitWidth,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 2,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                                 flex: 5,
//                                 child: Text(
//                                   product.name,
//                                   style: Theme.of(context).textTheme.bodyMedium,
//                                   maxLines: 2,
//                                 )),
//                             Expanded(
//                                 flex: 2,
//                                 child: Text(
//                                   "${product.price}",
//                                   style: Theme.of(context).textTheme.bodySmall,
//                                 )),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             IconButton.filled(onPressed: () {
//                               cartController.addToCard(product: product, quantity: 1);
//                             }, icon: const Icon(Icons.add)),
//                             IconButton.filled(onPressed: () {
//                               cartController.addToCard(product: product, quantity: -1);
//                             }, icon: const Icon(Icons.remove)),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
