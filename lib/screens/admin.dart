import 'package:clean_up_game/screens/utils/log_card.dart';
import 'package:clean_up_game/screens/utils/submit_trash_dialog.dart';
import 'package:clean_up_game/shared/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

import '../models/models.dart';
import '../services/firestore.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? _selectedPlayer;

  @override
  Widget build(BuildContext context) {
    var articles = Provider.of<List<Article>>(context);

    void selectOrClear() {
      if (_selectedPlayer != null) {
        setState(() {
          _selectedPlayer = null;
        });

        return;
      }

      _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
        context: context,
        onCode: (code) {
          setState(
            () {
              _selectedPlayer = code?.split('= ').last;
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: getAppBar(context, 'Admin Panel'),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(_selectedPlayer != null
            ? Icons.clear_rounded
            : Icons.qr_code_rounded),
        onPressed: () => selectOrClear(),
        label: Text(_selectedPlayer != null ? 'Clear' : 'Scan QR-Code'),
      ),
      body: StreamBuilder<List<Log>>(
          stream: FirestoreService().getLogsFromPlayer(_selectedPlayer),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            var logs = snapshot.data ?? List<Log>.empty();

            var credits = logs.fold<int>(
                0, (previousValue, element) => previousValue + element.change);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: ListTile(
                      title: const Text('Selected User'),
                      subtitle: _selectedPlayer != null
                          ? Row(
                              children: [
                                Text(
                                  _selectedPlayer!,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '($credits points)',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )
                          : Text(
                              'No user selected',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: 12,
                              ),
                            ),
                      leading: Icon(
                          _selectedPlayer != null
                              ? Icons.person_rounded
                              : Icons.person_outline_rounded,
                          color: Theme.of(context).colorScheme.tertiary),
                      trailing: TextButton.icon(
                        onPressed: () => selectOrClear(),
                        icon: _selectedPlayer != null
                            ? const Icon(Icons.clear_rounded)
                            : const Icon(Icons.qr_code_rounded),
                        label: _selectedPlayer != null
                            ? const Text('Clear')
                            : const Text('Scan QR'),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Actions',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('Submit trash'),
                          leading: const Icon(Icons.restore_from_trash_rounded),
                          onTap: () async {
                            var result = await showDialog(
                              context: context,
                              builder: (context) => const SubmitTrashDialog(
                                title: 'Submit trash',
                              ),
                            );

                            if (result == null || _selectedPlayer == null) {
                              return;
                            }

                            await FirestoreService().addPlayerLog(
                              _selectedPlayer!,
                              Log(
                                change: result,
                                name: 'Submitted Trash',
                              ),
                            );

                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Added $result points',
                                ),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: const Text('Remove points'),
                          leading: const Icon(Icons.delete_rounded),
                          onTap: () async {
                            var result = await showDialog(
                              context: context,
                              builder: (context) => const SubmitTrashDialog(
                                title: 'Remove points',
                              ),
                            );

                            if (result == null || _selectedPlayer == null) {
                              return;
                            }

                            await FirestoreService().addPlayerLog(
                              _selectedPlayer!,
                              Log(
                                change: -result,
                                name: 'Points cancelled',
                                cancelled: true,
                              ),
                            );

                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Removed $result points',
                                ),
                              ),
                            );
                          },
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(articles[index].name),
                              trailing: Text("${articles[index].price} points"),
                              leading:
                                  const Icon(Icons.emoji_food_beverage_rounded),
                              onTap: () async {
                                var result = await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Buy item?'),
                                    content: Text(
                                        'Are you sure you want to buy ${articles[index].name} for ${articles[index].price} points?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                        },
                                        child: const Text('Buy'),
                                      ),
                                    ],
                                  ),
                                );

                                if (result == null ||
                                    result == false ||
                                    _selectedPlayer == null) {
                                  return;
                                }

                                var logJson = Log(
                                  name: articles[index].name,
                                  change: -articles[index].price,
                                ).toJson();

                                logJson['timestamp'] =
                                    FieldValue.serverTimestamp();

                                FirestoreService().addPlayerLog(
                                  _selectedPlayer!,
                                  Log.fromJson(logJson),
                                );

                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Bought ${articles[index].name} for ${articles[index].price} points',
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          shrinkWrap: true,
                          itemCount: articles.length,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: logs.isNotEmpty,
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'User Logs',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: logs.isNotEmpty,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: logs.length,
                          itemBuilder: (context, index) => LogCard(
                            log: logs[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
