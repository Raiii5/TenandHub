import 'package:flutter/material.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'jadwal_page.dart';
import 'tiket_page.dart';
import 'riwayat_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Ini list halaman yang bakal ganti-ganti pas menu bawah diklik
  final List<Widget> _pages = [
    const HomePage(),
    const JadwalPage(),
    const TiketPage(),
    const RiwayatPage(),
    const ProfilePage(),
  ];
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFF673AB7).withOpacity(0.15),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: Color(0xFF673AB7)),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today, color: Color(0xFF673AB7)),
            label: 'Jadwal',
          ),
          NavigationDestination(
            icon: Icon(Icons.confirmation_number_outlined),
            selectedIcon: Icon(
              Icons.confirmation_number,
              color: Color(0xFF673AB7),
            ),
            label: 'Tiket',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_rounded),
            selectedIcon: Icon(Icons.history, color: Color(0xFF673AB7)),
            label: 'Riwayat',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person, color: Color(0xFF673AB7)),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
