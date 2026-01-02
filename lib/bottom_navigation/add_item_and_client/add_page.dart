import 'package:auth_bloc/Resuable_card/card.dart';
import 'package:auth_bloc/bottom_navigation/add_item_and_client/add_client_bloc/client_bloc.dart';
import 'package:auth_bloc/bottom_navigation/add_item_and_client/add_client_bloc/client_event.dart';
import 'package:auth_bloc/bottom_navigation/add_item_and_client/add_client_bloc/client_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_item_bloc/item_bloc.dart';
import 'add_item_bloc/item_event.dart';
import 'add_item_bloc/item_state.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _itemNameController = TextEditingController();
  final _clientNameController = TextEditingController();
  bool showItem = false;
  bool showClient = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const .only(top: 45, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: .min,
            children: [
              // Card(
              //   elevation: 2,
              //   child: Padding(
              //     padding: const .all(16),
              //     child: Column(
              //       crossAxisAlignment: .start,
              //       children: [
              //         Text(
              //           "Add Item:",
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 17,
              //           ),
              //         ),
              //
              //         SizedBox(height: 12),
              //         Row(
              //           mainAxisAlignment: .spaceEvenly,
              //           children: [
              //             Expanded(
              //               child: TextField(
              //                 controller: _itemNameController,
              //                 textInputAction: TextInputAction.done,
              //                 decoration: InputDecoration(
              //                   hintText: "Item name..",
              //                   enabledBorder: OutlineInputBorder(),
              //                   focusedBorder: OutlineInputBorder(),
              //                 ),
              //               ),
              //             ),
              //             SizedBox(width: 12),
              //             Column(
              //               mainAxisAlignment: .spaceBetween,
              //               children: [
              //                 InkWell(
              //                   splashColor: Colors.transparent,
              //                   highlightColor: Colors.transparent,
              //
              //                   onTap: () {
              //                     final name = _itemNameController.text.trim();
              //                     if (name.isNotEmpty) {
              //                       context.read<ItemBloc>().add(
              //                         AddItemEvent(name),
              //                       );
              //
              //                       _itemNameController.clear();
              //                     }
              //                   },
              //                   child: Icon(Icons.add_circle, size: 32),
              //                 ),
              //                 SizedBox(height: 12),
              //                 InkWell(
              //                   splashColor: Colors.transparent,
              //                   highlightColor: Colors.transparent,
              //                   onTap: () {
              //                     setState(() {
              //                       showItem = !showItem;
              //                     });
              //                   },
              //                   child: Icon(
              //                     size: 35,
              //                     showItem
              //                         ? Icons.keyboard_arrow_up
              //                         : Icons.keyboard_arrow_down,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 30),
              //         if (showItem)
              //           BlocConsumer<ItemBloc, ItemState>(
              //             listener: (context, state) {
              //               ScaffoldMessenger.of(context).clearSnackBars();
              //
              //               if (state is ItemAlreadyExists) {
              //                 ScaffoldMessenger.of(context).showSnackBar(
              //                   const SnackBar(
              //                     content: Text("Item already exists"),
              //                   ),
              //                 );
              //               }
              //               if (state is ItemDeleted) {
              //                 ScaffoldMessenger.of(context).showSnackBar(
              //                   SnackBar(content: Text("Item deleted")),
              //                 );
              //               }
              //
              //               if (state is ItemAdded) {
              //                 ScaffoldMessenger.of(context).showSnackBar(
              //                   const SnackBar(content: Text("Item added")),
              //                 );
              //               }
              //             },
              //             buildWhen: (previous, current) =>
              //                 previous.items != current.items,
              //             builder: (context, state) {
              //               if (state is ItemLoading || state.items.isEmpty) {
              //                 return Center(
              //                   child: Text(
              //                     "EMPTY!",
              //                     style: TextStyle(
              //                       fontSize: 15,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                 );
              //               }
              //               if (state.items.isNotEmpty) {
              //                 return SizedBox(
              //                   height: 250,
              //                   child: SingleChildScrollView(
              //                     child: Column(
              //                       children: state.items.map((items) {
              //                         return Container(
              //                           width: double.infinity,
              //                           margin: .all(4),
              //                           padding: .all(8),
              //                           decoration: BoxDecoration(
              //                             border: .all(color: Colors.grey),
              //                             borderRadius: .circular(8),
              //                           ),
              //                           child: Row(
              //                             mainAxisAlignment: .spaceBetween,
              //                             children: [
              //                               Text(
              //                                 style: TextStyle(
              //                                   fontWeight: .bold,
              //                                 ),
              //                                 items["name"]
              //                                     .toString()
              //                                     .toUpperCase(),
              //                               ),
              //                               InkWell(
              //                                 onTap: () {
              //                                   context.read<ItemBloc>().add(
              //                                     DeleteItemEvent(items["id"]),
              //                                   );
              //                                 },
              //                                 child: Icon(
              //                                   Icons.delete_forever,
              //                                   size: 30,
              //                                   color: Colors.red[700],
              //                                 ),
              //                               ),
              //                             ],
              //                           ),
              //                         );
              //                       }).toList(),
              //                     ),
              //                   ),
              //                 );
              //
              //               }
              //
              //               return const SizedBox.shrink();
              //             },
              //           ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(height: 12),
              BlocConsumer<ItemBloc, ItemState>(
                listener: (context, state) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  if (state is ItemAdded) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Item added")));
                  }
                  if (state is ItemDeleted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Item Deleted")));
                  }
                  if (state is ItemAlreadyExists) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Item Already Exists")),
                    );
                  }
                },
                buildWhen: (previous, current) =>
                    previous.items != current.items,
                builder: (context, state) {
                  return CustomizeCard(
                    title: "Add Item:",

                    toggleButton: () {
                      setState(() {
                        showItem = !showItem;
                      });
                    },
                    controller: _itemNameController,
                    isListVisible: showItem,
                    hintText: 'Item name..',
                    data: state.items,
                    onAdd: (name) =>
                        context.read<ItemBloc>().add(AddItemEvent(name)),
                    onDelete: (id) =>
                        context.read<ItemBloc>().add(DeleteItemEvent(id)),
                  );
                },
              ),
              BlocConsumer<ClientBloc, ClientState>(
                listener: (context, state) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  if (state is ClientAdded) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Client Added")));
                  }
                  if (state is ClientDeleted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Client Deleted")));
                  }
                  if (state is ClientAlreadyExists) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Client AlreadyExists")),
                    );
                  }
                },
                buildWhen: (previous, current) =>
                    previous.client != current.client,
                builder: (context, state) {
                  return CustomizeCard(
                    title: "Add Client",
                    toggleButton: () => setState(() {
                      showClient = !showClient;
                    }),
                    controller: _clientNameController,
                    isListVisible: showClient,
                    hintText: "Client name..",
                    data: state.client,
                    onAdd: (name) =>
                        context.read<ClientBloc>().add(AddClientEvent(name)),
                    onDelete: (id) =>
                        context.read<ClientBloc>().add(DeleteClientEvent(id)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
