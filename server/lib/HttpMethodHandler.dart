import 'package:dart_frog/dart_frog.dart';

abstract class RouteHandler<T> {
  RouteHandler(this.context, this.input);

  RequestContext context;
  T input;

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
    }
  }

  bool validate_input() {
    return input != null;
  }

  Response delete() {
    return badRequest();
  }

  Response get() {
    return notFound();
  }

  Response head() {
    return notFound();
  }

  Response options() {
    return notFound();
  }

  Response patch() {
    return badRequest();
  }

  Response post() {
    return badRequest();
  }

  Response put() {
    return badRequest();
  }

  Response badRequest() {
    return Response(statusCode: 400);
  }

  Response notFound() {
    return Response(statusCode: 404);
  }
}
