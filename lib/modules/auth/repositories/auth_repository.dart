abstract class AuthRepository {
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
    String role,
  );
  Future<Map<String, dynamic>> getMe();
  Future<List<dynamic>> fetchUsers({String? role});
}
