import 'package:BandoBasta/Pages/homepage/widgets/service_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../route_helper/route_helper.dart';

class ServiceList {
  final List service = [
    GestureDetector(
        onTap: () {
          Get.toNamed(RouteHelper.getSearchVenue());
        },
        child: const ServiceItems(icon: Icons.location_on, title: "Venue")),
    const ServiceItems(icon: Icons.person, title: "Priest"),
    const ServiceItems(icon: Icons.camera_alt, title: "Photographer"),
    const ServiceItems(icon: Icons.face, title: "Bridal Makeup"),
    const ServiceItems(icon: Icons.music_note, title: "DJ Service"),
    const ServiceItems(icon: Icons.brush, title: "Henna Artist"),
    const ServiceItems(icon: Icons.card_giftcard, title: "Decoration"),
    const ServiceItems(icon: Icons.diamond, title: "Jewellery"),
  ];
}
