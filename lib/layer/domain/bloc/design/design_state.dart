part of 'design_cubit.dart';

@immutable
sealed class DesignState {}

final class DesignInitial extends DesignState {}
final class DesignCard extends DesignState {}
final class DesignList extends DesignState {}
