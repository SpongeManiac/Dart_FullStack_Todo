import 'package:dart_frog/dart_frog.dart';

import '../../bin/handlers/todoHandler.dart';

Future<Response> onRequest(RequestContext context) async {
  var handler = TodoHandler(context, '');
  return handler.handleAsync();
}
