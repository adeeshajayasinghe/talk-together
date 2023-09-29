class AuthManager {
  static bool isLoggedIn = true; //original is flase
  static String token = '';
  static bool subscribe = true; //original is false

  static void login() {
    // Perform login logic
    isLoggedIn = true;
  }

  static void logout() {
    // Perform logout logic
    isLoggedIn = false;
  }

  static void subscribed() {
    subscribe = true;
  }

  static void unSubscribed() {
    subscribe = false;
  }
}
