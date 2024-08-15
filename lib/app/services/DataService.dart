import 'package:firebase_database/firebase_database.dart';

class DataService {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref().child('users');

  Stream<DatabaseEvent> getDataStream(String nim) {
    return _dbRef.child(nim).onValue;
  }
}
