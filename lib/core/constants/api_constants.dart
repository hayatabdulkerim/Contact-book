class ApiConstants {
  static const String baseUrl = 'https://6a033cd10d92f63dd2553467.mockapi.io/api/v1/';
  static const String contactsEndpoint = '/contacts';
  
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
  
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}