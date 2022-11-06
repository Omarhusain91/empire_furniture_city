import 'dart:io';

import 'package:empire_furniture_city/Models/product.dart';
import 'package:empire_furniture_city/constants.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Models/basics.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class ApiImage {
  final String imageUrl;
  final String id;

  ApiImage({
    required this.imageUrl,
    required this.id,
  });
}

class _AddItemState extends State<AddItem> {
  final storage = FirebaseStorage.instance;
  final _formKey = GlobalKey<FormBuilderState>();
  final groupsRef = BasicsCollectionReference();
  List<String> groups = ['Wardrobes', 'Couches'];
  List<String> types = ['Item', 'Set'];
  Map<String, String> colors = {};
  List<String> itemColors = [];
  List<String> setItems = [];
  bool isLoading = false;
  int qty = 0;

  Future<void> saveItem() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() {
        isLoading = true;
      });
      Map<String, dynamic>? data = _formKey.currentState?.value;
      var img = data!['img'][0];
      var imgRef = storage.ref().child('Inventory/${data['name']}.jpg');
      try {
        await imgRef.putFile(File(img.path)).then((p0) {
          p0.ref.getDownloadURL().then((url) {
            List<String> colors = data['colors'];
            Map<String, int> colorItems = {};
            colors.map((e) => colorItems.addAll({e: 0}));
            Product item = Product(data['setItems'],
                category: data['category'],
                qty: qty,
                colors: colorItems,
                cashPrice: int.parse(data['cashPrice']),
                name: data['name'],
                description: data['description'],
                img: url,
                cost: int.parse(data['cost']),
                price: int.parse(data['price']),
                itemType: data['type']);
            inventoryRef
                .add(item)
                .then((value) => debugPrint(value.toString()));
          });
        });
      } on FirebaseException catch (e) {
        debugPrint(e.message);
        setState(() {
          isLoading = false;
        });
      }
    } else {
      debugPrint('validation failed');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    groupsRef.doc('inventoryBasics').get().then((value) {
      if (value.exists) {
        Basics? basicData = value.data;
        setState(() {
          groups = basicData!.categories;
          colors = basicData.colors;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Inventory Item'),
      ),
      body: SingleChildScrollView(
        child: !isLoading
            ? FormBuilder(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(Constants.normalSpace),
                  child: Column(
                    children: [
                      FormBuilderDropdown<String>(
                        name: 'category',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          hintText: 'Select Category',
                          border: OutlineInputBorder(),
                        ),
                        items: groups
                            .map((group) => DropdownMenuItem<String>(
                                  value: group,
                                  child: Text(group),
                                ))
                            .toList(),
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(errorText: 'Please Select a Category')]),
                      ),
                      const SizedBox(
                        height: Constants.normalSpace,
                      ),
                      FormBuilderDropdown<String>(
                        name: 'type',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Type',
                          border: OutlineInputBorder(),
                        ),
                        items: types
                            .map((typ) => DropdownMenuItem<String>(
                                  value: typ,
                                  child: Text(typ),
                                ))
                            .toList(),
                        initialValue: types[0],
                        onChanged: (typ) {
                          if (typ != null) {
                            //TODO Ask for set items
                          }
                        },
                      ),
                      const SizedBox(
                        height: Constants.normalSpace,
                      ),
                      FormBuilderTextField(
                        name: 'name',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Item Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(errorText: 'Name required!')]),
                      ),
                      const SizedBox(
                        height: Constants.normalSpace,
                      ),
                      FormBuilderTextField(
                        name: 'description',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Item Description',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: Constants.normalSpace,
                      ),
                      FormBuilderTextField(
                        name: 'cost',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Cost Price',
                          border: OutlineInputBorder(),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(errorText: 'Numbers Only')
                        ]),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: Constants.normalSpace,
                      ),
                      FormBuilderTextField(
                        name: 'price',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Normal Price',
                          border: OutlineInputBorder(),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(errorText: 'Numbers Only')
                        ]),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: Constants.normalSpace,
                      ),
                      FormBuilderTextField(
                        name: 'cashPrice',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Cash Price',
                          border: OutlineInputBorder(),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(errorText: 'Numbers Only')
                        ]),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: Constants.normalSpace,
                      ),
                      FormBuilderFilterChip<String>(
                        name: 'colors',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Colors',
                          hintText: 'Select Colors',
                          border: OutlineInputBorder(),
                        ),
                        options: colors.values
                            .map((color) => FormBuilderChipOption<String>(
                                  value: color,
                                  child: Text(color),
                                ))
                            .toList(),
                        onChanged: (colors) {
                          if (colors != null) {
                            colors.isNotEmpty
                                ? itemColors = colors
                                : itemColors = itemColors;
                          }
                        },
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.minLength(1, errorText: 'Please select at least one color')]),
                      ),
                      const SizedBox(
                        height: Constants.normalSpace,
                      ),
                      FormBuilderImagePicker(
                        name: 'img',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        displayCustomType: (obj) =>
                            obj is ApiImage ? obj.imageUrl : obj,
                        decoration: const InputDecoration(
                          labelText: 'Pick Photos',
                        ),
                        showDecoration: false,
                        maxImages: 1,
                        previewAutoSizeWidth: true,
                      ),
                      const SizedBox(
                        height: Constants.normalSpace,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          saveItem().then((value) {
                            setState(() {
                              isLoading = false;
                            });
                          });
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const LoadingIndicator(size: 12, borderWidth: 4),
      ),
    );
  }
}
