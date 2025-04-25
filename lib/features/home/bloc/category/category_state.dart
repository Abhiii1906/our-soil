part of 'category_bloc.dart';

abstract class CategoryState {}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  final CategoryListResponseModel categories;
  CategoryLoadedState(this.categories);
}

class CategoryErrorState extends CategoryState {
  final ResponseModel data;
  CategoryErrorState(this.data);
}
