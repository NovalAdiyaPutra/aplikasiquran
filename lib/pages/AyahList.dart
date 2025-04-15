import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/Ayah.dart';
import '../Colors.dart';
// import '../pages/AyahDetail.dart';
import '../services/QuranApi.dart';

class AyahList extends StatefulWidget {
  final int surahNumber;
  const AyahList({super.key, required this.surahNumber});

  @override
  State<AyahList> createState() => _AyahListState();
}

class _AyahListState extends State<AyahList> {
  List<Ayah> ayahList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAyahData();
  }

  Future<void> fetchAyahData() async {
    try {
      final fetchedAyat = await QuranApi.fetchAyatBySurah(widget.surahNumber);
      setState(() {
        ayahList = fetchedAyat;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching ayat: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Daftar Ayat', style: GoogleFonts.poppins(color: Colors.white)),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ayahList.isEmpty
          ? const Center(
          child: Text('Tidak ada ayat ditemukan',
              style: TextStyle(color: Colors.white)))
          : ListView.builder(
        itemCount: ayahList.length,
        itemBuilder: (context, index) {
          final ayah = ayahList[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: gray,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nomor Ayat sebagai lingkaran
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: primary,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${ayah.numberInSurah}',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Konten Ayat (Arab, Terjemahan, Informasi)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          ayah.arabicText,
                          style: GoogleFonts.amiri(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ayah.translation,
                                style: GoogleFonts.poppins(
                                  color: text,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Wrap(
                                spacing: 8,
                                children: [
                                  if (ayah.ruku != null)
                                    InfoBadge(label: 'Ruku: ${ayah.ruku}'),
                                  if (ayah.manzil != null)
                                    InfoBadge(label: 'Manzil: ${ayah.manzil}'),
                                  if (ayah.page != null)
                                    InfoBadge(label: 'Page: ${ayah.page}'),
                                  if (ayah.sajda == true)
                                    const InfoBadge(
                                      label: '⚠️ Sajda',
                                      color: Colors.orangeAccent,
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class InfoBadge extends StatelessWidget {
  final String label;
  final Color color;

  const InfoBadge({
    super.key,
    required this.label,
    this.color = Colors.white24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
  }
}
