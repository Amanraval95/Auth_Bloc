import 'package:auth_bloc/bottom_navigation/add_item/add_item_bloc/item_bloc.dart';
import 'package:auth_bloc/bottom_navigation/add_item/add_item_bloc/item_event.dart';
import 'package:auth_bloc/bottom_navigation/add_item/add_item_bloc/item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class AddItem extends StatefulWidget {
//   const AddItem({super.key});
//
//   @override
//   State<AddItem> createState() => _AddItemState();
// }
//
// class _AddItemState extends State<AddItem> {
class AddItem extends StatelessWidget {
  final _nameController = TextEditingController();
  bool showList = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const .only(top: 40, left: 16, right: 16),
        child: Column(
          mainAxisSize: .min,
          children: [
            Card(
              child: Padding(
                padding: const .all(16),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      "Add Item:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),

                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: .spaceEvenly,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _nameController,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: "Item name..",
                              enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Column(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,

                              onTap: () {
                                final name = _nameController.text.trim();
                                if (name.isNotEmpty) {
                                  context.read<ItemBloc>().add(
                                    AddItemEvent(name),
                                  );

                                  _nameController.clear();
                                }
                              },
                              child: Icon(Icons.add_circle, size: 32),
                            ),
                            SizedBox(height: 12),
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                setState(() {
                                  showList = !showList;
                                });
                              },
                              child: Icon(
                                size: 35,
                                showList
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    if (showList)
                      BlocConsumer<ItemBloc, ItemState>(
                        listener: (context, state) {
                          ScaffoldMessenger.of(context).clearSnackBars();

                          if (state is ItemAlreadyExists) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Item already exists"),
                              ),
                            );
                          }

                          if (state is ItemAdded) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Item added")),
                            );
                          }
                        },
                        buildWhen: (previous, current) => current is ItemLoaded,
                        builder: (context, state) {
                          if (state is ItemLoading) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (state is ItemLoaded) {
                            return SizedBox(
                              height: 250,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: state.items.map((items) {
                                    return Container(
                                      width: double.infinity,
                                      margin: .all(4),
                                      padding: .all(8),
                                      decoration: BoxDecoration(
                                        border: .all(color: Colors.grey),
                                        borderRadius: .circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: .spaceBetween,
                                        children: [
                                          Text(
                                            style: TextStyle(fontWeight: .bold),
                                            items["name"]
                                                .toString()
                                                .toUpperCase(),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              context.read<ItemBloc>().add(
                                                DeleteItemEvent(items["id"]),
                                              );
                                            },
                                            child: Icon(
                                              Icons.delete_forever,
                                              size: 30,
                                              color: Colors.red[700],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                            // return ListView.builder(
                            //   shrinkWrap: true,
                            //   itemCount: state.items.length,
                            //   itemBuilder: (context, index) {
                            //     final item = state.items[index];
                            //     return Container(
                            //       margin: .all(4),
                            //       padding: .all(4),
                            //       decoration: BoxDecoration(
                            //         border: Border.all(color: Colors.grey),
                            //         borderRadius: BorderRadius.circular(8),
                            //       ),
                            //       child: Text(
                            //         style: TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           fontSize: 17,
                            //           letterSpacing: 1,
                            //         ),
                            //         item["name"].toString().toUpperCase(),
                            //       ),
                            //     );
                            //   },
                            // );
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                  ],
                ),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadiusGeometry.only(topRight:),
            //     ),
            //   ),
            //   child: Icon(Icons.add),
            // ),
          ],
        ),
      ),
    );
  }
}
