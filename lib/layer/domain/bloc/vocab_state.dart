part of 'vocab_cubit.dart';

@immutable
sealed class VocabState {}

final class VocabInitial extends VocabState {}
final class VocabLoadingState extends VocabState {}
final class VocabDataState extends VocabState {
  final List<VocabModel> data;
  VocabDataState({required this.data});
}
final class VocabErrorState extends VocabState {}
