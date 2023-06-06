import 'package:vendedor/domain/models/product.dart';

class ResponseProductsHome {
  const ResponseProductsHome({
    required this.listProducts,
  });

  final List<Product> listProducts;

  factory ResponseProductsHome.fromJson(List<dynamic> json) {
    final b = ResponseProductsHome(
      listProducts: List<Product>.of(json.map((x) => Product.fromJson(x))),
    );
    return b;
  }
  Future<List<Product>>? get slideProducts => null;
}
