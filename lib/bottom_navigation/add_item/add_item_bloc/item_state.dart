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
  bool itemloaded = false;
  final List<Map<String, dynamic>> items;
  ItemLoaded({required this.items, required this.itemloaded});
  @override
  List<Object?> get props => [items];
}

class ItemError extends ItemState {
  final String error;
  const ItemError(this.error);
  @override
  List<Object?> get props => [error];
}
