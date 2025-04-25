import '../../../core/network/api_connection.dart';
import '../../../core/network/base_network.dart';
import '../../../core/network/base_network_status.dart';
import '../model/category.list.model.dart';

class CategoryRepository {
  final ApiConnection? api;
  CategoryRepository({this.api});

  Future<ApiResult> fetchCategories() async {
    final result = await api!.getApiConnection(
      url: BaseNetwork.categoriesListURL,
      header: BaseNetwork.getJsonHeaders(),
      parseResponse: (responseBody) =>
          categoryListResponseModelFromJson(responseBody),
    );
    if (result.status == ApiStatus.success) {
      return result;
    }
    return result;
  }

}