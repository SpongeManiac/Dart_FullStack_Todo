import 'package:dart_frog/dart_frog.dart';

import '../database/database.dart';

abstract class RouteHandler<T1, T2> {
  RouteHandler(this.context, this.input);

  RequestContext context;
  T1 input;
  T2? sanitized_input;

  Response handle() {
    switch (context.request.method) {
      case HttpMethod.delete:
        return delete();
      case HttpMethod.get:
        return get();
      case HttpMethod.head:
        return head();
      case HttpMethod.options:
        return options();
      case HttpMethod.patch:
        return patch();
      case HttpMethod.post:
        return post();
      case HttpMethod.put:
        return put();
      default:
        return badRequest();
    }
  }

  Future<Response> handleAsync() async {
    switch (context.request.method) {
      case HttpMethod.delete:
        return await deleteAsync();
      case HttpMethod.get:
        return await getAsync();
      case HttpMethod.head:
        return await headAsync();
      case HttpMethod.options:
        return await optionsAsync();
      case HttpMethod.patch:
        return await patchAsync();
      case HttpMethod.post:
        return await postAsync();
      case HttpMethod.put:
        return await putAsync();
      default:
        return badRequest();
    }
  }

  bool validate_input();
  Future<bool> validate_inputAsync() async {
    return validate_input();
  }

  Response delete() {
    return badRequest();
  }

  Future<Response> deleteAsync() async {
    return badRequest();
  }

  Response get() {
    return notFound();
  }

  Future<Response> getAsync() async {
    return notFound();
  }

  Response head() {
    return notFound();
  }

  Future<Response> headAsync() async {
    return notFound();
  }

  Response options() {
    return notFound();
  }

  Future<Response> optionsAsync() async {
    return notFound();
  }

  Response patch() {
    return badRequest();
  }

  Future<Response> patchAsync() async {
    return badRequest();
  }

  Response post() {
    return badRequest();
  }

  Future<Response> postAsync() async {
    return badRequest();
  }

  Response put() {
    return badRequest();
  }

  Future<Response> putAsync() async {
    return badRequest();
  }

  Response badRequest() {
    return Response(statusCode: 400);
  }

  Response notFound() {
    return Response(statusCode: 404);
  }
}
