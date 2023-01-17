import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'scan_page.dart';
import 'home_page.dart';

void main() {
  runApp(const TabBarPrincipal ());
    
}
 
_getNombre() async{
  String nombre = await getStringName();
  print(nombre);
}

Future<String> getStringName() async {
    final prefs = await SharedPreferences.getInstance();
    var nombre = prefs.getString("nombre") ?? "null";

    return nombre;
  }


class TabBarPrincipal extends StatefulWidget {
  final  data;
  const TabBarPrincipal({
    super.key,
    this.data
    });
  @override
  State<TabBarPrincipal> createState() => _TabBarPrincipalState();
}

class _TabBarPrincipalState extends State<TabBarPrincipal> {
  int _currentPage = 0;

  void _onItemTapped(int index) {  
    setState(() {  
      _currentPage = index;  
    });  
  }  

  final screens =[
      Center( 
      child: 
      Home()
      ),
      QrCode()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Resutido"),
            backgroundColor: const Color.fromARGB(255, 4, 51, 255),
            
          ),
          body: screens[_currentPage],
          bottomNavigationBar: BottomNavigationBar(
            
           
            items: const  <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Inicio',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera),
                label: 'Escanear',
                ),
            ],
            currentIndex: _currentPage,
            onTap: _onItemTapped, 
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color.fromARGB(255, 4, 51, 255),

          ),
          
        ),
      ),
    );
  }
}

