import 'package:a_3_salon/View/homepage.dart';
import 'package:a_3_salon/View/profil.dart';
import 'package:a_3_salon/View/view_layanan.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  final Map? data;
  const HomeView({super.key, this.data});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map? dataForm = widget.data;
    List<Widget> _widgetOptions = <Widget>[
      Center(child: HomeScreen(data: dataForm)),
      Center(
          child: Image(image: NetworkImage('https://picsum.photos/200/300'))),
      Center(child: ServicesPage(data: dataForm)),
      Center(child: ProfileView(data: dataForm)),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Barber',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Service',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
