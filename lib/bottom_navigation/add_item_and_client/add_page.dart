import 'package:auth_bloc/bottom_navigation/add_item_and_client/add_client_bloc/client_bloc.dart';
import 'package:auth_bloc/bottom_navigation/add_item_and_client/add_client_bloc/client_event.dart';
import 'package:auth_bloc/bottom_navigation/add_item_and_client/add_client_bloc/client_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Reuseable_card/card.dart';
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
