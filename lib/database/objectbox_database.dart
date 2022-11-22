import 'objectbox.g.dart'; // created by `flutter pub run build_runner build`

class ObjectBox {
  /// The Store of this app.
  Store? store;

  ObjectBox._create(this.store) {}

  /// Create an instance of ObjectBox to use throughout the app.
  // static Future<ObjectBox> create() async {
  //   // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
  //   // final store ??= await openStore();
  //   return ObjectBox._create(store);
  // }
}
