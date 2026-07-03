import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import '../models/event_model.dart';
import '../models/ticket_model.dart';
import '../cubit/ticket_cubit.dart';
import 'main_screen.dart';

class EventDetailPage extends StatefulWidget {
  final EventModel event;
  final String imageUrl;
  final String basePrice;
  final String eventDate;

  const EventDetailPage({
    super.key,
    required this.event,
    required this.imageUrl,
    required this.basePrice,
    required this.eventDate,
  });

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  Map<String, dynamic>? _selectedBooth;

  void _selectBooth(String name, int price) {
    setState(() {
      _selectedBooth = {"name": name, "price": price};
    });
  }

  void _showPaymentBottomSheet() {
    if (_selectedBooth == null) return;
    String selectedPayment = "QRIS";

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Metode Pembayaran",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A1A24),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildPaymentOption(
                    "QRIS",
                    Icons.qr_code_2_rounded,
                    selectedPayment,
                    () => setModalState(() => selectedPayment = "QRIS"),
                  ),
                  _buildPaymentOption(
                    "Virtual Account (VA)",
                    Icons.account_balance_rounded,
                    selectedPayment,
                    () => setModalState(
                      () => selectedPayment = "Virtual Account (VA)",
                    ),
                  ),
                  _buildPaymentOption(
                    "E-Wallet",
                    Icons.account_balance_wallet_rounded,
                    selectedPayment,
                    () => setModalState(() => selectedPayment = "E-Wallet"),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(color: Colors.red),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            "Batal",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _processTransaction(selectedPayment),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF673AB7),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "Bayar",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPaymentOption(
    String title,
    IconData icon,
    String selected,
    VoidCallback onTap,
  ) {
    bool isSelected = title == selected;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF673AB7).withOpacity(0.05)
              : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF673AB7) : Colors.grey[200]!,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF673AB7) : Colors.grey[400],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? const Color(0xFF673AB7) : Colors.black87,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle_rounded, color: Color(0xFF673AB7)),
          ],
        ),
      ),
    );
  }

  Future<void> _processTransaction(String paymentMethod) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          const Center(child: CircularProgressIndicator(color: Colors.white)),
    );
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.pop(context);
    Navigator.pop(context);

    String orderId = "ORD-${Random().nextInt(900000) + 100000}";
    String trxId = "${Random().nextInt(90000) + 10000}";

    final newTicket = TicketModel(
      id: orderId,
      trxId: trxId,
      title: widget.event.title,
      date: widget.eventDate,
      time: "08:00 WIB",
      location: widget.event.location,
      image: widget.imageUrl,
      boothName: _selectedBooth!["name"],
      price:
          "Rp ${_selectedBooth!["price"].toString().replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.')}",
      status: "Berhasil",
      paymentMethod: paymentMethod,
    );

    context.read<TicketCubit>().addTicket(newTicket);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreen(initialIndex: 2),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    String displayPrice = _selectedBooth == null
        ? widget.basePrice
        : "Rp ${_selectedBooth!["price"].toString().replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.')}";

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
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(widget.imageUrl, fit: BoxFit.cover),
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
                      Text(
                        widget.event.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1A1A24),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildInfoRow(
                        Icons.calendar_today_rounded,
                        widget.eventDate,
                        "08:00 - Selesai WIB",
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(
                        Icons.location_on_rounded,
                        widget.event.location,
                        "Sesuai Detail Event",
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        "Pilih Tenant / Booth",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildBoothCard("Booth Reguler (2x2m)", 350000, true),
                      const SizedBox(height: 12),
                      _buildBoothCard("Booth VIP (3x3m)", 750000, true),
                      const SizedBox(height: 12),
                      _buildBoothCard("Booth VVIP (4x4m)", 1500000, false),
                      const SizedBox(height: 100),
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
                      _selectedBooth == null ? "Mulai dari" : "Total Bayar",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      displayPrice,
                      style: const TextStyle(
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
                  onPressed: _selectedBooth == null
                      ? null
                      : _showPaymentBottomSheet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF673AB7),
                    disabledBackgroundColor: Colors.grey[300],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
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

  Widget _buildInfoRow(IconData icon, String title, String subtitle) {
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
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBoothCard(String name, int price, bool isAvailable) {
    bool isSelected = _selectedBooth != null && _selectedBooth!["name"] == name;
    String formattedPrice =
        "Rp ${price.toString().replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.')}";

    return InkWell(
      onTap: isAvailable ? () => _selectBooth(name, price) : null,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF673AB7).withOpacity(0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF673AB7) : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isAvailable
                    ? (isSelected ? const Color(0xFF673AB7) : Colors.grey[100])
                    : Colors.grey[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.storefront_rounded,
                color: isAvailable
                    ? (isSelected ? Colors.white : Colors.black87)
                    : Colors.grey[300],
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
                    formattedPrice,
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
            if (isSelected)
              const Icon(Icons.check_circle_rounded, color: Color(0xFF673AB7)),
            if (!isAvailable)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Habis",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
