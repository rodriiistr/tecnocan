import 'package:flutter/material.dart';
import 'app_database.dart';

// Singleton para usar en toda la app
class DatabaseProvider extends InheritedWidget {
  final AppDatabase db;

  const DatabaseProvider({
    super.key,
    required this.db,
    required super.child,
  });

  static AppDatabase of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<DatabaseProvider>();
    assert(provider != null, 'No DatabaseProvider encontrado en el árbol');
    return provider!.db;
  }

  @override
  bool updateShouldNotify(DatabaseProvider oldWidget) => db != oldWidget.db;
}