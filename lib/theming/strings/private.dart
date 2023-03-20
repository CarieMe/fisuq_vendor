class PrivateString {
  const PrivateString._();

//Your application title
  static const String title = 'Carie Me Vendor';

//Your application name
  static const String appName = 'CarieMe Vendor';

//Your package name
  static const String packageName = 'com.carieme.vendor';
  static const String iosPackage = 'com.carieme.vendor';

//Set country code
  static String defaultCountryCode = 'AE';

//Add your secret key here to conncet app with admin panel .
  static const String baseUrl = 'https://carieme.com/seller/app/v1/api/';
  static const String jwtKey = 'f757f204bf861dc7d2966aaf3bcbc80797509cd1';

//Time settings
  static const int timeOut = 50;

//loading page value
  static const int perPage = 10;

// issue name (Note : Please do not change this value)
  static const String issuerName = 'eshop';

  static const String sellerId = '5';
}
