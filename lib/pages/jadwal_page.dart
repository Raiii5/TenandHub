import 'package:flutter/material.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  int _selectedDateIndex = 0;

  final List<Map<String, String>> _dates = [
    {"day": "Mon", "date": "23"},
    {"day": "Tue", "date": "24"},
    {"day": "Wed", "date": "25"},
    {"day": "Thu", "date": "26"},
    {"day": "Fri", "date": "27"},
    {"day": "Sat", "date": "28"},
    {"day": "Sun", "date": "29"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(24, 20, 24, 16),
                    child: Text(
                      "Jadwal Event",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1A1A24),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 85,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: _dates.length,
                      itemBuilder: (context, index) {
                        final isSelected = _selectedDateIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDateIndex = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 50,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF673AB7)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: isSelected
                                  ? null
                                  : Border.all(color: Colors.grey[200]!),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF673AB7,
                                        ).withOpacity(0.4),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _dates[index]["day"]!,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: isSelected
                                        ? Colors.white70
                                        : Colors.grey[400],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _dates[index]["date"]!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF1A1A24),
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
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Bazaar Kuliah Akhir Semester",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1A1A24),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Auditorium UNPAM VIKTOR",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAFAFC),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "Friday, 27 Dec 2026",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          const Text(
                            "Gratis",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF1A1A24),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF673AB7),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "Detail Jadwal",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
