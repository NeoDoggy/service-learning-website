import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:service_learning_website/modules/backend/article_data.dart';
import 'package:service_learning_website/modules/backend/user_data.dart';
import 'package:service_learning_website/modules/random_id.dart';

class ArticlesProvider with ChangeNotifier {
  ArticlesProvider() {
    _load();
  }

  final _collection = FirebaseFirestore.instance.collection("articles");
  final _storage = FirebaseStorage.instance.ref("images/articles");

  Map<String, ArticleData> _articlesData = {};
  Map<String, ArticleData> get articlesData => _articlesData;

  Future<void> _load() async {
    final snapshot = await _collection.get();
    _articlesData = Map.fromIterable(
        snapshot.docs.map((doc) => ArticleData.fromJson(doc.data())),
        key: (v) => (v as ArticleData).id);
    if (kDebugMode) {
      print("articles_provider -> loaded");
    }
    notifyListeners();
  }

  Future<void> createArticle(UserData userData) async {
    final String id = RandomId.generate();
    final ArticleData articleData = ArticleData(
      id: id,
      title: id,
      authorUid: userData.uid,
      authorName: userData.name,
    );
    await _collection.doc(id).set(articleData.toJson());
    _articlesData[id] = articleData;
    if (kDebugMode) {
      print("articles_provider -> updated");
    }
    notifyListeners();
  }

  Future<void> deleteArticle(String articleId) async {
    await _collection.doc(articleId).delete();
    _articlesData.remove(articleId);
    if (kDebugMode) {
      print("articles_provider -> updated");
    }
    notifyListeners();
  }

  Future<void> updateArticle(String articleId, {Uint8List? image}) async {
    if (image != null) {
      await _storage.child(articleId).putData(image);
      _articlesData[articleId]!.imageUrl =
          await _storage.child(articleId).getDownloadURL();
    }
    await _collection.doc(articleId).update(_articlesData[articleId]!.toJson());
    if (kDebugMode) {
      print("articles_provider -> updated");
    }
    notifyListeners();
  }
}
