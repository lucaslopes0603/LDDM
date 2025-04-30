import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  const HomeScreen({required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    _pages = [
      Center(child: Text("Bem-vindo, ${widget.userName}!", style: TextStyle(fontSize: 24))),
      ListView(
        children: List.generate(
            10, (index) => ListTile(title: Text("Item ${index + 1}"))),
      ),
      FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          final prefs = snapshot.data as SharedPreferences;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text("Nome: ${prefs.getString('name') ?? ''}")),
              ListTile(title: Text("Email: ${prefs.getString('email') ?? ''}")),
              ListTile(title: Text("Senha: ${prefs.getString('password') ?? ''}")),
            ],
          );
        },
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("App Flutter")),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "List"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
