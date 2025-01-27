import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static final String baseAPIUrl = dotenv.env['BASE_API_URL'] ?? '';
  static final bool isDev = dotenv.env['IS_DEV']?.toLowerCase() == 'true';
}
