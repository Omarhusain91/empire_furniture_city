import 'package:empire_furniture_city/Models/product.dart';
import 'package:empire_furniture_city/constants.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  final Product item;

  const ItemCard({Key? key, required this.item}) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    bool networkError = false;
    return GestureDetector(
      onTap: () {
        debugPrint(widget.item.name);
      },
      child: Container(
        color: Colors.grey[200],
        height: 250,
        width: 200,
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                widget.item.img,
                width: double.infinity,
                fit: BoxFit.fill,
                errorBuilder: (context, obj, stack){
                  return Image.asset('soccer.png');
                },
              ),
            ),
            Container(
              color: Colors.yellow,
              padding: const EdgeInsets.all(Constants.normalSpace),
              child: Column(
                children: [
                  Text(widget.item.name),
                  Row(
                    children: [
                      // TextButton(onPressed: () {}, child: const Text('Add')),
                      Text(
                        'R${widget.item.price}',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}