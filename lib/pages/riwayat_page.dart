import 'package:flutter/material.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Riwayat Pemesanan',
            style: TextStyle(
              color: Color(0xFF1A1A24),
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Color(0xFF673AB7),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF673AB7),
            indicatorWeight: 3,
            tabs: [
              Tab(text: "Selesai"),
              Tab(text: "Dibatalkan"),
            ],
          ),
        ),
        body: TabBarView(children: [_buildHistoryList(), _buildEmptyState()]),
      ),
    );
  }

  Widget _buildHistoryList() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildHistoryCard(
          title: "Bazaar Kuliah Akhir Semester",
          date: "27 Dec 2026",
          status: "Berhasil",
          price: "Gratis",
          orderId: "TKT-88921",
          isFree: true,
        ),
        const SizedBox(height: 16),
        _buildHistoryCard(
          title: "UI/UX & React.js Masterclass",
          date: "15 Nov 2026",
          status: "Selesai",
          price: "Rp 150.000",
          orderId: "TKT-33412",
          isFree: false,
        ),
      ],
    );
  }

  Widget _buildHistoryCard({
    required String title,
    required String date,
    required String status,
    required String price,
    required String orderId,
    required bool isFree,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER CARD (ID & STATUS)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ID: $orderId",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: Color(0xFFF0F0F0)),
          ),

          // DETAIL EVENT
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1A24),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.calendar_today_rounded,
                size: 14,
                color: Colors.grey[400],
              ),
              const SizedBox(width: 6),
              Text(
                date,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // HARGA & TOMBOL
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Pembayaran",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: isFree ? Colors.black87 : const Color(0xFF673AB7),
                    ),
                  ),
                ],
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF673AB7),
                  side: const BorderSide(color: Color(0xFF673AB7)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  "E-Tiket",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_rounded, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            "Belum ada riwayat",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
