import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fucking_do_it/models/task.dart';

class Repository {
  static StreamSubscription listen(Function(List<Task> tasks) callback) {
    return Repository._collection().snapshots().listen((event) async {
      final List<Task> tasks = [];
      final result = await _collection().get();

      for (final document in result.docs) {
        tasks.add(Task.fromDocument(document));
      }

      callback(tasks);
    });
  }

  static Future add(Task task) => _collection().add(task.document);

  static Future update(Task task) => _collection().doc(task.id).set(task.document);

  static Future delete(Task task) => _collection().doc(task.id).delete();

  static CollectionReference<Map<String, dynamic>> _collection() => FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid);
}
