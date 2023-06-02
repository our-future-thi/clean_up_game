import 'package:clean_up_game/screens/admin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../services/firestore.dart';

class AdminWrapper extends StatelessWidget {
  const AdminWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Article>>(
      create: (_) => FirestoreService().getArticles(),
      initialData: List<Article>.empty(),
      catchError: (context, error) {
        return List<Article>.empty();
      },
      child: const AdminPanel(),
    );
  }
}
