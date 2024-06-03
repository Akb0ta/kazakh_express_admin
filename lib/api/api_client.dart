import 'package:cloud_firestore/cloud_firestore.dart';

class ApiClient {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create operation with custom ID
  Future<void> createWithId(
      String collection, String documentId, Map<String, dynamic> data) async {
    await _firestore.collection(collection).doc(documentId).set(data);
  }

  // Create operation with auto-generated ID
  Future<String> create(String collection, Map<String, dynamic> data) async {
    DocumentReference docRef =
        await _firestore.collection(collection).add(data);
    String docId = docRef.id;
    await _firestore
        .collection(collection)
        .doc(docId)
        .update({'userId': docId});
    return docId;
  }

  Future<String> globalCreate(
      String collection, Map<String, dynamic> data, String id) async {
    // Add a new document with the provided data
    DocumentReference docRef =
        await FirebaseFirestore.instance.collection(collection).add(data);

    // Get the ID of the newly created document
    String docId = docRef.id;

    // Set the custom ID using the provided 'id' field
    await docRef.set({
      id: docId,
      ...data // Optionally, you might want to store the original data along with the custom ID
    });

    // Return the ID of the newly created document
    return docId;
  }

  // Read operation
  Future<Map<String, dynamic>?> get(
      String collection, String documentId) async {
    DocumentSnapshot snapshot =
        await _firestore.collection(collection).doc(documentId).get();
    return snapshot.data() as Map<String, dynamic>?;
  }

  // Update operation
  Future<void> update(String collection, String documentId,
      Map<String, dynamic> newData) async {
    await _firestore.collection(collection).doc(documentId).update(newData);
  }

  // Delete operation
  Future<void> delete(String collection, String documentId) async {
    await _firestore.collection(collection).doc(documentId).delete();
  }

  // Check if field exists
  Future<String> fieldExists(
      String collection, String field, dynamic value) async {
    String userId = '';
    QuerySnapshot snapshot = await _firestore
        .collection(collection)
        .where(field, isEqualTo: value)
        .get();
    if (snapshot.docs.isNotEmpty) {
      userId = snapshot.docs[0].id;
    }
    return userId;
  }

  Future<String> login(String log, String pass) async {
    String userId = '';
    QuerySnapshot snapshot = await _firestore
        .collection('admins')
        .where('phone', isEqualTo: log)
        .where('password', isEqualTo: pass)
        .get();
    if (snapshot.docs.isNotEmpty) {
      userId = snapshot.docs[0].id;
    }
    return userId;
  }
}
