import 'dart:math';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:clean_up_game/screens/utils/log_card.dart';
import 'package:clean_up_game/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../shared/appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var logs = Provider.of<List<Log>>(context);

    var credits = logs.fold<int>(
        0, (previousValue, element) => previousValue + element.change);

    var width = min(MediaQuery.of(context).size.width - 32,
        MediaQuery.of(context).size.height / 2);

    return Scaffold(
      appBar: getAppBar(context, 'Clean Up Game'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 5,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BarcodeWidget(
                  data: AuthService.user!.uid,
                  width: width,
                  height: width,
                  barcode: Barcode.qrCode(),
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
              constraints: BoxConstraints(maxWidth: width + 8),
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
    );
  }
}
