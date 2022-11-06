import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:empire_furniture_city/Models/basics.dart';
import 'package:empire_furniture_city/Models/product.dart';
import 'package:empire_furniture_city/UI/login.dart';
import 'package:empire_furniture_city/dialogs/add_item.dart';
import 'package:empire_furniture_city/constants.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:empire_furniture_city/item_card.dart';
import 'package:flutter/material.dart';

import '../badge.dart';

final inventoryRef = ProductCollectionReference();
final groupsRef = BasicsCollectionReference();
String selectedCat = '';

class Home extends StatefulWidget {
  const Home({
    Key? key,
    required this.title,
    required this.analytics,
    required this.observer,
  }) : super(key: key);

  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _message = '';

  var user = FirebaseAuth.instance.currentUser;
  CollectionReference usersRef = FirebaseFirestore.instance.collection('Users');
  Object? userData;

  @override
  void initState() {
    if(user != null) {
      getUserData(user!.uid);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int numCols = ((MediaQuery.of(context).size.width) / 300).round();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.businessName,
          style: TextStyle(
            color: Colors.amberAccent,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {},
            child: const Text(
              'R0',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Badge(
              value: 0.toString(),
              color: Colors.yellow,
              child: const Icon(Icons.fire_truck_outlined)),
          PopupMenuButton(
              onSelected: menuClicked,
              itemBuilder: (BuildContext context) {
                return Constants.menuItems[userData ?? 'Guest']!.map((btn) {
                  return PopupMenuItem<String>(
                    value: btn,
                    child: Text(btn),
                  );
                }).toList();
              }),
        ],
      ),
      body: Column(
        children: [
          FirestoreBuilder<BasicsDocumentSnapshot>(
            ref: groupsRef.doc('inventoryBasics'),
            builder: (context, AsyncSnapshot<BasicsDocumentSnapshot> snapshot,
                Widget? child) {
              if (snapshot.hasError) return Text(snapshot.error.toString());
              if (!snapshot.hasData) return const Text('Loading Categories...');

              // Access the UserDocumentSnapshot
              BasicsDocumentSnapshot documentSnapshot = snapshot.requireData;

              if (!documentSnapshot.exists) {
                return const Text('Shop Data does not exist.');
              }

              Basics basics = documentSnapshot.data!;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width),
                  child: Container(
                    color: Colors.blue[600],
                    child: Row(
                      children: getCategories(basics.categories),
                    ),
                  ),
                ),
              );
            },
          ),
          FirestoreBuilder(
            ref: inventoryRef.whereCategory(isEqualTo: selectedCat),
            builder: (context, AsyncSnapshot<ProductQuerySnapshot> snapshot,
                Widget? child) {
              if (snapshot.hasError) return Text(snapshot.error.toString());
              if (!snapshot.hasData) return const Text('Items Loading...');

              ProductQuerySnapshot querySnapshot = snapshot.requireData;
              List<Product> items =
              querySnapshot.docs.map((e) => e.data).toList();

              return Expanded(
                child: GridView.count(
                  crossAxisCount: numCols,
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                  shrinkWrap: true,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 200 / 250,
                  children: getItems(items),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  List<Widget> getItems(List<Product> items) {
    List<ItemCard> cards = [];
    for (int i = 0; i < items.length; i++) {
      Product item = items[i];
      ItemCard card = ItemCard(
        item: item,
      );
      cards.add(card);
    }
    return cards;
  }

  List<Widget> getCategories(List<String> categories) {
    List<Widget> catWidgets = [];
    if (selectedCat == '') {
      selectedCat = categories[0];
    }

    for (int i = 0; i < categories.length; i++) {
      String cat = categories[i];
      catWidgets.add(
        GestureDetector(
            onTap: () {
              setState(() {
                selectedCat = cat;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              decoration: BoxDecoration(
                  color: (selectedCat == cat) ? Colors.yellow : Colors.blue,
                  border: Border.all(
                      color: (selectedCat == cat) ? Colors.red : Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Text(
                cat,
                style: TextStyle(
                  color: (selectedCat == cat) ? Colors.blue : Colors.white,
                ),
              ),
            )),
      );
    }
    return catWidgets;
  }

  getUserData(String uid){
    usersRef.doc(uid).get().then((userDoc){
      if(userDoc.exists && userDoc.data() != null){
        setState(() {
          userData = userDoc.data()!;
        });
      }
    });
  }

  void setMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  Future<void> _sendAnalyticsEvent() async {
    await widget.analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{
        'string': 'string',
        'int': 42,
        'long': 12345678910,
        'double': 42.0,
        // Only strings and numbers (ints & doubles) are supported for GA custom event parameters:
        // https://developers.google.com/analytics/devguides/collection/analyticsjs/custom-dims-mets#overview
        'bool': true.toString(),
      },
    );
    setMessage('logEvent succeeded');
  }

  void menuClicked(String selected) {
    switch (selected) {
      case 'Add Item':
        showDialog(
            context: context,
            builder: (
                BuildContext context,
                ) {
              return const AddItem();
            });
        break;
      case 'Add Category': addCategory();
      break;
      case 'Add Color': addColor();
      break;
      case 'Cash Sale': addCashSale();
      break;
      case 'Lay-buy': addLayAway();
      break;
      case 'Make Payment': addPayment();
      break;
      case 'Login': Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
      break;
      case 'Logout': _signOut();
      break;
    }
  }

  void addCategory() {
    //TODO
  }

  void addColor() {
    //TODO
  }

  void addCashSale() {
    //TODO
  }

  void addLayAway() {
    //TODO
  }

  void addPayment() {
    //TODO
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}