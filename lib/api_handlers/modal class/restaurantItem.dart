import 'package:MyTaste/api_handlers/modal%20class/searchresturant.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RestuarantItem extends StatelessWidget {
  final Restaurant restaurant;
  RestuarantItem(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 6,
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            restaurant.thumnail != null && restaurant.thumnail.isNotEmpty
                ? Ink(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(restaurant.thumnail),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    width: 100,
                    height: 100,
                    color: Colors.blueGrey,
                    child: Icon(
                      Icons.restaurant,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 25,
                        ),
                        Flexible(
                          child: Text(
                            "${restaurant.address}",
                            style: TextStyle(
                                fontSize: 13, fontStyle: FontStyle.normal),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Cuisines: ${restaurant.cuisines}",
                      style:
                          TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

    //ListTile(
    //   leading: Container(
    //     width: MediaQuery.of(context).size.width * .2,
    //     height: MediaQuery.of(context).size.height * .4,
    //     child:
    //   title: Text(restaurant.name),
    //   subtitle: Text(restaurant.address),
    //   trailing: Text(restaurant.localityVerbose),
    // );
  }
}
