import 'package:equatable/equatable.dart';

class Verse extends Equatable {
  final String reference;
  final String text;

  const Verse({
    required this.reference,
    required this.text,
  });

  @override
  List<Object?> get props => [reference, text];
}
