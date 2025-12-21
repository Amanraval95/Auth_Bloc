import 'package:equatable/equatable.dart';

abstract class ItemState extends Equatable {
  const ItemState();
  @override
  List<Object?> get props => [];
}

class ItemAlreadyExists extends ItemState {}

class ItemAdded extends ItemState {}

class ItemDeleted extends ItemState {}

class ItemLoading extends ItemState {}

class ItemLoaded extends ItemState {
  final List<Map<String, dynamic>> items;
  const ItemLoaded(this.items);
  @override
  List<Object?> get props => [items];
}

class ItemError extends ItemState {
  final String error;
  const ItemError(this.error);
  @override
  List<Object?> get props => [error];
}
