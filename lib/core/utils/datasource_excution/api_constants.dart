class ApiConstants {
  // Private constructor to prevent instantiation
  ApiConstants._();

  static const String baseUrl = "https://fitness.elevateegy.com/api/v1/";
  //////////////////////////// Auth Routes ////////////////////////////
  static const String signupRoute = "auth/signup";
  static const String loginRoute = "auth/signin";
  static const String changePasswordRoute = "auth/change-password";
  static const String uploadProfilePhotoRoute = "auth/upload-photo";
  static const String profileDataRoute = "auth/profile-data";
  static const String logoutRoute = "auth/logout";
  static const String forgetPasswordRoute = "auth/forgotPassword";
  static const String verifyRestCodeRoute = "auth/verifyResetCode";
  static const String resetPasswordRoute = "auth/resetPassword";
  static const String deleteAccountRoute = "auth/deleteMe";
  static const String editProfileRoute = "auth/editProfile";
  //////////////////////////// Levels Routes ////////////////////////////
  static const String allLevels = "levels";
  static const String getAllDifficultyLevelsByPrimeMoverMuscle =
      "levels/difficulty-levels/by-prime-mover";
  //////////////////////////// Muscle Routes ////////////////////////////
  static const String allMuscles = "muscles";
  static const String allMusclesGroup = "musclesGroup";
  static const String musclesRandom = "muscles/random";
  static const String musclesGroupByMuscleGroup =
      "musclesGroup/by-muscle-group";
  //////////////////////////// Meals Routes ////////////////////////////
  static const String mealsCategories = "1/categories.php";
  static const String filterMealsByCategory = "1/filter.php";
  static const String mealDetails = "1/lookup.php";
  /////////////////////////// Exercises Routes ////////////////////////////
  static const String allExercises = "exercises";
  static const String exercisesByMuscleDifficulty =
      "exercises/by-muscle-difficulty";
  static const String exercisesByRandom = "exercises/random";
}
