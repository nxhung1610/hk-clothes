import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

final Future<FirebaseApp> initialization = Firebase.initializeApp();
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
