import 'package:flutter/material.dart';
import '../models/event_model.dart';

class EventDetailPage extends StatelessWidget {
  final EventModel event;

  const EventDetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: const Color(0xFF673AB7),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share_rounded, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.bookmark_border_rounded,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=800&auto=format&fit=crop',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -24),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF673AB7).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "✨ Live Event",
                          style: TextStyle(
                            color: Color(0xFF673AB7),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        event.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1A1A24),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildInfoRow(
                        icon: Icons.calendar_today_rounded,
                        title: "1 Juli 2026",
                        subtitle: "08:00 - Selesai WIB",
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(
                        icon: Icons.location_on_rounded,
                        title: event.location,
                        subtitle: "Tangerang Selatan, Banten",
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        "Daftar Tenant / Booth",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1A1A24),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildBoothCard(
                        name: "Booth Reguler (2x2m)",
                        price: "Rp 150.000",
                        status: "Tersedia",
                        isAvailable: true,
                      ),
                      const SizedBox(height: 12),
                      _buildBoothCard(
                        name: "Booth VIP (3x3m)",
                        price: "Rp 350.000",
                        status: "Penuh",
                        isAvailable: false,
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        "Deskripsi Event",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1A1A24),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Bazaar terbesar semester ini! Kesempatan emas bagi para pengusaha muda dan mahasiswa untuk memamerkan produk terbaiknya. Lokasi strategis dengan target lebih dari 5000 pengunjung selama event berlangsung.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mulai dari",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Rp 150.000",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1A1A24),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF673AB7),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Pesan Booth",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFC),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: const Color(0xFF673AB7), size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A24),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(fontSize: 13, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBoothCard({
    required String name,
    required String price,
    required String status,
    required bool isAvailable,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[100]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isAvailable
                  ? const Color(0xFF673AB7).withOpacity(0.1)
                  : Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.storefront_rounded,
              color: isAvailable ? const Color(0xFF673AB7) : Colors.grey[400],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isAvailable
                        ? const Color(0xFF1A1A24)
                        : Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isAvailable
                        ? const Color(0xFF673AB7)
                        : Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isAvailable ? Colors.green[50] : Colors.red[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isAvailable ? Colors.green : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
