part of 'product_bloc.dart';

abstract class ProductState {}

class  ProductInitialState extends ProductState {}

class  ProductLoadingState extends ProductState {}

class  ProductLoadedState extends ProductState {
  final ProductListResponseModel products;
  ProductLoadedState(this.products);
}

class ProductErrorState extends ProductState {
  final ResponseModel data;
  ProductErrorState(this.data);
}