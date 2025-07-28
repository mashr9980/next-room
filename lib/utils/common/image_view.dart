import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:shimmer/shimmer.dart';

class ImageView extends StatelessWidget {
  final String image;
  final Uint8List? videoImage;
  final double? borderRadius;
  final double? height;
  final double? width;
  final double? borderWidth;
  final Color? borderColor;
  final Color? color;
  final BoxFit? fit;
  final String? placeholder;
  final bool isCircle;
  final Gradient? placeGradient;

  const ImageView.circle({
    super.key,
    required this.image,
    this.placeholder,
    this.borderWidth,
    this.borderColor,
    this.width,
    this.height,
    this.color,
    this.fit,
    this.isCircle = true,
    this.borderRadius,
    this.placeGradient,
    this.videoImage,
  });

  const ImageView.rect({
    super.key,
    required this.image,
    this.placeholder,
    this.borderWidth,
    this.borderColor,
    this.color,
    this.width,
    this.height,
    this.fit,
    this.isCircle = false,
    this.borderRadius,
    this.placeGradient,
    this.videoImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius:
        isCircle ? null : BorderRadius.circular(borderRadius ?? 0),
        border: borderWidth != null && borderColor != null
            ? Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 15)
            : null,
      ),
      child: _buildImage(),
    );
  }

  Widget _buildImage() {
    if (videoImage != null) {
      return _videoWidget();
    }

    if (image.isEmpty) {
      return _placeholderWidget();
    }

    if (!image.contains("http")) {
      return _localImageWidget();
    }

    return _networkImageWidget();
  }

  Widget _localImageWidget() {
    return Container(
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius:
        isCircle ? null : BorderRadius.circular(borderRadius ?? 0),
        image: DecorationImage(
          image: FileImage(File(image)),
          fit: fit ?? BoxFit.cover,
        ),
      ),
    );
  }

  Widget _networkImageWidget() {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            color: color ?? Colors.transparent,
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius:
            isCircle ? null : BorderRadius.circular(borderRadius ?? 0),
            image: DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.cover,
            ),
          ),
        );
      },
      placeholder: (context, url) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: SizedBox(
            height: height ?? double.infinity,
            width: width ?? double.infinity,
          ),
        );
      },
      errorWidget: (context, url, error) {
        return _placeholderWidget();
      },
    );
  }

  Widget _placeholderWidget() {
    return Container(
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius:
        isCircle ? null : BorderRadius.circular(borderRadius ?? 0),
        image: DecorationImage(
          image: AssetImage(placeholder ?? ""),
          fit: fit ?? BoxFit.contain,
        ),
      ),
    );
  }

  Widget _videoWidget() {
    return Container(
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius:
        isCircle ? null : BorderRadius.circular(borderRadius ?? 0),
        image: DecorationImage(
          image: MemoryImage(videoImage!),
          fit: fit ?? BoxFit.contain,
        ),
      ),
    );
  }
}
