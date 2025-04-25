import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/model/response.model.dart';
import '../../../../core/network/base_network_status.dart';
import '../../model/category.list.model.dart';
import '../../repository/category.repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState>  {
  final CategoryRepository repository;
  CategoryBloc(this.repository) : super(CategoryInitialState()){
    on<FetchCategoriesEvent>(_onFetchCategoriesEvent);
  }

  void _onFetchCategoriesEvent(FetchCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
    ApiResult result = await repository.fetchCategories();
    if (result.status == ApiStatus.success) {
      emit(CategoryLoadedState(result.response));
    } else {
      emit(CategoryErrorState(result.response));
    }
  }


}