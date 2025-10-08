import 'package:fetch_api/color/primary_color.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final void Function(int)? onChange;
  const BottomNavigationBarWidget({super.key, required this.onChange});

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      Icons.home,
      Icons.favorite,
      Icons.shopping_cart,
      Icons.person
    ];
    return Container(
      height: 60,
      decoration: BoxDecoration(
      color: mainColor,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(icons.length, 
          (index)=> GestureDetector(
            onTap: (){
              setState(() {
                _selectIndex = index;
              });
              widget.onChange!(index);
            },
            child: _selectIndex == index? Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 6, color: Colors.white)),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))
              ),
              child: Center(
                child: Icon(icons[index],
                color: Colors.white,
                size: 30,
                ),
              ),
            ): Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))
              ),
              child: Center(
                child: Icon(icons[index],
                color: Colors.white,
                size: 30,
                ),
              ),
            ),
        )
        ),
      ),
    );
  }
}