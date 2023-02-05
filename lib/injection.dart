import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  //external
  final firestore = FirebaseFirestore.instance;

  locator.registerLazySingleton(() => firestore);
}
