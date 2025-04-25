
import '../../../core/network/api_connection.dart';
import '../../../core/network/base_network.dart';
import '../../../core/network/base_network_status.dart';
import '../model/product.detail.response.model.dart';

class ProjectDetailRepository {
  final ApiConnection? api;
  ProjectDetailRepository({this.api});

  Future<ApiResult> fetchProductDetail({String ? id}) async {
    final result = await api!.getApiConnection(
      url: '${BaseNetwork.productList}/$id',
      header: BaseNetwork.getJsonHeaders(),
      parseResponse: (responseBody) =>
          productDetailResponseModelFromJson(responseBody),
    );
    if (result.status == ApiStatus.success) {
      return result;
    }
    return result;
  }
}