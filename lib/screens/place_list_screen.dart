import 'package:flutter/material.dart';
import 'package:greatplacesapphome/providers/great_places.dart';
import 'package:greatplacesapphome/screens/add_place_screen.dart';
import 'package:greatplacesapphome/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndsetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                // ignore: prefer_const_constructors
                child: Center(
                  child:
                      const Text('Got No Places Yet,Start Adding Some Places'),
                ),
                builder: (ctx, greatplaces, ch) => greatplaces.items.length <= 0
                    ? ch!
                    : ListView.builder(
                        itemCount: greatplaces.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatplaces.items[i].image),
                          ),
                          title: Text(greatplaces.items[i].title),
                          subtitle:
                              Text(greatplaces.items[i].location!.address!),
                          onTap: () {
                            // Go To Detail Page
                            Navigator.of(context).pushNamed(
                                PlaceDetailScreen.routeName,
                                arguments: greatplaces.items[i].id);
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
