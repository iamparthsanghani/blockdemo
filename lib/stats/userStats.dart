import 'package:block_flutter/data/userData.dart';
import 'package:equatable/equatable.dart';

abstract class AlbumsState extends Equatable {
  @override
  List<Object> get props => [];
}

class AlbumsInitState extends AlbumsState {}

class AlbumsLoading extends AlbumsState {}

class AlbumsLoaded extends AlbumsState {
  final List<User> albums;

  AlbumsLoaded({this.albums});
}

class AlbumsListError extends AlbumsState {
  final error;

  AlbumsListError({this.error});
}
