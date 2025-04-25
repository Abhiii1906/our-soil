import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/model/response.model.dart';
import '../../../../core/network/base_network_status.dart';
import '../../model/product.list.model.dart';
import '../../repository/product.repository.dart';

part 'product_event.dart';
part 'product_state.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState>  {
  final ProductRepository repository;
  ProductBloc(this.repository) : super(ProductInitialState()){
    on<FetchProductsEvent>(_onFetchProductsEvent);
  }
/*
  void _onFetchProductsEvent(FetchProductsEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    ApiResult result = await repository.fetchProducts(orderBy: event.orderBy);
    if (result.status == ApiStatus.success) {
      emit(ProductLoadedState(result.response));
    } else {
      emit(ProductErrorState(result.response));
    }
  }

 */

  void _onFetchProductsEvent(FetchProductsEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());

    final result = await repository.fetchProducts(
      sort: event.sort,
      search: event.search,
      categoryId: event.categoryId,
    );

    if (result.status == ApiStatus.success) {
      emit(ProductLoadedState(result.response));
    } else {
      emit(ProductErrorState(result.response));
    }
  }

}