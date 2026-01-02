import 'package:equatable/equatable.dart';

abstract class ItemState extends Equatable {
  final List<Map<String, dynamic>> items;
  const ItemState({this.items = const []});
  @override
  List<Object?> get props => [items];
}

class ItemAlreadyExists extends ItemState {
  const ItemAlreadyExists(final List<Map<String, dynamic>> items)
    : super(items: items);
}

class ItemAdded extends ItemState {
  const ItemAdded(final List<Map<String, dynamic>> items) : super(items: items);
}

class ItemDeleted extends ItemState {
  const ItemDeleted(final List<Map<String, dynamic>> items)
    : super(items: items);
}

class ItemLoading extends ItemState {
  // const ItemLoading(final List<Map<String, dynamic>> items)
  //   : super(items: items);
}

class ItemLoaded extends ItemState {
  const ItemLoaded(final List<Map<String, dynamic>> items)
    : super(items: items);
  // bool itemloaded = false;
  // final List<Map<String, dynamic>> items;
  // ItemLoaded({required this.items, required this.itemloaded});
  // @override
  // List<Object?> get props => [items];
}

class ItemError extends ItemState {
  final String error;
  const ItemError(this.error);
  @override
  List<Object?> get props => [error];
}
