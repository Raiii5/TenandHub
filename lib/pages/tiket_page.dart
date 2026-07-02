import 'package:flutter/material.dart';

class TiketPage extends StatelessWidget {
  const TiketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF673AB7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Tiket Saya',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(24, 32, 24, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kode Pemesanan : TKT-88921\nBazaar Kuliah Akhir Semester",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.black87,
                              height: 1.3,
                            ),
                          ),
                          SizedBox(height: 32),
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  "Anrai Harika",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "No. Telp: 0812-XXXX-XXXX",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: List.generate(
                          30,
                          (index) => Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              height: 2,
                              color: index % 2 == 0
                                  ? Colors.transparent
                                  : Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(24, 24, 24, 40),
                      child: Column(
                        children: [
                          Text(
                            "Pindai kode ini di\npintu masuk",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.grey,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 20),
                          Icon(
                            Icons.qr_code_2,
                            size: 200,
                            color: Colors.black87,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: -20,
                top: 200,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF673AB7),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                right: -20,
                top: 200,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF673AB7),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
