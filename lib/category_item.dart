import 'package:empire_furniture_city/constants.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String cat;
  final bool isSelected;
  const CategoryItem({Key? key, required this.cat, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
            // selectedCat = true;
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: Constants.betweenSpace, horizontal: Constants.betweenSpace),
          padding: const EdgeInsets.symmetric(vertical: Constants.betweenSpace, horizontal: Constants.betweenSpace),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Text(
            cat,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.white,
            ),
          ),
        ));
  }
}
