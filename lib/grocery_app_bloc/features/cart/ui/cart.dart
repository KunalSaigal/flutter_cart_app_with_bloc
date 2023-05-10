import '../../cart/bloc/cart_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_tile_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartBlocBloc cartBloc = CartBlocBloc();
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Container(
        child: BlocConsumer<CartBlocBloc, CartBlocState>(
          bloc: cartBloc,
          buildWhen: (previous, current) => current is! CartActionState,
          builder: ((context, state) {
            switch (state.runtimeType) {
              case CartSuccessState:
                final successState = state as CartSuccessState;
                return ListView.builder(
                  itemCount: successState.cartItems.length,
                  itemBuilder: (context, index) {
                    return CartTileWidget(
                        cartBloc: cartBloc,
                        productDataModel: successState.cartItems[index]);
                  },
                );
            }
            return Container();
          }),
          listenWhen: (previous, current) => current is CartActionState,
          listener: (context, state) {},
        ),
      ),
    );
  }
}
