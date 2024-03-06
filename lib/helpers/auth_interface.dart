enum AuthMethod {
  google,
}

class SocialResponse {
  final String uid;
  final String? name;
  final String? photoUrl;
  final String email;
  SocialResponse({required this.uid, required this.email,  this.name, this.photoUrl});

  @override
  String toString() {
    return 'SocialResponse{email: $email}';
  }
}

class GoogleAuth implements AuthInterface {
  @override
  Future<SocialResponse?> signUp() {
    throw UnimplementedError();
  }

  @override
  Future<void> logIn() async {
    String userEmail = await _getUserEmailFromGmail();
    print('Logged in with Gmail ID: $userEmail');
  }

  Future<String> _getUserEmailFromGmail() async {
    return 'example@gmail.com';
  }
}

abstract class AuthInterface {
  Future<SocialResponse?> signUp();
  Future<void> logIn();
}

// Factory is not needed anymore as there's only one implementation
