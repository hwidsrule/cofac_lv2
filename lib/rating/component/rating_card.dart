import 'package:cofac_lv2/common/const/colors.dart';
import 'package:cofac_lv2/rating/model/rating_model.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
// import 'package:flutter/rendering.dart';

class RatingCard extends StatelessWidget {
  final ImageProvider avatarImage;
  final String email;
  final int rating;
  final String content;
  final List<Image> images;

  const RatingCard({
    required this.avatarImage,
    required this.email,
    required this.rating,
    required this.content,
    required this.images,
    super.key,
  });

  factory RatingCard.fromModel({
    required RatingModel model,
  }) {
    return RatingCard(
      avatarImage: NetworkImage(model.user.imageUrl),
      email: model.user.username,
      rating: model.rating,
      content: model.content,
      images: model.imgUrls.map((e) => Image.network(e)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(
          avatarImage: avatarImage,
          email: email,
          rating: rating,
        ),
        const SizedBox(height: 8.0),
        _Body(
          content: content,
        ),
        const SizedBox(height: 8.0),
        if (images.isNotEmpty)
          SizedBox(
            height: 100,
            child: _Images(images: images),
          ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final ImageProvider avatarImage;
  final String email;
  final int rating;

  const _Header({
    required this.avatarImage,
    required this.email,
    required this.rating,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12.0,
          backgroundImage: avatarImage,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(email, overflow: TextOverflow.ellipsis),
        ),
        ...List.generate(
            5,
            (index) => index < rating
                ? const Icon(Icons.star, size: 16.0, color: PRIMARY_COLOR)
                : const Icon(Icons.star_border_outlined,
                    size: 16.0, color: PRIMARY_COLOR)),
        // Icon(
        //   Icons.star,
        // ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final String content;

  const _Body({
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            content,
            style: const TextStyle(
              color: BODY_TEXT_COLOR,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }
}

class _Images extends StatelessWidget {
  final List<Image> images;

  const _Images({
    required this.images,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: images
          .mapIndexed(
            (index, e) => Padding(
              padding:
                  EdgeInsets.only(right: index < images.length - 1 ? 16.0 : 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: e,
              ),
            ),
          )
          .toList(),
    );
  }
}
