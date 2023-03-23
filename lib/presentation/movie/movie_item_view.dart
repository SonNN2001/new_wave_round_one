// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_wave_round_one/common/app_helper.dart';

import 'package:new_wave_round_one/presentation/movie/model/movie_presentation_model.dart';

class MovieItemView extends StatefulWidget {
  final MoviePresentationModel model;
  const MovieItemView({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<MovieItemView> createState() => _MovieItemViewState();
}

class _MovieItemViewState extends State<MovieItemView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CachedNetworkImage(
      imageUrl: widget.model.thumb,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(2, 5),
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.only(top: 8, right: 8),
                  decoration: const BoxDecoration(
                      color: Colors.redAccent, shape: BoxShape.circle),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.model.point.toString().substring(0, 1),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          widget.model.point.toString().substring(1, 3),
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 4, left: 8),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.model.year.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 15),
                      ),
                      Container(
                        constraints: BoxConstraints(
                            minWidth: getDeviceWidth(context) * 0.1,
                            maxWidth: getDeviceWidth(context) * 0.35),
                        child: Text(
                          widget.model.name.toUpperCase(),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) =>
          const Center(child: Icon(Icons.error)),
    );
  }
}
