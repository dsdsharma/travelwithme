import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travelwithme/models/travel_story.dart';

const apiUrl =
    'http://website-bucket-12234.s3-website-us-east-1.amazonaws.com/api.json';

Future<TravelStory> fetchTravelStory(http.Client client) async {
  final response = await client.get(Uri.parse(apiUrl));

  final parsed = jsonDecode(response.body);

  return TravelStory.fromJson(parsed);
}
