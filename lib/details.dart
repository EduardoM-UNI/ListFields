import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final String itemTitle;
  final String image;
  final String geocoordinates;
  Details(this.itemTitle,this.image, this.geocoordinates);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Container(
          color: Colors.grey.shade300,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: 500,
          width: double.maxFinite,
          child: Column(
            children: [
              Expanded(child: Image.network(image),),
              const SizedBox(width: 10),
              Expanded(child: Text(itemTitle)),
              Expanded(child: Text(geocoordinates)),
            ],
          ),
        )
    );
  }
}