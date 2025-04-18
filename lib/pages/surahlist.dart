import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors.dart';
import '../models/surah.dart';
import '../services/quranapi.dart';
import '../widgets/surahcard.dart';

class SurahList extends StatefulWidget {
  const SurahList({super.key});

  @override
  State<SurahList> createState() => _SurahListState();
}

class _SurahListState extends State<SurahList> {
  late Future<List<Surah>> _surahList;

  @override
  void initState() {
    super.initState();
    _surahList = QuranApi.fetchSurahList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Daftar Surah',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<Surah>>(
        future: _surahList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat data', style: TextStyle(color: text)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada data', style: TextStyle(color: text)));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return SurahCard(
                    surah: snapshot.data![index],
                );
              },
            );
          }
        },
      ),
    );
  }
}