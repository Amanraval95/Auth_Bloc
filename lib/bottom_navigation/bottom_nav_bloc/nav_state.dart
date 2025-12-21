import 'package:equatable/equatable.dart';

class NavState extends Equatable {
  final int currentIndex;
  const NavState(this.currentIndex);
  @override
  List<Object?> get props => [currentIndex];
}
