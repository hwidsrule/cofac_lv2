import 'package:flutter/material.dart';
import 'package:my_delivery/common/const/colors.dart';
import 'package:my_delivery/restaurant/model/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  final Widget image;
  final String name;
  final List<String> tags;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;
  final double ratings;

  const RestaurantCard({
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
    super.key,
  });

  factory RestaurantCard.fromModel({required RestaurantModel rModel}) {
    return RestaurantCard(
      image: Image.network(
        rModel.thumbUrl,
        fit: BoxFit.cover,
      ),
      name: rModel.name,
      tags: rModel.tags,
      ratingsCount: rModel.ratingCount,
      deliveryTime: rModel.deliveryTime,
      deliveryFee: rModel.deliveryFee,
      ratings: rModel.ratings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: image,
        ),
        const SizedBox(height: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4.0),
            Text(
              tags.join(' · '),
              style: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14.0),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            _IconText(icon: Icons.star, label: ratings.toString()),
            renderDot(),
            _IconText(icon: Icons.receipt, label: ratingsCount.toString()),
            renderDot(),
            _IconText(icon: Icons.timelapse_outlined, label: '$deliveryTime분'),
            renderDot(),
            _IconText(
                icon: Icons.monetization_on,
                label: deliveryFee == 0 ? '무료' : '$deliveryFee원'),
          ],
        )
      ],
    );
  }

  Widget renderDot() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        '·',
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({
    required this.icon,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 14.0,
        ),
        const SizedBox(width: 8.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
