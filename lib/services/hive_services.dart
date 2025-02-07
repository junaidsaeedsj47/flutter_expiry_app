import 'package:hive_flutter/hive_flutter.dart';
import '../models/scanned_product_model.dart';

class HiveService {
  static late Box<ScannedProduct> _productBox;

  /// Initialize Hive
  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ScannedProductAdapter());
    _productBox = await Hive.openBox<ScannedProduct>('scanned_products');
  }

  /// Add Product
  static Future<void> addProduct(ScannedProduct product) async {
    await _productBox.put(product.name, product);
  }

  /// Get All Products
  static List<ScannedProduct> getProducts() {
    return _productBox.values.toList();
  }

  /// Delete Product
  static Future<void> deleteProduct(String productName) async {
    await _productBox.delete(productName);
  }

}