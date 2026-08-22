import 'package:assignment9/db/db_handler.dart';
import 'package:assignment9/screens/widgets/contact_listile.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  DbHandler instance = DbHandler.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(context),
     body: _bodyUi(context));
  }

  Widget _getFavouriteContacts(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: instance.getFavourites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(strokeWidth: 3));
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: MediaQuery.sizeOf(context).height * .3),
                Center(
                  child: Icon(
                    Icons.star_border_sharp,
                    size: 100,
                    color: Colors.black.withAlpha(150),
                  ),
                ),
               const  SizedBox(height: 20),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                     const TextSpan(
                        text: 'No Favourite Contacts yet!\n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Add Your First Favourite Contacts\n By Tapping..\n',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                          color: Colors.black.withAlpha(100),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final data = snapshot.data![index];
              return ContactTile(contact: data ,isCallFromFavourite: true,
              onTap:(){} ,
              );
            },
          );
        },
      ),
    );
  }

  Widget _bodyUi(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [_getFavouriteContacts(context)]),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: Text('Favourites'),
      actions: [
        Icon(Icons.search),
        SizedBox(width: 4),
        Icon(Icons.more_vert),
        SizedBox(width: 10),
      ],
    );
  }
}
