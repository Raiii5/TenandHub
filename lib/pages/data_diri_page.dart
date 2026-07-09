import 'package:flutter/material.dart';

class DataDiriPage extends StatefulWidget {
  final String currentNama;
  final String currentEmail;

  const DataDiriPage({
    super.key,
    required this.currentNama,
    required this.currentEmail,
  });

  @override
  State<DataDiriPage> createState() => _DataDiriPageState();
}

class _DataDiriPageState extends State<DataDiriPage> {
  late TextEditingController _namaController;
  late TextEditingController _emailController;
  final TextEditingController _teleponController = TextEditingController(
    text: "0812-1122-3344",
  );

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.currentNama);
    _emailController = TextEditingController(text: widget.currentEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF1A1A24),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3E5F5),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Color(0xFF673AB7),
                              size: 50,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color(0xFF673AB7),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildTextField("Nama Lengkap", _namaController),
                    const SizedBox(height: 20),
                    _buildTextField("Email", _emailController),
                    const SizedBox(height: 20),
                    _buildTextField("Nomor Telepon", _teleponController),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, {
                            'nama': _namaController.text,
                            'email': _emailController.text,
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF673AB7),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          "Simpan Data",
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
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
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
          controller: controller,
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
          ),
        ),
      ],
    );
  }
}
