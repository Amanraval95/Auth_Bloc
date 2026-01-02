import 'package:equatable/equatable.dart';

abstract class ClientEvent extends Equatable {
  const ClientEvent();
  @override
  List<Object?> get props => [];
}

class LoadClientEvent extends ClientEvent {}

class AddClientEvent extends ClientEvent {
  final String name;
  const AddClientEvent(this.name);
  @override
  List<Object?> get props => [name];
}

class ClientUpdatedEvent extends ClientEvent {
  final List<Map<String, dynamic>> client;
  const ClientUpdatedEvent(this.client);
  @override
  List<Object?> get props => [client];
}

class DeleteClientEvent extends ClientEvent {
  final String client_id;
  const DeleteClientEvent(this.client_id);
}
