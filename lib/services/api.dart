import 'package:flutter_dotenv/flutter_dotenv.dart';

class API {
  final String serviceURL = dotenv.env["SERVICE_URL"]!;
}
