import 'package:hk_clothes/models/product/product.dart';
import 'package:hk_clothes/models/product/product_sale.dart';
import 'package:hk_clothes/models/product/product_size.dart';
import 'package:hk_clothes/models/product/size.dart';

class ProductDetail {
  Product item;
  List<ProductSize> sizes;
  SizeProduct selectSize;
  ProductSale sale;
}
