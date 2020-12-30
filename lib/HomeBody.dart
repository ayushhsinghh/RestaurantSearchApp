import 'package:MyTaste/api_handlers/modal%20class/restaurantItem.dart';
import 'package:MyTaste/api_handlers/modal%20class/searchresturant.dart';
import 'package:MyTaste/constants.dart';
import 'package:MyTaste/main.dart';
import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:MyTaste/main.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import 'components/searchForm.dart';

class HomeBody extends StatefulWidget {
  HomeBody({Key key}) : super(key: key);
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  var latitude;
  var longitude;

  getlocation() async {
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  Future<List> searchZomato(String query) async {
    final response = await dio.get('search', queryParameters: {
      'q': query,
      'lat': latitude,
      'lon': longitude,
      'sort': 'real_distance',
    });
    return response.data['restaurants'];
  }

  Future<List> zomatosearchlist;

  furereSearchZomato(String que) async {
    await getlocation();
    zomatosearchlist = searchZomato(que);
    return zomatosearchlist;
  }

  var searchText;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.amber[50],
      margin: EdgeInsets.only(
        top: 5,
      ),
      child: Column(
        children: <Widget>[
          SearchForm(
            onSearch: (q) {
              setState(() {
                searchText = q;
                furereSearchZomato(searchText);
              });
            },
          ),

          searchText == null
              ? Expanded(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 80,
                      color: Colors.black12,
                    ),
                    Text(
                      "Search For Food",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ))
              : FutureBuilder(
                  future: zomatosearchlist,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView(
                          children: snapshot.data
                              .map<Widget>(
                                  (json) => RestuarantItem(Restaurant(json)))
                              .toList(),
                        ),
                      );
                    }
                    return Text("Got Error Retriving Data ${snapshot.error}");
                  })
          // :
        ],
      ),
    );
  }
}
