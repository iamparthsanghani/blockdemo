import 'package:block_flutter/data/userData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/image.dart';
import '../block/userBlock.dart';
import '../events/events.dart';
import '../stats/userStats.dart';

class AlbumsScreen extends StatefulWidget {
  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  @override
  void initState() {
    super.initState();
    _loadAlbums();
  }

  _loadAlbums() async {
    context.bloc<AlbumsBloc>().add(userEvents.fetchUserData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: _body(),
    );
  }

  _body() {

    return
      Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocBuilder<AlbumsBloc, AlbumsState>(
            builder: (BuildContext context, AlbumsState state) {
          if (state is AlbumsListError) {
            final error = state.error;
            String message = '${error.message}\nTap to Retry.';
            return Text(error.toString());
          }
          if (state is AlbumsLoaded) {
            List<User> albums = state.albums;
            return _list(albums);
          }
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }),
      ],
    );

  }

  Widget _list(List<User> albums) {
    return Expanded(
      child: ListView.builder(
        itemCount: albums.length,
        itemBuilder: (_, index) {
          User album = albums[index];
          return OnGoingTile(
            onTap: () {},
            image: album.profilePic,
            price: album.totalPayableAmount,
            title: album.businessName,
            orderId: index.toString(),
            address: album.profilePic.toString(),
          );
        },
      ),
    );
  }
}

class OnGoingTile extends StatelessWidget {
  final String title, address, image, foodList, orderId, price;
  final Function onTap;

  OnGoingTile({
    this.title,
    this.address,
    this.image,
    this.foodList,
    this.orderId,
    this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Card(
          color: Colors.white,
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Card(
                      color: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: CustomRoundCornerImage(
                        height: 50,
                        width: 50,
                        image: image,
                        placeholder: 'ic_placeholder.png',
                        bottomRightCorner: 10,
                        bottomLeftCorner: 10,
                        topLeftCorner: 10,
                        topRightCorner: 10,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            address,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Text(
                        price,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  orderId,
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
