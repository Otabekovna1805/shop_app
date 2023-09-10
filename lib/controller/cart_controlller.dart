import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/model/model.dart';


class CartController extends Cubit<Cart> {
  Cart _cart = Cart(id: 1, items: []);

  CartController(super.initialState);

  void addToCard({required Product product, required int quantity}) {
    final isExist = _cart.items.any((element) => element.id == product.id);
    if (isExist) {
      final item =
      _cart.items.firstWhere((element) => element.id == product.id);
      if (quantity == 1) {
        item.quantity++;
      } else if (quantity == -1 && item.quantity > 0) {
        item.quantity--;
      }

      item.total = item.quantity * item.product.price;
      if (item.quantity == 0) {
        _cart.items.remove(item);
      }
    } else if (quantity == 1) {
      final cartItem = CartItem(id: product.id, product: product);
      _cart.items.add(cartItem);
    }
    _cart = _cart.copyWith(items: _cart.items);
  }

  Cart get cart => _cart;
}

