import 'dart:io';
import 'package:block_flutter/data/userData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/UserSevice.dart';
import '../stats/userStats.dart';
import '../events/events.dart';
import 'package:flutter/services.dart';
import '../data/albumList.dart';

class AlbumsBloc extends Bloc<userEvents, AlbumsState> {
  final UsersRepo albumsRepo;
  List<User> albums;

  AlbumsBloc({this.albumsRepo}) : super(AlbumsInitState());

  @override
  Stream<AlbumsState> mapEventToState(userEvents event) async* {
    switch (event) {
      case userEvents.fetchUserData:
        yield AlbumsLoading();
        try {
          albums = await albumsRepo.getUserList();
          yield AlbumsLoaded(albums: albums);
        } on SocketException {
          yield AlbumsListError(
            error: NoInternetException('No Internet'),
          );
        } on HttpException {
          yield AlbumsListError(
            error: NoServiceFoundException('No Service Found'),
          );
        } on FormatException {
          yield AlbumsListError(
            error: InvalidFormatException('Invalid Response format'),
          );
        } catch (e) {
          yield AlbumsListError(
            error: UnknownException('Unknown Error'),
          );
        }
        break;
    }
  }
}
