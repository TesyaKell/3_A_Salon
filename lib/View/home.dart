import 'package:a_3_salon/View/homepage.dart';
import 'package:a_3_salon/View/profil.dart';
import 'package:a_3_salon/View/view_layanan.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  final Map? data;
  final int? discount;
  final int? targetIndex;

  const HomeView({super.key, this.data, this.discount, this.targetIndex});

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
  void initState() {
    super.initState();

    if (widget.targetIndex != null) {
      _onItemTapped(widget.targetIndex!);
    }
  }

  @override
  Widget build(BuildContext context) {
    Map? dataForm = widget.data;
    List<Widget> _widgetOptions = <Widget>[
      Center(child: HomeScreen(data: dataForm, discount: widget.discount)),
      Center(
          child: Image(image: NetworkImage('https://picsum.photos/200/300'))),
      Center(
          child: ServicesPage(
        data: dataForm,
        discount: widget.discount,
      )),
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
            label: 'Barbers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: const Color.fromRGBO(210, 0, 98, 1),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
        ),
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
