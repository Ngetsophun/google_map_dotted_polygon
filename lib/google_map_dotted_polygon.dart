library google_map_dotted_polygon;

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// GoogleMapDottedPolygon
/// A helper class to draw dotted or dashed polygons on Google Maps.
/// Developed by Nget Sophun © 2025
class GoogleMapDottedPolygon {
  /// Creates a dotted polygon based on a list of LatLng points.
  ///
  /// [points] – List of LatLng defining the area.
  /// [color] – Color of the dotted line.
  /// [gap] – Distance between each dot (default 0.0003).
  /// [width] – Stroke width of dots.
  static Set<Polyline> createDottedPolygon({
    required List<LatLng> points,
    Color color = Colors.red,
    double gap = 0.0003,
    double width = 2,
  }) {
    final Set<Polyline> dottedPolylines = {};

    for (int i = 0; i < points.length; i++) {
      final start = points[i];
      final end = points[(i + 1) % points.length];
      final dottedSegments = _createDottedLine(start, end, gap);

      for (int j = 0; j + 1 < dottedSegments.length; j += 2) {
        dottedPolylines.add(
          Polyline(
            polylineId: PolylineId('dotted-$i-$j'),
            points: [dottedSegments[j], dottedSegments[j + 1]],
            width: width.toInt(),
            color: color,
            patterns: [PatternItem.dash(10.0), PatternItem.gap(5.0)],
          ),
        );
      }
    }

    return dottedPolylines;
  }

  /// Helper function that returns small segments between [start] and [end].
  static List<LatLng> _createDottedLine(LatLng start, LatLng end, double gap) {
    final points = <LatLng>[];
    double dist = sqrt(
      pow(end.latitude - start.latitude, 2) +
          pow(end.longitude - start.longitude, 2),
    );
    int steps = (dist / gap).floor();

    for (int i = 0; i < steps; i++) {
      double t1 = i / steps, t2 = (i + 0.5) / steps;
      points.add(
        LatLng(
          start.latitude + (end.latitude - start.latitude) * t1,
          start.longitude + (end.longitude - start.longitude) * t1,
        ),
      );
      points.add(
        LatLng(
          start.latitude + (end.latitude - start.latitude) * t2,
          start.longitude + (end.longitude - start.longitude) * t2,
        ),
      );
    }
    return points;
  }
}
