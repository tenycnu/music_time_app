import 'package:flutter/material.dart';

// --- 1. MODEL YAPISI ---
class Concert {
  final int id;
  final String title;
  final String venue;
  final String priceSahneOnu;
  final String priceNormal;
  final String date;
  final String imageUrl;
  final double rating;
  bool isFavorite;

  Concert({
    required this.id,
    required this.title,
    required this.venue,
    required this.priceSahneOnu,
    required this.priceNormal,
    required this.date,
    required this.imageUrl,
    required this.rating,
    this.isFavorite = false,
  });
}

void main() {
  runApp(const MusicTimeApp());
}

class MusicTimeApp extends StatelessWidget {
  const MusicTimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Time',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFF0F5), 
        primaryColor: const Color(0xFFE07A9A), 
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE07A9A),
          primary: const Color(0xFFE07A9A),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ConcertListScreen(),
        '/detail': (context) => const ConcertDetailScreen(),
      },
    );
  }
}

// --- 2. ANA SAYFA / ÜRÜN LİSTELEME ---
class ConcertListScreen extends StatefulWidget {
  const ConcertListScreen({super.key});

  @override
  State<ConcertListScreen> createState() => _ConcertListScreenState();
}

class _ConcertListScreenState extends State<ConcertListScreen> {
  // DartPad'in güvenlik protokollerinden %100 geçen açık kaynaklı kaliteli URL'ler:
  final List<Concert> concerts = [
    Concert(
      id: 1,
      title: 'DUMAN',
      venue: 'Harbiye Cemil Topuzlu',
      priceSahneOnu: '6500 TL',
      priceNormal: '4500 TL',
      date: '17 Haziran 2026, Çarşamba 22:00',
      imageUrl: 'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?w=500', 
      rating: 5.0,
    ),
    Concert(
      id: 2,
      title: 'YYK',
      venue: 'Jolly Joker Ankara',
      priceSahneOnu: '3500 TL',
      priceNormal: '2280 TL',
      date: '17 Haziran 2026, Çarşamba 21:00',
      imageUrl: 'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?w=500', 
      rating: 4.5,
    ),
    Concert(
      id: 3,
      title: 'MANIFEST',
      venue: 'Harbiye Cemil Topuzlu',
      priceSahneOnu: '5000 TL',
      priceNormal: '3000 TL',
      date: '18 Haziran 2026, Perşembe 21:30',
      imageUrl: 'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?w=500', 
      rating: 4.0,
    ),
    Concert(
      id: 4,
      title: 'TARKAN',
      venue: 'BJK Tüpraş Stadyumu',
      priceSahneOnu: '9000 TL',
      priceNormal: '5500 TL',
      date: '19 Haziran 2026, Cuma 21:00',
      imageUrl: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=500', // Engellenmeyen Canlı Pop/Stadyum Sanatçısı Görseli
      rating: 5.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Music Time', 
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.white)
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFE07A9A),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 4.0),
              child: Text(
                'İstanbul Concerts', 
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '17 Haziran 2026 Konserleri & Gündemdeki Sanatçılar', 
                style: TextStyle(fontSize: 13, color: Color(0xFFB05C77), fontWeight: FontWeight.w500)
              ),
            ),
            const SizedBox(height: 14),
            
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                childAspectRatio: 0.74,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
              ),
              itemCount: concerts.length,
              itemBuilder: (context, index) {
                final concert = concerts[index];
                return Card(
                  color: Colors.white,
                  elevation: 3,
                  shadowColor: const Color(0xFFE07A9A).withOpacity(0.2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detail',
                        arguments: concert,
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Image.network(
                                concert.imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white.withOpacity(0.9),
                                  radius: 18,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                      concert.isFavorite ? Icons.favorite : Icons.favorite_border,
                                      color: const Color(0xFFE07A9A),
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        concert.isFavorite = !concert.isFavorite;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                concert.title,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                concert.venue,
                                style: const TextStyle(color: Colors.grey, fontSize: 11),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${concert.priceNormal} \'den başlayan',
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE07A9A), fontSize: 12),
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
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFE07A9A),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorilerim'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Geçmiş'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Hesabım'),
        ],
      ),
    );
  }
}

// --- 3. DİNAMİK ÜRÜN DETAY EKRANI ---
class ConcertDetailScreen extends StatelessWidget {
  const ConcertDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final concert = ModalRoute.of(context)!.settings.arguments as Concert;

    return Scaffold(
      appBar: AppBar(
        title: Text(concert.title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFFE07A9A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              concert.imageUrl,
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(concert.title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.pinkAccent, size: 20),
                          const SizedBox(width: 4),
                          Text('${concert.rating} (202 Değerlendirme)', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Bilet Seçenekleri', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 12),
                  
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: const Icon(Icons.stars, color: Color(0xFFE07A9A)),
                      title: const Text('Sahne Önü Giriş', style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text('${concert.date}\n${concert.venue}', style: const TextStyle(fontSize: 12)),
                      trailing: Text(
                        concert.priceSahneOnu,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFFE07A9A)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: const Icon(Icons.confirmation_number, color: Colors.grey),
                      title: const Text('Normal Giriş', style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text('${concert.date}\n${concert.venue}', style: const TextStyle(fontSize: 12)),
                      trailing: Text(
                        concert.priceNormal,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE07A9A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 2,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          title: const Text('İşlem Başarılı 🌸'),
                          content: Text('${concert.title} biletiniz Music Time güvencesiyle başarıyla satın alınmıştır. QR kodunuz e-posta adresinize iletilmiştir.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); 
                                Navigator.pop(context); 
                              },
                              child: const Text('Kapat', style: TextStyle(color: Color(0xFFE07A9A), fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      );
                    },
                    child: const Text('Bileti Satın Al', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
   );
  }
}
