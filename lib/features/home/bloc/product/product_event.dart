part  of 'product_bloc.dart';

abstract class ProductEvent {}
/*
class FetchProductsEvent extends ProductEvent {
  final String ? orderBy;
  FetchProductsEvent({this.orderBy});
}

 */

class FetchProductsEvent extends ProductEvent {
  final String? sort;
  final String? search;
  final String? categoryId;

  FetchProductsEvent({
    this.sort,
    this.search,
    this.categoryId,
  });
}