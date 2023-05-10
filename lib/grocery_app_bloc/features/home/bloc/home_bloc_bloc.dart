import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_practise/grocery_app_bloc/data/cart_items.dart';
import 'package:bloc_practise/grocery_app_bloc/data/wishlist_items.dart';
import '../../../dummy_data.dart';
import '../models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBlocBloc() : super(HomeBlocInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeWishlistButtonNavigateEvent>(homeProductWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeProductWishListClickedEvent>(homeProductWishListClickedEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeBlocState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(
      HomeLoadedSuccessState(
        products: DummyData.groceryList
            .map(
              (e) => ProductDataModel(
                id: e["id"],
                name: e["name"],
                description: e["description"],
                price: e["price"],
                imageUrl: e["imageUrl"],
              ),
            )
            .toList(),
      ),
    );
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeBlocState> emit) {
    print("Cart Navigate clicked");
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeProductWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeBlocState> emit) {
    print("Wishlist Navigate clicked");
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeBlocState> emit) {
    print("Cart Product clicked");
    cartItems.add(event.clickedProduct);

    emit(HomeProductItemAddedToCartActionState());
  }

  FutureOr<void> homeProductWishListClickedEvent(
      HomeProductWishListClickedEvent event, Emitter<HomeBlocState> emit) {
    print("WishList Product clicked");
    wishlistItems.add(event.clickedProduct);

    emit(HomeProductItemAddedToWishlistActionState());
  }
}
