import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (context) async {
    // Execute code before request is handled.

    // Forward the request to the respective handler.
    final response = await handler(context);

    var newHeaders = Map.of(response.headers);
    //Allow all hosts for CORS (For local development)
    newHeaders['Access-Control-Allow-Origin'] = '*';
    var alteredResponse = response.copyWith(
      headers: newHeaders,
    );
    // Return a response.
    return alteredResponse;
  };
}
