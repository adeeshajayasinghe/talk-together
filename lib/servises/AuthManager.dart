class AuthManager {
  static bool isLoggedIn = false;
  static String token = '';

  static void login() {
    // Perform login logic
    isLoggedIn = true;
  }

  static void logout() {
    // Perform logout logic
    isLoggedIn = false;
  }
}
