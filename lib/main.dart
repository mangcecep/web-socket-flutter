import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_flutter/view/history_view.dart';
import 'package:web_socket_flutter/view/home_view.dart';
import 'package:web_socket_flutter/view/profile_view.dart';

void main() => runApp(const Home());

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PPLG Apps",
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  int get tabIndex => _currentIndex;
  set tabIndex(int v) {
    _currentIndex = v;
    setState(() {});
  }

  final tabs = [
    const HomeView(),
    const HistoryView(),
    const ProfileView(),
  ];
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [],
          title: const Text(
            "PPLG Apps",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 72, 3, 248),
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: (v) {
            tabIndex = v;
          },
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              // color: Colors.red,
              child: const HomeView(),
            ),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              // color: Colors.green,
              child: const HistoryView(),
            ),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              // color: Colors.blue,
              child: const ProfileView(),
            ),
          ],
        ),
        bottomNavigationBar: CircleNavBar(
          activeIcons: const [
            Icon(Icons.person, color: Colors.deepPurple),
            Icon(Icons.home, color: Colors.deepPurple),
            Icon(Icons.favorite, color: Colors.deepPurple),
          ],
          inactiveIcons: const [
            Text("My"),
            Text("Home"),
            Text("Like"),
          ],
          color: Colors.white,
          height: 60,
          circleWidth: 60,
          activeIndex: _currentIndex,
          onTap: (index) {
            _currentIndex = index;
            pageController.jumpToPage(index);
          },
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
          cornerRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(24),
            bottomLeft: Radius.circular(24),
          ),
          shadowColor: Colors.deepPurple,
          elevation: 10,
        )
        //  BottomNavigationBar(
        //   currentIndex: _currentIndex,
        //   onTap: (index) {
        //     setState(() => _currentIndex = index);
        //   },
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Home',
        //       activeIcon: Icon(
        //         Icons.build_outlined,
        //       ),
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.history),
        //       label: 'History',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person),
        //       label: 'Profile',
        //     ),
        //   ],
        // ),
        );
  }
}
