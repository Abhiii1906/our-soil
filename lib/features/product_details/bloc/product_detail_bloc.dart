
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/model/response.model.dart';
import '../../../core/network/base_network_status.dart';
import '../model/product.detail.response.model.dart';
import '../respository/product.detail.repository.dart';
part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent,ProductDetailState>{
  final ProjectDetailRepository repository;
  ProductDetailBloc(this.repository) : super(ProductDetailStateInitial()){
    on<ProductDetailEventLoad>(_onProductDetailEventLoad);

  }

  void _onProductDetailEventLoad(ProductDetailEventLoad event, Emitter<ProductDetailState> emit) async {
    emit(ProductDetailStateLoading());
    final result = await repository.fetchProductDetail(id: event.productId);
    if (result.status == ApiStatus.success) {
      emit(ProductDetailStateLoaded(product: result.response));
    } else {
      emit(ProductDetailStateError(result.response));
    }
  }

  
}