import 'package:flutter/foundation.dart';
import 'package:hearthstone_api/core/constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'client.g.dart';

@riverpod
Future<SupabaseClient> getSupabaseClient(GetSupabaseClientRef ref) async {
  await Supabase.initialize(
    url: kSupabaseUrl,
    anonKey: kSupabaseUrl,
    debug: kDebugMode,
  );

  return Supabase.instance.client;
}
