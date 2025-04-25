class Keys {
  // Authentication and User Data
  static const String USER_ID = 'id';
  static const String USERNAME = 'username'; // While not directly in the response, might be used elsewhere
  static const String EMAIL = 'email';
  static const String NAME = 'name';
  static const String AVATAR = 'avatar';
  static const String ROLE = 'role';
  static const String TOKEN = 'token'; // From the response
  static const String IS_VERIFIED = 'verified';
  static const String COLLECTION_ID ='collectionId';

  // Preferences and App State
  static const String PREF_IS_LOGGED_IN = 'prefIsLogin';
  static const String PASSWORD = 'password'; // For storing/retrieving credentials
  static const String USER_GROUP_TYPE = 'group'; // Not in the response, keep if relevant
  static const String KEY_LAST_LOGIN_TIME = "lastLoginTime"; // Keep if your app tracks this
  static const String IS_VISITED = 'isVisited'; // Keep if your app uses this
}