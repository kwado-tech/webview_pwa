class AppRoutePath {
  final bool isSplashPage;
  final bool isHomePage;

  AppRoutePath.splash() 
      : isSplashPage = true,
        isHomePage = false;

  AppRoutePath.home()
      : isSplashPage = false,
        isHomePage = true;

  bool get isUnknown => !isSplashPage && !isHomePage;
}
