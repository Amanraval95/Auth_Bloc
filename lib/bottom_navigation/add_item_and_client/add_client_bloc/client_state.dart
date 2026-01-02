import 'package:equatable/equatable.dart';

abstract class ClientState extends Equatable {
  final List<Map<String, dynamic>> client;
  const ClientState({this.client = const []});
  @override
  List<Object?> get props => [client];
}

class ClientLoading extends ClientState {}

class ClientAdded extends ClientState {
  const ClientAdded(final List<Map<String, dynamic>> client)
    : super(client: client);
}

class ClientDeleted extends ClientState {
  const ClientDeleted(final List<Map<String, dynamic>> client)
    : super(client: client);
}

class ClientAlreadyExists extends ClientState {
  const ClientAlreadyExists(final List<Map<String, dynamic>> client)
    : super(client: client);
}

class ClientLoaded extends ClientState {
  const ClientLoaded(final List<Map<String, dynamic>> client)
    : super(client: client);
}
