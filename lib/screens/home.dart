import 'dart:math';

import 'package:clean_up_game/screens/utils/log_card.dart';
import 'package:clean_up_game/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../models/models.dart';
import '../shared/appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var logs = Provider.of<List<Log>>(context);

    var credits = logs.fold<int>(
        0, (previousValue, element) => previousValue + element.change);

    var size = min(MediaQuery.of(context).size.width - 64,
        min(MediaQuery.of(context).size.height / 2, 350.0));

    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(context, 'Clean Up Game'),
        body: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  elevation: 5,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: QrImageView(
                      data: AuthService().user!.uid,
                      size: size,
                      padding: EdgeInsets.zero,
                      
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Text(
                        credits.toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: credits > 0
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      const Text(
                        'Credits',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size + 32),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: logs.length,
                    itemBuilder: (context, index) => LogCard(
                      log: logs[index],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
