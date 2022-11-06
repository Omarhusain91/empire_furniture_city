import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  Product(this.setItems,
      {required this.itemType,
      required this.category,
      required this.qty,
      required this.colors,
      required this.cashPrice,
      required this.name,
      required this.description,
      required this.img,
      required this.cost,
      required this.price}) {
    _$assertProduct(this);
  }

  final String name;
  final String description;
  final String img;
  final String category;
  final int qty;
  final Map<String, int> colors;
  @Min(0)
  final int cost;
  @Min(0)
  final int price;
  @Min(0)
  final int cashPrice;
  final String itemType;
  final List<String>? setItems;
}

@Collection<Product>('Inventory')
final inventoryRef = ProductCollectionReference();
