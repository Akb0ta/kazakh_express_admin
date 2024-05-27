import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class GlobalFunctions {
  Future<String> uploadImageToImgBB(BuildContext context) async {
    final String apiKey =
        'eea35a1728dda256d2c376902d77ca9d'; // Replace with your ImgBB API key

    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Uint8List? bytes = await pickedFile.readAsBytes();

      if (bytes != null) {
        final Uri apiUrl =
            Uri.parse('https://api.imgbb.com/1/upload?key=$apiKey');

        // Create multipart request for image upload
        var request = http.MultipartRequest('POST', apiUrl)
          ..files.add(http.MultipartFile(
              'image', http.ByteStream.fromBytes(bytes), bytes.length,
              filename: pickedFile.path.split("/").last));

        // Send request and get response
        var response = await request.send();

        // Read response
        if (response.statusCode == 200) {
          final String responseData = await response.stream.bytesToString();
          final Map<String, dynamic> decodedResponse =
              json.decode(responseData);
          if (decodedResponse['data'] != null &&
              decodedResponse['data']['url'] != null) {
            return decodedResponse['data']['url'];
          } else {
            throw Exception("Failed to upload image to ImgBB.");
          }
        } else {
          throw Exception(
              "Failed to upload image to ImgBB. Status code: ${response.statusCode}");
        }
      } else {
        throw Exception("Failed to read image bytes.");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected')),
      );
      return 'null';
    }
  }

  List generateMatrix(int numColumns) {
    var matrix = [];

    for (int i = 0; i < numColumns * 4; i++) {
      matrix.add(false);
    }

    return matrix;
  }
}
