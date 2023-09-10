import 'package:flutter/material.dart';
import 'package:shop_app/app.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Total: \$ ${cartController.cart.total.toStringAsFixed(2)}"),
      ),
      body: StreamBuilder(
        initialData: cartController.state,
        stream: cartController.stream,
        builder: (context, child) {
          return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: cartController.state.items.length,
              itemBuilder: (context, index) {
                // final CartController controller = c;
                final cartItem = cartController.cart.items[index];

                return Card(
                  child: ListTile(
                    leading: SizedBox(
                      width: 80,
                      child: Stack(
                        children: [
                          Image(
                            image: NetworkImage(cartItem.product.imageUrl),
                            fit: BoxFit.fitWidth,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              alignment: Alignment.center,
                              height: 25,
                              width: 25,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: StreamBuilder(
                                initialData: cartController.state,
                                stream: cartController.stream,
                                builder: (context, child) {
                                  return Text(
                                    cartItem.quantity.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    title: Text(
                      cartItem.product.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(cartItem.product.description),
                            ),
                            const SizedBox(width: 10),
                            Text(cartItem.product.price.toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StreamBuilder(
                              initialData: cartController.state,
                              stream: cartController.stream,
                              builder: (context, _) {
                                return Text("Total: ${cartItem.total.toStringAsFixed(2)}");
                              }
                            ),
                            IconButton.filled(
                              onPressed: () {
                                cartController.addToCard(product: cartItem.product, quantity: 1);
                              },
                              icon: const Icon(Icons.add),
                            ),
                            IconButton.filled(
                              onPressed: () {
                                cartController.addToCard(product: cartItem.product, quantity: -1);
                              },
                              icon: const Icon(Icons.remove),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.payment_rounded),
      ),
    );
  }
}
