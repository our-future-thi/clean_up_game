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
  String? _selectedPlayer = "BUxkl7LPNWbru1mxAMnqIIRxuuZ2";

  @override
  Widget build(BuildContext context) {
    var articles = Provider.of<List<Article>>(context);

    return Scaffold(
      appBar: getAppBar(context, 'Admin Panel'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text('Selected User'),
                subtitle: Text(
                  _selectedPlayer ?? 'No user selected',
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
                  onPressed: () async {
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
                  },
                  icon: _selectedPlayer != null
                      ? const Icon(Icons.clear_rounded)
                      : const Icon(Icons.qr_code_rounded),
                  label: _selectedPlayer != null
                      ? const Text('Clear')
                      : const Text('Scan QR'),
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
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(articles[index].name),
                        trailing: Text("${articles[index].price} points"),
                        leading: const Icon(Icons.emoji_food_beverage_rounded),
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

                          logJson['timestamp'] = FieldValue.serverTimestamp();

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
          ],
        ),
      ),
    );
  }
}
