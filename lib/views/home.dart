import 'package:flutter/material.dart';
import 'package:resep_makanan/model/resep.api.dart';
import 'package:resep_makanan/model/resep.dart';
import 'package:resep_makanan/views/detail_resep.dart';
import 'package:resep_makanan/views/widget/resep_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Resep> _resep;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getResep();
  }

  Future<void> getResep() async {
    _resep = await ResepApi.getResep();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 49, 17, 7),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu,
              color: Colors.white, // Warna putih untuk ikon
            ),
            SizedBox(width: 10),
            Text(
              'MASAKANKU',
              style: TextStyle(
                color: Colors.white, // Warna putih untuk teks
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Color.fromRGBO(149, 67, 27, 1),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _resep.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: ResepCard(
                      title: _resep[index].name,
                      cookTime: _resep[index].totalTime,
                      rating: _resep[index].rating.toString(),
                      thumbnailUrl: _resep[index].images,
                      videoUrl: _resep[index].videoUrl,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailResep(
                            name: _resep[index].name,
                            totalTime: _resep[index].totalTime,
                            rating: _resep[index].rating.toString(),
                            images: _resep[index].images,
                            description: _resep[index].description,
                            videoUrl: _resep[index].videoUrl,
                            instructions: _resep[index].instructions,
                            sections: _resep[index].sections,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
