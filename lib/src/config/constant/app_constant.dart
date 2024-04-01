class AppStrings {
  const AppStrings._();

  static const apiKey = 'API_KEY ';
  static const resultJson =
      '{"coord":{"lon":-0.1257,"lat":51.5085},"weather":[{"id":721,"main":"Haze","description":"haze","icon":"50d"}],"base":"stations","main":{"temp":8.18,"feels_like":5.26,"temp_min":6.2,"temp_max":9.06,"pressure":994,"humidity":91},"visibility":5000,"wind":{"speed":5.14,"deg":70},"clouds":{"all":75},"dt":1711869316,"sys":{"type":2,"id":2075535,"country":"GB","sunrise":1711863432,"sunset":1711909897},"timezone":3600,"id":2643743,"name":"London","cod":200}';

  //Api call error
  static const cancelRequest = "Request to API server was cancelled";
  static const connectionTimeOut = "Connection timeout with API server";
  static const receiveTimeOut = "Receive timeout in connection with API server";
  static const sendTimeOut = "Send timeout in connection with API server";
  static const socketException = "Check your internet connection";
  static const unexpectedError = "Unexpected error occurred";
  static const unknownError = "Something went wrong, please try again.";
  static const duplicateEmail = "Email has already been taken";

  //status code
  static const badRequest = "Bad request";
  static const unauthorized = "Unauthorized";
  static const forbidden = "Forbidden";
  static const notFound = "Not found";
  static const internalServerError = "Internal server error";
  static const badGateway = "Bad gateway";
}
