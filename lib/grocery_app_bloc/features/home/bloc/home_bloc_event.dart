part of 'home_bloc_bloc.dart';

@immutable
abstract class HomeBlocEvent {}

class HomeInitialEvent extends HomeBlocEvent {}

class HomeProductWishListClickedEvent extends HomeBlocEvent {
  final ProductDataModel clickedProduct;

  HomeProductWishListClickedEvent({required this.clickedProduct});
}

class HomeProductCartButtonClickedEvent extends HomeBlocEvent {
  final ProductDataModel clickedProduct;

  HomeProductCartButtonClickedEvent({required this.clickedProduct});
}

class HomeWishlistButtonNavigateEvent extends HomeBlocEvent {}

class HomeCartButtonNavigateEvent extends HomeBlocEvent {}
