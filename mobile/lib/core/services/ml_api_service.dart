import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class MlApiService {
  // Base URL for your Python FastAPI backend
  final String baseUrl = 'http://localhost:8001/api/v1'; // Adjust in production

  /// 1. Contract Generation
  Future<Map<String, dynamic>> generateContract(Map<String, dynamic> requestData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/contracts/generate'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to generate contract: ${response.body}');
    }
  }

  /// 2. E-Bills OCR Processing (Upload & Process)
  Future<Map<String, dynamic>> processEBill(File file, Map<String, String> metadata) async {
    // First Upload
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/e-bills/upload'));
    request.fields.addAll(metadata);
    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final billId = data['bill_id'];
      
      // Then Process
      final processResponse = await http.post(
        Uri.parse('$baseUrl/e-bills/$billId/process'),
      );
      
      if (processResponse.statusCode == 200) {
        return jsonDecode(processResponse.body);
      } else {
        throw Exception('Failed to process E-Bill OCR');
      }
    } else {
      throw Exception('Failed to upload E-Bill: ${response.body}');
    }
  }

  /// 3. Price Prediction (real_estate_ai.py)
  Future<Map<String, dynamic>> predictPrice(Map<String, dynamic> features) async {
    final response = await http.post(
      Uri.parse('$baseUrl/real-estate/price-prediction'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(features),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to predict price');
    }
  }

  /// 4. Location Intelligence
  Future<Map<String, dynamic>> analyzeLocation(Map<String, dynamic> features) async {
    final response = await http.post(
      Uri.parse('$baseUrl/real-estate/location-analysis'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(features),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to analyze location');
    }
  }

  /// 5. Upload Video/Media for AI Processing (media-upload.ts or cleaning_vision)
  Future<Map<String, dynamic>> uploadMediaForProcessing(File file, Map<String, String> metadata) async {
    var request = http.MultipartRequest('POST', Uri.parse('http://localhost:3000/api/v1/media/upload'));
    request.fields.addAll(metadata);
    
    // Note: MediaType needs to be generic or inferred
    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to upload media: ${response.body}');
    }
  }
}

// Global Singleton for Easy Access
final mlApiService = MlApiService();
