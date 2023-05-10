import 'package:bloc_practise/grocery_app_bloc/features/home/models/home_product_data_model.dart';
import 'package:bloc_practise/grocery_app_bloc/features/home/ui/product_tile_widget.dart';
import 'package:flutter/material.dart';
import '../bloc/home_bloc_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../wishlist/ui/wishlist.dart';
import '../../cart/ui/cart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final homeBloc = HomeBlocBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBlocBloc, HomeBlocState>(
      bloc: homeBloc,
      // listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          print('0000');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WishlistPage()),
          );
        } else if (state is HomeProductItemAddedToCartActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Item Added to Cart')),
          );
        } else if (state is HomeProductItemAddedToWishlistActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Item Added to WishList')),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: Text("Grocery App using Bloc"),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: Icon(Icons.shopping_bag_outlined))
                ],
              ),
              body: ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: (context, index) {
                  return ProductTileWidget(
                      homeBloc: homeBloc,
                      productDataModel: successState.products[index]);
                },
              ),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text("Error"),
              ),
            );

          default:
            return SizedBox();
        }
      },
    );
  }
}
