import 'dart:async';

import 'package:auth_bloc/bottom_navigation/add_item_and_client/add_client_bloc/client_event.dart';
import 'package:auth_bloc/bottom_navigation/add_item_and_client/add_client_bloc/client_state.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  String UserId;
  StreamSubscription? _sub;
  ClientBloc(this.UserId) : super(ClientLoading()) {
    on<LoadClientEvent>((event, emit) async {
      await _sub?.cancel();
      _sub = FirebaseFirestore.instance
          .collection("user")
          .doc(UserId)
          .collection("client")
          .snapshots()
          .listen((snapshot) {
            final client = snapshot.docs.map((d) {
              return {"id": d.id, ...d.data()};
            }).toList();
            add(ClientUpdatedEvent(client));
          });
    });
    on<ClientUpdatedEvent>((event, emit) {
      emit(ClientLoaded(event.client));
    });
    on<AddClientEvent>((event, emit) async {
      final ref = FirebaseFirestore.instance
          .collection("user")
          .doc(UserId)
          .collection("client");
      final exists = await ref
          .where("name", isEqualTo: event.name)
          .limit(1)
          .get();
      if (exists.docs.isNotEmpty) {
        emit(ClientAlreadyExists(state.client));
        return;
      }
      await ref.add({"name": event.name});
      emit(ClientAdded(state.client));
    });
    on<DeleteClientEvent>((event, emit) {
      FirebaseFirestore.instance
          .collection("user")
          .doc(UserId)
          .collection("client")
          .doc(event.client_id)
          .delete();
      emit(ClientDeleted(state.client));
    });
  }
  @override
  Future close() {
    _sub?.cancel();
    return super.close();
  }
}
