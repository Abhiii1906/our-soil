import '../../../core/network/api_connection.dart';
import '../../../core/network/base_network.dart';
import '../../../core/network/base_network_status.dart';
import '../model/product.list.model.dart';
/*
class ProductRepository {
  final ApiConnection? api;
  ProductRepository({this.api});

  Future<ApiResult> fetchProducts({String ? orderBy}) async {
    final result = await api!.getApiConnection(
      url: BaseNetwork.generateUrl(baseUrl: BaseNetwork.productList,sort: orderBy),
      header: BaseNetwork.getJsonHeaders(),
      parseResponse: (responseBody) =>
          productListResponseModelFromJson(responseBody),
    );
    if (result.status == ApiStatus.success) {
      return result;
    }
    return result;
  }

}

 */

class ProductRepository {
  final ApiConnection? api;
  ProductRepository({this.api});

  Future<ApiResult> fetchProducts({
    String? sort,
    String? search,
    String? categoryId, // 🧩 Expecting PocketBase record ID
  }) async {
    // Dynamically build filter
    List<String> filters = [];

    if (search != null && search.isNotEmpty) {
      filters.add('name~"$search"'); // 🔍 Fuzzy search by product name
    }

    if (categoryId != null && categoryId.isNotEmpty) {
      filters.add('category="$categoryId"'); // 🎯 Exact match on category
    }

    // Combine filters with &&
    final filterString = filters.isNotEmpty ? filters.join(' && ') : null;

    final result = await api!.getApiConnection(
      url: BaseNetwork.generateUrl(
        baseUrl: BaseNetwork.productList,
        sort: sort,
        search: null,
        filter: filterString
      ),
      header: BaseNetwork.getJsonHeaders(),
      parseResponse: (responseBody) =>
          productListResponseModelFromJson(responseBody),
    );

    return result;
  }
}
