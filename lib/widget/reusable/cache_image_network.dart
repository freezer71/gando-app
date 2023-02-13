import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

CachedNetworkImage buildCacheNetworkImage({double? width, double? height, url, plColor}){
  if(width == 0 && height == 0){
    return CachedNetworkImage(
      placeholder: (context, url) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            color: plColor ?? Colors.grey[200],
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          color: Colors.grey[200],
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.image_not_supported, size: 80, color: Colors.grey,),
                SizedBox(height: 10,),
                Text('Erreur lors du chargement de l\'image'),
              ],
            ),
          ),
        );
      },
      imageUrl: url,
      fit: BoxFit.cover,
    );
  } else if(height == 0){
    return CachedNetworkImage(
      placeholder: (context, url) {
        return Container(
          width: width,
          color: plColor ?? Colors.grey[200],
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          width: width,
          color: Colors.grey[200],
        );
      },
      imageUrl: url,
      fit: BoxFit.cover,
      width: width,
    );
  } else {
    return CachedNetworkImage(
      placeholder: (context, url) {
        return Container(
          width: width,
          height: height,
          color: plColor ?? Colors.grey[200],
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey[200],
        );
      },
      imageUrl: url,
      fit: BoxFit.cover,
      width: width,
      height: height,
    );
  }
}