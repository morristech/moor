import 'package:meta/meta.dart';
import 'package:sally/sally.dart';

/// Subclasses represent a table in a database generated by sally.
abstract class Table {
  const Table();

  /// The sql table name to be used. By default, sally will use the snake_case
  /// representation of your class name as the sql table name. For instance, a
  /// [Table] class named `LocalSettings` will be called `local_settings` by
  /// default.
  /// You can change that behavior by overriding this method to use a custom
  /// name. Please note that you must directly return a string literal by using
  /// a getter. For instance `@override String get tableName => 'my_table';` is
  /// valid, whereas `@override final String tableName = 'my_table';` or
  /// `@override String get tableName => createMyTableName();` is not.
  @visibleForOverriding
  String get tableName => null;

  /// Override this to specify custom primary keys:
  /// ```dart
  /// class IngredientInRecipes extends Table {
  ///  @override
  ///  Set<Column> get primaryKey => {recipe, ingredient};
  ///
  ///  IntColumn get recipe => integer().autoIncrement()();
  ///  IntColumn get ingredient => integer().autoIncrement()();
  ///
  ///  IntColumn get amountInGrams => integer().named('amount')();
  ///}
  /// ```
  /// The getter must return a set literal using the `=>` syntax so that the
  /// sally generator can understand the code.
  /// Also, please not that it's an error to have a
  /// [IntColumnBuilder.autoIncrement] column and a custom primary key.
  /// Writing such table in sql will throw at runtime.
  @visibleForOverriding
  Set<Column> get primaryKey => null;

  /// Use this as the body of a getter to declare a column that holds integers.
  /// Example (inside the body of a table class):
  /// ```
  /// IntColumn get id => integer().autoIncrement()();
  /// ```
  @protected
  IntColumnBuilder integer() => null;

  /// Use this as the body of a getter to declare a column that holds strings.
  /// Example (inside the body of a table class):
  /// ```
  /// TextColumn get name => text()();
  /// ```
  @protected
  TextColumnBuilder text() => null;

  /// Use this as the body of a getter to declare a column that holds bools.
  /// Example (inside the body of a table class):
  /// ```
  /// BoolColumn get isAwesome => boolean()();
  /// ```
  @protected
  BoolColumnBuilder boolean() => null;

  /// Use this as the body of a getter to declare a column that holds date and
  /// time.
  /// Example (inside the body of a table class):
  /// ```
  /// DateTimeColumn get accountCreatedAt => dateTime()();
  /// ```
  @protected
  DateTimeColumnBuilder dateTime() => null;
}

/// A class to to be used as an annotation on [Table] classes to customize the
/// name for the data class that will be generated for the table class. The data
/// class is a dart object that will be used to represent a row in the table.
/// {@template sally:custom_data_class}
/// By default, sally will attempt to use the singular form of the table name
/// when naming data classes (e.g. a table named "Users" will generate a data
/// class called "User"). However, this doesn't work for irregular plurals and
/// you might want to choose a different name, for which this annotation can be
/// used.
/// {@template}
class DataClassName {
  final String name;

  /// Customize the data class name for a given table.
  /// {@macro sally:custom_data_class}
  const DataClassName(this.name);
}
