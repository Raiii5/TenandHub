import 'package:flutter/material.dart';

/// Model untuk data banner/iklan yang tampil di carousel Beranda.
/// Datanya masih dummy (hardcoded) — ganti `PromoBannerData.dummyBanners`
/// dengan data asli dari Supabase (misal tabel `promotions`/`ads`) kalau
/// backend-nya sudah siap.
class PromoBannerModel {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradientColors;
  final String ctaLabel;

  const PromoBannerModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradientColors,
    this.ctaLabel = "Lihat Selengkapnya",
  });
}

class PromoBannerData {
  // TODO: Ganti dummy data ini dengan fetch dari service kalau backend siap.
  static const List<PromoBannerModel> dummyBanners = [
    PromoBannerModel(
      id: "promo-1",
      title: "War Booth Sekarang!",
      subtitle: "Amankan slot terbaikmu sebelum kehabisan",
      icon: Icons.bolt_rounded,
      gradientColors: [Color(0xFF673AB7), Color(0xFF9C6ADE)],
    ),
    PromoBannerModel(
      id: "promo-2",
      title: "Gratis Biaya Admin",
      subtitle: "Khusus booking minggu ini, buruan daftar",
      icon: Icons.local_offer_rounded,
      gradientColors: [Color(0xFFFFB300), Color(0xFFFFD54F)],
      ctaLabel: "Klaim Sekarang",
    ),
    PromoBannerModel(
      id: "promo-3",
      title: "Undang Temanmu",
      subtitle: "Dapatkan poin setiap referral berhasil",
      icon: Icons.card_giftcard_rounded,
      gradientColors: [Color(0xFF4527A0), Color(0xFF673AB7)],
      ctaLabel: "Ajak Sekarang",
    ),
  ];
}
