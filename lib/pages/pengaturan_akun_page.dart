import 'package:flutter/material.dart';

class PengaturanAkunPage extends StatefulWidget {
  const PengaturanAkunPage({super.key});

  @override
  State<PengaturanAkunPage> createState() => _PengaturanAkunPageState();
}

class _PengaturanAkunPageState extends State<PengaturanAkunPage> {
  int _activeView = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color(0xFF1A1A24),
                ),
                onPressed: () {
                  if (_activeView != 0) {
                    setState(() => _activeView = 0);
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildActiveView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveView() {
    switch (_activeView) {
      case 1:
        return _buildUbahSandiView();
      case 2:
        return _buildKebijakanPrivasiView();
      case 3:
        return _buildBantuanView();
      default:
        return _buildMainMenuView();
    }
  }

  Widget _buildMainMenuView() {
    return Padding(
      key: const ValueKey(0),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMenuItem(
              Icons.lock_outline_rounded,
              "Ubah Kata Sandi",
              () => setState(() => _activeView = 1),
            ),
            Divider(height: 1, color: Colors.grey[100]),
            _buildMenuItem(
              Icons.privacy_tip_outlined,
              "Kebijakan Privasi",
              () => setState(() => _activeView = 2),
            ),
            Divider(height: 1, color: Colors.grey[100]),
            _buildMenuItem(
              Icons.help_outline_rounded,
              "Bantuan & Dukungan",
              () => setState(() => _activeView = 3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFF1A1A24)),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildUbahSandiView() {
    return SingleChildScrollView(
      key: const ValueKey(1),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Ubah Kata Sandi",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A24),
            ),
          ),
          const SizedBox(height: 24),
          _buildPasswordField("Kata Sandi Lama"),
          const SizedBox(height: 16),
          _buildPasswordField("Kata Sandi Baru"),
          const SizedBox(height: 16),
          _buildPasswordField("Konfirmasi Kata Sandi Baru"),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() => _activeView = 0);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF673AB7),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                "Simpan Perubahan",
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
    );
  }

  Widget _buildPasswordField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF673AB7)),
            ),
            suffixIcon: const Icon(
              Icons.visibility_off_outlined,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKebijakanPrivasiView() {
    return SingleChildScrollView(
      key: const ValueKey(2),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Kebijakan Privasi",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A24),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Terakhir diperbarui: Juli 2026\n\n"
            "1. Pengumpulan Informasi\nKami mengumpulkan informasi yang Anda berikan secara langsung kepada kami, seperti saat Anda membuat akun, memperbarui profil, atau melakukan pemesanan booth. Informasi ini termasuk nama, alamat email, dan nomor telepon.\n\n"
            "2. Penggunaan Informasi\nInformasi yang kami kumpulkan digunakan untuk memfasilitasi transaksi pemesanan booth, mengirimkan e-tiket, serta meningkatkan pengalaman pengguna pada aplikasi TenantHub.\n\n"
            "3. Keamanan Data\nSeluruh riwayat transaksi Anda diamankan secara lokal menggunakan SQLite pada perangkat Anda. Untuk otentikasi dan pembayaran, kami bekerja sama dengan layanan pihak ketiga yang menggunakan standar enkripsi terkini.\n\n"
            "4. Perubahan Kebijakan\nKami dapat memperbarui kebijakan privasi ini dari waktu ke waktu. Kami akan memberi tahu Anda mengenai perubahan apa pun melalui notifikasi di dalam aplikasi.",
            style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.6),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildBantuanView() {
    return SingleChildScrollView(
      key: const ValueKey(3),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Bantuan & Dukungan",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A24),
            ),
          ),
          const SizedBox(height: 24),
          _buildSupportCard(
            Icons.email_outlined,
            "Email Kami",
            "support@tenanthub.id",
          ),
          const SizedBox(height: 16),
          _buildSupportCard(
            Icons.phone_outlined,
            "Telepon & WhatsApp",
            "+62 812-3456-7890",
          ),
          const SizedBox(height: 16),
          _buildSupportCard(
            Icons.help_center_outlined,
            "Pusat Bantuan",
            "faq.tenanthub.id",
          ),
        ],
      ),
    );
  }

  Widget _buildSupportCard(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF673AB7)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF1A1A24),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
