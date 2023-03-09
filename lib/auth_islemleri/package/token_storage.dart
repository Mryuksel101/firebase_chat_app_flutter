

/// {@template in_memory_token_storage}
/// In-memory token storage for the authentication client.
/// {@endtemplate}
class InMemoryTokenStorage{
  String? _token;

  @override
  Future<String?> readToken() async => _token;

  @override
  Future<void> saveToken(String token) async => _token = token;

  @override
  Future<void> clearToken() async => _token = null;
}
