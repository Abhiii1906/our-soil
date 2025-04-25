part of 'product_detail_bloc.dart';

abstract class ProductDetailState {
  const ProductDetailState();
}

class ProductDetailStateInitial extends ProductDetailState {
  const ProductDetailStateInitial();
}

class ProductDetailStateLoading extends ProductDetailState {
  const ProductDetailStateLoading();
}

class ProductDetailStateLoaded extends ProductDetailState {
  final ProductDetailResponseModel product;

  const ProductDetailStateLoaded({
    required this.product,
  });
}

// class ProductReviewStateLoaded extends ProductDetailState {
//   final List<> reviews;
//   const ProductReviewStateLoaded({
//     required this.reviews,
//   });
// }

class ProductDetailStateError extends ProductDetailState {
  final ResponseModel data;
  const ProductDetailStateError(this.data);
}


