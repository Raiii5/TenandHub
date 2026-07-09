import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../services/dummy_booking.dart';
import 'event_detail_page.dart';
import 'notification_page.dart';
import 'profile_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _kotaLokasi = "Jakarta Barat";
  int _selectedCategoryIndex = 0;
  String _searchQuery = "";
  final List<String> _categories = [
    "All Events",
    "Live Event",
    "Workshop",
    "Art Exhibition",
    "Bazaar",
  ];

  void _ubahLokasi() {
    TextEditingController lokasiController = TextEditingController(
      text: _kotaLokasi,
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Tentukan Lokasi",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: TextField(
            controller: lokasiController,
            decoration: InputDecoration(
              hintText: "Masukkan Kabupaten/Kota",
              suffixText: ", Indonesia",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                if (lokasiController.text.isNotEmpty) {
                  setState(() {
                    _kotaLokasi = lokasiController.text;
                  });
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF673AB7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Simpan",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final filteredEvents = DummyBooking.allEvents.where((evt) {
      final matchesCategory =
          _selectedCategoryIndex == 0 ||
          evt["category"] == _categories[_selectedCategoryIndex];
      final matchesSearch = evt["title"].toString().toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      return matchesCategory && matchesSearch;
    }).toList();

    final nearestEvents = filteredEvents.take(2).toList();
    final recommendedEvents = filteredEvents.skip(2).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF673AB7),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _ubahLokasi,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Lokasi Saat Ini",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "$_kotaLokasi, Indonesia",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.white.withOpacity(0.7),
                              size: 18,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NotificationPage(),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.notifications_none_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProfileDetailPage(),
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person_rounded,
                            color: Color(0xFF673AB7),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search event, category, or location...",
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                    icon: Icon(Icons.search_rounded, color: Colors.grey[400]),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final isActive = index == _selectedCategoryIndex;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategoryIndex = index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _categories[index],
                            style: TextStyle(
                              color: isActive ? Colors.white : Colors.white54,
                              fontWeight: isActive
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (isActive)
                            Container(
                              height: 2,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFFAFAFC),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: filteredEvents.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              size: 64,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Event tidak ditemukan",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _handleRefresh,
                        color: const Color(0xFF673AB7),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(top: 24, bottom: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (nearestEvents.isNotEmpty) ...[
                                _buildSectionHeader(
                                  _searchQuery.isEmpty
                                      ? "NEAREST EVENT"
                                      : "HASIL PENCARIAN",
                                ),
                                const SizedBox(height: 16),
                                _buildEventList(nearestEvents),
                              ],
                              if (recommendedEvents.isNotEmpty) ...[
                                const SizedBox(height: 32),
                                _buildSectionHeader("RECOMMENDED EVENTS"),
                                const SizedBox(height: 16),
                                _buildEventList(recommendedEvents),
                              ],
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          Text(
            "See All",
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventList(List<Map<String, dynamic>> events) {
    return SizedBox(
      height: 290,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final evt = events[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailPage(
                    event: EventModel(
                      id: evt["id"],
                      title: evt["title"],
                      date: DateTime.now(),
                      location: evt["location"],
                      eoId: "eo_dummy_123",
                    ),
                    imageUrl: evt["image"],
                    basePrice: evt["price"],
                    eventDate: evt["date"],
                  ),
                ),
              );
            },
            child: Container(
              width: 220,
              margin: const EdgeInsets.only(right: 16, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: NetworkImage(evt["image"]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              evt["category"].toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            evt["title"],
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      evt["price"],
                      style: const TextStyle(
                        color: Color(0xFF673AB7),
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            evt["location"],
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
