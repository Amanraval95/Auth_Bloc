import 'package:auth_bloc/bottom_navigation/add_item_and_client/add_client_bloc/client_bloc.dart';
import 'package:auth_bloc/bottom_navigation/add_item_and_client/add_client_bloc/client_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BillInput extends StatefulWidget {
  const BillInput({super.key});

  @override
  State<BillInput> createState() => _BillInputState();
}

class _BillInputState extends State<BillInput> {
  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Padding(
          padding: .only(top: topPadding + 10, left: 16, right: 16, bottom: 16),
          child: Card(
            color: Colors.pink[100],
            child: Padding(
              padding: const .all(10),
              child: Column(
                children: [
                  BlocBuilder<ClientBloc, ClientState>(
                    builder: (context, state) {
                      final List<DropdownMenuEntry<String>> clientEntries =
                          state.client.isEmpty
                          ? <DropdownMenuEntry<String>>[
                              const DropdownMenuEntry(
                                value: "No Client",
                                label: "No Client",
                                enabled: false,
                              ),
                            ]
                          : state.client.map((client) {
                              return DropdownMenuEntry<String>(
                                value: client["id"],
                                label: client["name"].toString().toUpperCase(),
                              );
                            }).toList();
                      return Card(
                        child: DropdownMenu<String>(
                          width: MediaQuery.of(context).size.width * 0.8,
                          hintText: "Select Client",
                          leadingIcon: Container(
                            width: 50,
                            alignment: .center,
                            decoration: const BoxDecoration(
                              border: Border(right: BorderSide(width: 1)),
                            ),
                            child: const Text("A/C"),
                          ),
                          inputDecorationTheme: const InputDecorationTheme(
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                          ),
                          menuHeight: 250,
                          dropdownMenuEntries: clientEntries,
                        ),
                      );
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
