import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/network/api_client.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});
