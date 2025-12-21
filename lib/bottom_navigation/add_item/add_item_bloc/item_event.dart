import 'package:equatable/equatable.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent();
  @override
  List<Object?> get props => [];
}

class LoadItemsEvent extends ItemEvent {}

class AddItemEvent extends ItemEvent {
  final String name;
  const AddItemEvent(this.name);
  @override
  List<Object?> get props => [name];
}

class ItemsUpdatedEvent extends ItemEvent {
  final List<Map<String, dynamic>> items;
  const ItemsUpdatedEvent(this.items);
  @override
  List<Object?> get props => [items];
}

class DeleteItemEvent extends ItemEvent {
  final String item_id;
  const DeleteItemEvent(this.item_id);
}
