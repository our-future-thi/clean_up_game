import 'dart:async';

import 'package:clean_up_game/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Log>> getLogsFromPlayer(String playerId) {
    var ref = _db.collection('players');
    var playerRef = ref.doc(playerId);
    var logRef =
        playerRef.collection('logs').orderBy('timestamp', descending: true);

    return logRef.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Log.fromJson(doc.data())).toList());
  }

  Stream<bool> isAdmin() {
    var userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      return Stream<bool>.value(false);
    }

    var ref = _db.collection('players');
    var playerRef = ref.doc(userId);

    return playerRef.snapshots().map((snapshot) {
      return snapshot.data()?['admin'] as bool? ?? false;
    });
  }

  Future<void> addPlayerLog(String playerId, Log log) async {
    var ref = _db.collection('players');
    var playerRef = ref.doc(playerId);
    var logRef = playerRef.collection('logs');

    var logJson = log.toJson();
    logJson['timestamp'] = FieldValue.serverTimestamp();

    await logRef.add(logJson);
  }

  Stream<List<Article>> getArticles() {
    var ref = _db.collection('articles');

    return ref.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Article.fromJson(doc.data())).toList());
  }
}
