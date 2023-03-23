import 'package:flutter/cupertino.dart';

String fullUrlImage(String url) {
  return 'https://image.tmdb.org/t/p/original$url';
}

double getDeviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
