import '../../wishlist/bloc/wishlist_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './wishlist_tile_widget.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final WishlistBlocBloc wishlistBloc = WishlistBlocBloc();
  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wishlist"),
      ),
      body: Container(
        child: BlocConsumer<WishlistBlocBloc, WishlistBlocState>(
          bloc: wishlistBloc,
          buildWhen: (previous, current) => current is! WishlistActionState,
          builder: ((context, state) {
            switch (state.runtimeType) {
              case WishlistSuccessState:
                final successState = state as WishlistSuccessState;
                return ListView.builder(
                  itemCount: successState.wishlistItems.length,
                  itemBuilder: (context, index) {
                    return WishlistTileWidget(
                        WishlistBloc: wishlistBloc,
                        productDataModel: successState.wishlistItems[index]);
                  },
                );
            }
            return Container();
          }),
          listenWhen: (previous, current) => current is WishlistActionState,
          listener: (context, state) {},
        ),
      ),
    );
  }
}
