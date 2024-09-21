// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'sizescaler.dart'; // SizeScaler 임포트
import '/where_alone_page.dart';
import '/home_page.dart';
import '/alone_diary_page.dart';
import '/profile_scaffold.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Page UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MainScaffold(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0; // 현재 선택된 페이지 인덱스

  // 페이지 목록
  final List<Widget> _pages = [
    WhereAlonePage(),
    HomePage(),
    AloneDiaryPage(),
    ProfileScaffold(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // 4개 이상의 아이템을 사용할 때 필요
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: SizeScaler.scaleSize(context, 24)),
            label: '나홀로 어디',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: SizeScaler.scaleSize(context, 24)),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book, size: SizeScaler.scaleSize(context, 24)),
            label: '나홀로 일지',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, size: SizeScaler.scaleSize(context, 24)),
            label: '마이페이지',
          ),
        ],
      ),
    );
  }
}
