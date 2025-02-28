import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/inh.dart';

/// Flutter code sample for [BottomNavigationBar].

void main() => runApp(const BottomNavigationBarExampleApp());

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: BottomNavigationBarExample());
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    PieChartSample1(),
    BarChartSample5(),
    Text('Химсостав', style: optionStyle),
    Text('Отчёты', style: optionStyle),
    Text('Чеки', style: optionStyle),
    Text('Профиль', style: optionStyle),
    Text('Динамика ИЗП', style: optionStyle),
    Text('Динамика БЖУ', style: optionStyle),
    Text('Динамика калорий', style: optionStyle),
    Text('Дефициты', style: optionStyle),
    Text('Нутрициологи', style: optionStyle)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int checkindex(int index){
    if (index <= 5)
      return index;
    else
      return 0;
  }


  @override
  Widget build(BuildContext context) {
    const TextStyle titlesStyle =  TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
    const List<Text> titles = [
      Text("Рацион по чекам", style: titlesStyle,),
      Text("Индекс здорового питания", style: titlesStyle,),
      Text("Химсостав рациона", style: titlesStyle,),
      Text("Отчёты", style: titlesStyle,),
      Text("Добавление чеков", style: titlesStyle,),
      Text("Профиль", style: titlesStyle,),
      Text("Динамика ИЗП", style: titlesStyle,),
      Text("Динамика БЖУ", style: titlesStyle,),
      Text("Динамика калорий", style: titlesStyle,),
      Text("Дефициты", style: titlesStyle,),
      Text("Нутрициологи", style: titlesStyle,),
    ];
    return Scaffold(
      backgroundColor: Color.fromRGBO(254, 254, 254, 1),
      appBar: AppBar(
        title: titles[_selectedIndex],
        centerTitle: true,
        backgroundColor: Colors.lightGreen, 
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.smiley), label: 'ИЗП'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.lab_flask), label: 'Химсостав'),
          BottomNavigationBarItem(icon: Icon(Icons.insert_chart_outlined_outlined), label: 'Отчёты'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Чеки'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: 'Профиль'),
        ],
        currentIndex: checkindex(_selectedIndex),
        selectedItemColor: Colors.lightGreen,
        unselectedItemColor: Colors.blueGrey,
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            // Container(
            //   height: 60,
            //   padding: const EdgeInsets.only(top: 30),
            //   child: Center(
            //     child: Column(
            //       children: [
                    
            //         Text('GrocerDiet_01', style: TextStyle(height: 0, fontSize: 18),),
            //       ],
            //     ),
            //   ),
            // ),
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightGreen),
              child: Text('GrocerDiet_01'),
            ),
            ListTile(
              title: const Text('Динамика ИЗП'),
              selected: _selectedIndex == 6,
              onTap: () {
                // Update the state of the app
                _onItemTapped(6);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Динамика БЖУ'),
              selected: _selectedIndex == 7,
              onTap: () {
                // Update the state of the app
                _onItemTapped(7);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Динамика калорий'),
              selected: _selectedIndex == 8,
              onTap: () {
                // Update the state of the app
                _onItemTapped(8);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Дефициты'),
              selected: _selectedIndex == 9,
              onTap: () {
                // Update the state of the app
                _onItemTapped(9);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),            
            ListTile(
              title: const Text('Нутрициологи'),
              selected: _selectedIndex == 10,
              onTap: () {
                // Update the state of the app
                _onItemTapped(10);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}