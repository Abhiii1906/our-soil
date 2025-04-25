part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent {
  const ProductDetailEvent();
}
class ProductDetailEventLoad extends ProductDetailEvent {
  final String productId;

  const ProductDetailEventLoad(this.productId);
}
class ProductDetailEventAddToCart extends ProductDetailEvent {
  final String productId;
  final int quantity;

  const ProductDetailEventAddToCart(this.productId, this.quantity);
}
class ProductDetailEventAddToWishlist extends ProductDetailEvent {
  final String productId;

  const ProductDetailEventAddToWishlist(this.productId);
}
class ProductDetailEventRemoveFromWishlist extends ProductDetailEvent {
  final String productId;

  const ProductDetailEventRemoveFromWishlist(this.productId);
}
class ProductDetailEventRemoveFromCart extends ProductDetailEvent {
  final String productId;

  const ProductDetailEventRemoveFromCart(this.productId);
}
class ProductDetailEventUpdateQuantity extends ProductDetailEvent {
  final String productId;
  final int quantity;

  const ProductDetailEventUpdateQuantity(this.productId, this.quantity);
}

class ProductDetailEventFetchReviews extends ProductDetailEvent {
  final String productId;
  const ProductDetailEventFetchReviews(this.productId);
}
