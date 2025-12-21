import 'dart:async';

import 'package:auth_bloc/bottom_navigation/add_item/add_item_bloc/item_event.dart';
import 'package:auth_bloc/bottom_navigation/add_item/add_item_bloc/item_state.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final String userId;
  StreamSubscription? _sub;
  ItemBloc(this.userId) : super(ItemLoading()) {
    on<LoadItemsEvent>((event, emit) async {
      await _sub?.cancel();
      _sub = FirebaseFirestore.instance
          .collection("user")
          .doc(userId)
          .collection("items")
          .snapshots()
          .listen((snapshot) {
            final items = snapshot.docs.map((d) {
              return {"id": d.id, ...d.data()};
            }).toList();
            add(ItemsUpdatedEvent(items));
          });
    });
    on<AddItemEvent>((event, emit) async {
      final ref = FirebaseFirestore.instance
          .collection("user")
          .doc(userId)
          .collection("items");
      // CHECKS NAME EXISTS OR NOT
      final exists = await ref
          .where("name", isEqualTo: event.name)
          .limit(1)
          .get();
      if (exists.docs.isNotEmpty) {
        emit(ItemAlreadyExists());
        // add(LoadItemsEvent());

        return;
      }

      // NAME ADDED TO LIST
      await ref.add({"name": event.name});
      emit(ItemAdded());
    });
    on<ItemsUpdatedEvent>((event, emit) {
      emit(ItemLoaded(event.items));
    });
    on<DeleteItemEvent>((event, emit) async {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(userId)
          .collection("items")
          .doc(event.item_id)
          .delete();
      emit(ItemDeleted());
    });
  }
  @override
  Future close() {
    _sub?.cancel();
    return super.close();
  }
}
