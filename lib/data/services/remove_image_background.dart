import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class RemoveBackground {
  //? remove img background
  Future<Uint8List> removeBackground(Uint8List imageFile) async {
    final response = await http.post(
      Uri.parse('https://api.remove.bg/v1.0/removebg'),
      headers: {
        'X-Api-Key': 'v9hizpcYyJfHxJFLyNKBHdrs',
      },
      body: {
        'image_file_b64': base64.encode(imageFile),
      },
    );
    if (response.statusCode == 200) {
      Uint8List imageBytes = response.bodyBytes;
      return imageBytes;
    } else {
      throw Exception('Failed to remove background: ${response.body}');
    }
  }
}
