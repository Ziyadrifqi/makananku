import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:resep_makanan/model/resep.dart';

class ResepApi {
  static Future<List<Resep>> getResep() async {
    var uri = Uri.https('tasty.p.rapidapi.com', 'recipes/list',
        {'from': '0', 'size': '20', 'tags': 'under_30_minutes'});

    try {
      final response = await http.get(uri, headers: {
        'x-rapidapi-key': 'ff876cdd1amshf4786f6df041843p19ed8fjsn42cbcbeb6f2c',
        'x-rapidapi-host': 'tasty.p.rapidapi.com'
      });

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);

        List temp = [];
        for (var i in data['results']) {
          temp.add(i);
        }

        return Resep.resepFromSnapshot(temp);
      } else {
        print('Failed to load recipes. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load recipes');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load recipes');
    }
  }
}
