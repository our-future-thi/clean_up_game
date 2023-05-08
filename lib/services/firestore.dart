import 'dart:async';

import 'package:clean_up_game/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Log>> getLogsFromPlayer(String playerId) {
    var ref = _db.collection('players');
    var playerRef = ref.doc(playerId);
    var logRef = playerRef.collection('logs');

    return logRef.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Log.fromJson(doc.data())).toList());
  }
}
