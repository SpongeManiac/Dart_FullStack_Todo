import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import '../bin/database/database.dart';

SharedDatabase? db;

Middleware asyncDBProvider() {
  return provider<Future<SharedDatabase>>(
    (context) async {
      if (db != null) {
        return db!;
      } else {
        var tmp = LazyDatabase(
          () async {
            final dir = Directory.current;
            if (!await dir.exists()) {
              dir.create();
            }
            final file = File(p.join(dir.path, 'todo.db'));
            return NativeDatabase(file);
          },
        );
        db = SharedDatabase(tmp);
        return db!;
      }
    },
  );
}

Handler middleware(Handler handler) {
  return handler.use(asyncDBProvider());
}
