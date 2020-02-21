import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_ui/Components/destination_carousel.dart';
import 'package:travel_ui/Components/hotel_carousel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentTab = 0;
  int _selected = 0;
  List<IconData> _icons = [
    FontAwesomeIcons.plane,
    FontAwesomeIcons.bed,
    FontAwesomeIcons.walking,
    FontAwesomeIcons.biking,
  ];
  Widget _buildIcon(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          this._selected = index;
          // 如果要替换相关页面也可以在这里实现
        });
      },
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: this._selected == index
              ? Theme.of(context).accentColor
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(30), //NOTE: 为啥不是 50
        ),
        child: Icon(
          this._icons[index],
          size: 25,
          color: this._selected == index
              ? Theme.of(context).primaryColor
              : Colors.grey[400],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 30),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, right: 120),
                child: Text(
                  "What would you like to find?",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _icons
                    .asMap()
                    .entries
                    .map((MapEntry map) => _buildIcon(map.key))
                    .toList(),
              ),
              SizedBox(height: 20),
              DestinationCarousel(),
              HotelCarousel()
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              this._currentTab = index;
            });
          },
          currentIndex: _currentTab,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 30), title: SizedBox.shrink()),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore, size: 30), title: SizedBox.shrink()),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3064474851,1054474501&fm=26&gp=0.jpg"),
                radius: 15,
              ),
              title: SizedBox.shrink(), // Tirck !
            ),
          ],
        ),
      ),
    );
  }
}
