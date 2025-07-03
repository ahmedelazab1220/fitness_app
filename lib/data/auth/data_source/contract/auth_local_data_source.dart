abstract class AuthLocalDataSource {
  Future<void> clearAll();

  Future<bool> selectLanguage(String languageCode);
}
