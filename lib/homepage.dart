import 'package:flutter/material.dart';
import 'package:galaxy_music/downloader.dart';
import 'package:galaxy_music/history.dart';
import 'package:galaxy_music/login.dart';
import 'package:galaxy_music/search.dart';
import 'package:galaxy_music/artis_list.dart';
import 'package:galaxy_music/collection.dart';
import 'package:galaxy_music/account.dart';
import 'package:galaxy_music/playpage.dart';
import 'package:galaxy_music/setting.dart';
import 'package:galaxy_music/theme_provider.dart';
import 'package:provider/provider.dart';

// Halaman utama aplikasi
class HomeScreen extends StatefulWidget {
  // Changed to StatefulWidget
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isMiniPlayerClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomSidebar(),
      body: Column(
        children: [
          // Main content in Expanded to allow for bottom widgets
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 12.0, // Mengurangi padding kiri
                right: 12.0, // Mengurangi padding kanan
                top: 35.0, // Mengurangi padding atas
                bottom: 16.0, // Mempertahankan padding bawah untuk spacing
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header dengan profil dan username
                  Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          Scaffold.of(context)
                              .openDrawer(); // Membuka sidebar saat foto profil diklik
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7), // Sesuaikan padding
                          decoration: BoxDecoration(
                            color: Colors
                                .grey[800], // Warna latar belakang username
                            borderRadius:
                                BorderRadius.circular(15), // Sudut melengkung
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min, // Agar tidak meluas
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors
                                    .grey, // Placeholder untuk foto profil
                              ),
                              SizedBox(
                                  width:
                                      5), // Jarak antara foto profil dan username
                              Text(
                                'Username',
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(
                      height: 20), // Jarak antara header dan bagian selanjutnya

                  // Bagian rekomendasi
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey[850], // Warna latar belakang
                      borderRadius:
                          BorderRadius.circular(14), // Sudut melengkung
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Recommendation',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        const SizedBox(
                            height: 10), // Jarak ke konten berikutnya
                        // Scroll horizontal untuk card album
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              7,
                              (index) => Padding(
                                padding: const EdgeInsets.only(
                                    right: 8.0), // Jarak antar card album
                                child: buildAlbumCard(
                                  width: 100,
                                  height: 100,
                                  borderRadius: 14,
                                  title: 'Song Title',
                                  subtitle: 'Artist Name',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Bagian "That you might like"
                  const Text(
                    'That you might like',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
// Daftar lagu yang mungkin disukai
                  buildSuggestedSongs(
                    cardSpacing: 10.0,
                    imageWidth: 50.0,
                    imageHeight: 50.0,
                    borderRadius: 0,
                  ),
                  const SizedBox(height: 20),

                  // Bagian "Suggested Artists"
                  const Text(
                    'Suggested artists',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Scroll horizontal untuk kartu artis
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: const EdgeInsets.only(
                              right: 20.0), // Jarak antar card artis
                          child: buildArtistCard(
                            radius: 50.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Bagian "History"
                  const Text(
                    'History',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Scroll horizontal untuk card history album
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        4,
                        (index) => Padding(
                          padding: const EdgeInsets.only(
                              right: 10.0), // Jarak antar card album history
                          child: buildAlbumCard(
                            width: 150.0,
                            height: 150.0,
                            borderRadius: 10.0,
                            title: 'History Title',
                            subtitle: 'History Artist',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Bagian Today’s Biggest Hits
                  const Text(
                    "Today’s Biggest Hits",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        4,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: buildAlbumCard(
                            width: 150,
                            height: 150,
                            borderRadius: 10,
                            title: 'Biggest Hit',
                            subtitle: 'Artist Name',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Bagian More Like (Adele)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "More Like",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(
                            Icons.more_horiz), // Ikon menu untuk opsi lainnya
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ArtisList()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Profil Adele dengan border bundar dan teks di sampingnya
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 35, // Ukuran profil bulat
                        backgroundColor:
                            Colors.grey[700], // Placeholder warna untuk profil
                        child: const Text("A",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight
                                    .bold)), // Inisial (atau ganti dengan gambar profil)
                      ),
                      const SizedBox(width: 10), // Jarak antara profil dan teks
                      const Text(
                        "Adele",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // List album yang similar song
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        4,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: buildAlbumCard(
                            width: 150,
                            height: 150,
                            borderRadius: 10,
                            title: 'Similar Song',
                            subtitle: 'Artist Name',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Bagian Galaxy Top Artists
                  const Text(
                    "Galaxy Top Artists",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        buildArtistInfoCard(
                          artistName: "The Weeknd",
                          songs: [
                            "1. Timeless",
                            "2. One Of The Girls",
                            "3. Starboy"
                          ],
                          profileImage: CircleAvatar(
                            radius: 30, // Sesuaikan ukuran sesuai desain
                            backgroundColor: Colors.grey[700],
                            child: const Text("T",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight
                                        .bold)), // Ganti dengan gambar jika tersedia
                          ),
                        ),
                        const SizedBox(width: 10),
                        buildArtistInfoCard(
                          artistName: "Justin Bieber",
                          songs: ["1. Stay", "2. Ghost", "3. Love Yourself"],
                          profileImage: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[700],
                            child: const Text("J",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight
                                        .bold)), // Ganti dengan gambar jika tersedia
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "New Add",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        4,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: buildAlbumCard(
                            width: 150,
                            height: 150,
                            borderRadius: 10,
                            title: 'New Song',
                            subtitle: 'Artist Name',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Pop",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        4,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: buildAlbumCard(
                            width: 150,
                            height: 150,
                            borderRadius: 10,
                            title: 'New Song',
                            subtitle: 'Artist Name',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Local Music",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        4,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: buildAlbumCard(
                            width: 150,
                            height: 150,
                            borderRadius: 10,
                            title: 'New Song',
                            subtitle: 'Artist Name',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Sad Vibes",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        4,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: buildAlbumCard(
                            width: 150,
                            height: 150,
                            borderRadius: 10,
                            title: 'New Song',
                            subtitle: 'Artist Name',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Bagian New Add
                  const Text(
                    "Relaxing",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        4,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: buildAlbumCard(
                            width: 150,
                            height: 150,
                            borderRadius: 10,
                            title: 'New Song',
                            subtitle: 'Artist Name',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Mini Player
          GestureDetector(
            onTap: () {
              setState(() {
                _isMiniPlayerClicked = !_isMiniPlayerClicked;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MusicPlayerScreen()),
              );
            },
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Icon(Icons.music_note, color: Colors.grey[700]),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'This music',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Artist name',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.favorite_border, color: Colors.black),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.play_arrow, color: Colors.black),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.add,
                        color: Color.fromARGB(255, 0, 0, 0)),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24.0),
                          ),
                        ),
                        builder: (context) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(24.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Header: Image and Title
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Favorit',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Private Favorit',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: Colors.black38,
                                  thickness: 1,
                                  height: 20,
                                ),
                                // Actions
                                ListTile(
                                  leading: const Icon(Icons.add,
                                      color: Colors.black),
                                  title: const Text(
                                    'Add to this Favorit',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  onTap: () {
                                    // Handle action
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.edit,
                                      color: Colors.black),
                                  title: const Text(
                                    'Edit this Favorit',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  onTap: () {
                                    // Handle action
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.delete,
                                      color: Colors.black),
                                  title: const Text(
                                    'Delete this Favorit',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  onTap: () {
                                    // Handle action
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.share,
                                      color: Colors.black),
                                  title: const Text(
                                    'Share this Favorit',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  onTap: () {
                                    // Handle action
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Bottom Navigation Bar
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color.fromARGB(255, 118, 148, 148),
            unselectedItemColor: const Color.fromARGB(255, 118, 148, 148),
            onTap: (index) {
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MusicSearchPage()),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Collection()),
                  );
                  break;
                case 3:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountScreen()),
                  );
                  break;
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon:
                    Icon(Icons.home, color: Color.fromARGB(255, 110, 121, 134)),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search,
                    color: Color.fromARGB(255, 110, 121, 134)),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_music,
                    color: Color.fromARGB(255, 110, 121, 134)),
                label: 'Collection',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle,
                    color: Color.fromARGB(255, 110, 121, 134)),
                label: 'Account',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Keep all your existing widget builder methods here
  // buildAlbumCard, buildArtistCard, buildSuggestedSongs, buildArtistInfoCard
}

// Widget untuk kartu album dengan ukuran dan radius yang dapat disesuaikan
Widget buildAlbumCard({
  required double width,
  required double height,
  required double borderRadius,
  required String title,
  required String subtitle,
}) {
  return SizedBox(
    width: width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey[600], // Placeholder untuk gambar album
            borderRadius: BorderRadius.circular(
                borderRadius), // Sudut melengkung pada gambar
          ),
        ),
        const SizedBox(height: 5), // Jarak ke teks judul album
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          overflow:
              TextOverflow.ellipsis, // Menghindari teks yang terlalu panjang
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 10,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

// Widget untuk kartu artis dengan radius yang dapat disesuaikan
Widget buildArtistCard({
  required double radius,
}) {
  return Column(
    children: [
      CircleAvatar(
        radius: radius, // Radius untuk avatar artis
        backgroundColor:
            Colors.grey[700], // Placeholder warna untuk gambar artis
      ),
      const SizedBox(height: 5), // Jarak ke teks nama artis
      const Text(
        'Artist Name',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}

// Widget untuk daftar lagu yang mungkin disukai
Widget buildSuggestedSongs({
  required double cardSpacing,
  required double imageWidth,
  required double imageHeight,
  required double borderRadius,
}) {
  return Column(
    children: List.generate(3, (index) {
      return Padding(
        padding: EdgeInsets.only(bottom: cardSpacing), // Jarak antar lagu
        child: ListTile(
          leading: Container(
            width: imageWidth, // Lebar gambar lagu
            height: imageHeight, // Tinggi gambar lagu
            decoration: BoxDecoration(
              color: Colors.grey[700], // Placeholder warna untuk gambar lagu
              borderRadius: BorderRadius.circular(
                  borderRadius), // Sudut melengkung pada gambar lagu
            ),
          ),
          title: const Text('Song Title'),
          subtitle: const Text('Artist Name'),
          trailing: const Icon(Icons.favorite_border), // Ikon favorit
        ),
      );
    }),
  );
}

// Widget untuk kartu artis dengan informasi daftar lagu
Widget buildArtistInfoCard({
  required String artistName,
  required List<String> songs,
  required Widget profileImage,
}) {
  return Container(
    width: 180,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey[850],
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            profileImage, // Profil bulat
            const SizedBox(width: 10), // Jarak antara profil dan nama artis
            Text(
              artistName,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ],
        ),
        const SizedBox(height: 10), // Jarak ke daftar lagu
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: songs
              .map((song) => Text(
                    song,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ))
              .toList(),
        ),
      ],
    ),
  );
}

// Sidebar kustom
class CustomSidebar extends StatelessWidget {
  const CustomSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      child: Container(
        color: Colors.grey[800],
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5, // 80% tinggi layar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35), //jarak dari atas ke username
              // Header
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Tambahkan aksi di sini, seperti navigasi ke halaman profil
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AccountScreen()), // Ganti dengan halaman tujuan
                      );
                    },
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Username',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      InkWell(
                        onTap: () {
                          // Aksi untuk "See profile"
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AccountScreen()), // Ganti dengan halaman tujuan
                          );
                        },
                        child: const Text(
                          'See profile',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Sidebar Items
              SidebarItem(
  icon: const Icon(Icons.switch_account), // Pastikan menggunakan Widget
  label: 'Switch Account',
  textColor: Colors.white,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  },
),
const SizedBox(height: 5),
SidebarItem(
  icon: const Icon(Icons.history), // Ikon berupa widget
  label: 'History',
  textColor: Colors.white,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const History()),
    );
  },
),

              const SizedBox(height: 5),
              SidebarItem(
                icon: const Icon(Icons.settings),
                label: 'Setting',
                textColor: Colors.white, // Warna solid untuk teks
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Setting()),
                  );
                },
              ),
              const SizedBox(height: 5),
              SidebarItem(
  icon: Icon(
    themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
    color: Theme.of(context).primaryColor, // Warna ikon
  ),
  label: 'Switch Theme',
  textColor: Theme.of(context).primaryColor,
  onTap: () {
    themeProvider.toggleTheme();
  },
),

              const SizedBox(height: 20),
              const Text(
                'Premium Accest',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 10),
              ),
              const SizedBox(height: 10),
              SidebarItem(
  icon: Image.asset(
    'assets/music.png', // Path ke gambar Gmail
    width: 30, // Ukuran gambar
    height: 30,
  ),
  label: 'Galaxy AI',
  textColor: Colors.white, // Warna teks
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Setting()),
    );
  },
),
              const SizedBox(height: 10),
              SidebarItem(
  icon: Image.asset(
    'assets/download.png', 
    width: 30, // Ukuran gambar
    height: 30,
  ),
  label: 'Downloader',
  textColor: Colors.white, // Warna teks
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Downloader ()),
    );
  },
),


              const SizedBox(height: 70), //jarak dari setting ke premium akses

// Free Premium Access Button
              SidebarItem(
  icon: Row(
    children: [
      Image.asset(
        'assets/premium.png', // Path ke gambar premium
        width: 24, // Ukuran gambar
        height: 24,
      ),
      const SizedBox(width: 10), // Jarak antara gambar dan teks
    ],
  ),
  label: 'Upgrade to Premium',
  backgroundColor: Colors.black,
  textColor: Colors.white,
  borderRadius: BorderRadius.circular(10),
  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  centeredText: true,
  onTap: () {
    // Menampilkan pop-up langsung saat tombol ditekan
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min, // Mengatur agar pop-up sesuai konten
            children: [
              const Text(
                'Premium',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 25, 110, 160),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Rp 54.990 selama 2 bulan\n'
                'Rp 54.990/bulan sesudahnya',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Benefit\n',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
              const Text(
                '• 1 akun Premium\n'
                '• Akses ke Galaxy Ai\n'
                '• Download local music',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Tambahkan aksi untuk tombol jika diperlukan
                  Navigator.pop(context); // Menutup pop-up
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Warna latar belakang biru
                  foregroundColor: Colors.white, // Warna teks putih
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Sudut melengkung
                  ),
                ),
                child: const Text('Dapatkan Premium'),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Sudut melengkung pada pop-up
          ),
        );
      },
    );
  },
),


              const SizedBox(height: 10),

// Sign Out Button
              SidebarItem(
                icon: const Icon(Icons.logout),
                label: 'Sign out',
                backgroundColor: Colors.black,
                textColor: Colors.white,
                borderRadius: BorderRadius.circular(10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                centeredText: true,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm Logout"),
                        content:
                            const Text("Are you sure you want to log out?"),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(context), // Tutup dialog
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Tutup dialog
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                            child: const Text("Logout"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final Widget icon; // Diubah dari IconData ke Widget
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final bool centeredText;
  final VoidCallback? onTap;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.centeredText = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          borderRadius: borderRadius ?? BorderRadius.zero,
        ),
        child: Row(
          mainAxisAlignment:
              centeredText ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            icon, // Menampilkan ikon berupa widget
            if (!centeredText) const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(color: textColor ?? Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

