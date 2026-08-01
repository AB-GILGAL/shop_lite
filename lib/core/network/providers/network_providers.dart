import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../client/api_client.dart';

part 'network_providers.g.dart';

@riverpod
ApiClient apiClient(Ref ref) {
  return ApiClient();
}
