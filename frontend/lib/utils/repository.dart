import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fucking_do_it/models/task.dart';

class Repository {
  static StreamSubscription listenAssignedToMe(Function(List<Task> tasks) callback) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> stream = Repository._collection()
        .where(
          'assignedTo',
          arrayContains: FirebaseAuth.instance.currentUser?.uid,
        )
        .snapshots();

    return processStream(stream, callback);
  }

  static StreamSubscription listenCreated(Function(List<Task> tasks) callback) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> stream = Repository._collection()
        .where(
          'createdBy',
          isEqualTo: FirebaseAuth.instance.currentUser?.uid,
        )
        .where('status', isEqualTo: 'created')
        .snapshots();

    return processStream(stream, callback);
  }

  static StreamSubscription listenInProgress(Function(List<Task> tasks) callback) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> stream = Repository._collection()
        .where(
          'createdBy',
          isEqualTo: FirebaseAuth.instance.currentUser?.uid,
        )
        .where('status', isEqualTo: 'accepted')
        .snapshots();

    return processStream(stream, callback);
  }

  static StreamSubscription listenInReview(Function(List<Task> tasks) callback) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> stream = Repository._collection()
        .where(
          'createdBy',
          isEqualTo: FirebaseAuth.instance.currentUser?.uid,
        )
        .where('status', isEqualTo: 'done')
        .snapshots();

    return processStream(stream, callback);
  }

  static StreamSubscription processStream(Stream<QuerySnapshot<Map<String, dynamic>>> stream, Function(List<Task> tasks) callback) {
    return stream.listen((event) async {
      final List<Task> tasks = [];

      for (final document in event.docs) {
        tasks.add(Task.fromDocument(document));
      }

      callback(tasks);
    });
  }

  static Future add(Task task) => _collection().add(task.document);

  static Future update(Task task) => _collection().doc(task.id).set(task.document);

  static Future delete(Task task) => _collection().doc(task.id).delete();

  static CollectionReference<Map<String, dynamic>> _collection() => FirebaseFirestore.instance.collection('tasks');
}
