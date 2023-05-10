import '../../../data/cart_items.dart';
import '../../home/bloc/home_bloc_bloc.dart';
import '../../home/models/home_product_data_model.dart';
import 'package:flutter/material.dart';

import '../bloc/cart_bloc_bloc.dart';

class CartTileWidget extends StatelessWidget {
  final CartBlocBloc cartBloc;
  final ProductDataModel productDataModel;
  const CartTileWidget(
      {super.key, required this.productDataModel, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.all(mediaQueryData.size.width * 0.01),
      padding: EdgeInsets.all(mediaQueryData.size.width * 0.01),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: mediaQueryData.size.height * 0.2,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(productDataModel.imageUrl),
              ),
            ),
            width: double.maxFinite,
          ),
          SizedBox(
            height: mediaQueryData.size.height * 0.005,
          ),
          Text(
            productDataModel.name,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: mediaQueryData.size.height * 0.04),
          ),
          SizedBox(height: mediaQueryData.size.height * 0.005),
          Text(
            productDataModel.description,
            style: TextStyle(fontSize: mediaQueryData.size.height * 0.025),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${productDataModel.price}",
                style: TextStyle(fontSize: mediaQueryData.size.height * 0.02),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // cartBloc.add(HomeProductWishListClickedEvent(
                      //     clickedProduct: productDataModel));
                    },
                    icon: Icon(Icons.favorite_border),
                  ),
                  IconButton(
                    onPressed: () {
                      cartBloc.add(CartRemoveFromCartEvent(
                          productDataModel: productDataModel));
                    },
                    icon: Icon(Icons.shopping_bag),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
