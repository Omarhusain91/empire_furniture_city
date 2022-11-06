import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';

part 'basics.g.dart';

@JsonSerializable()
class Basics {
  Basics(this.categories, this.colors);

  final List<String> categories;
  final Map<String, String> colors;
}

@Collection<Basics>('Inventory')
final categoriesRef = BasicsCollectionReference();