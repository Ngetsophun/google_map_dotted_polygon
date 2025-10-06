# 🗺️ google_map_dotted_polygon

A Flutter package to draw **dotted or dashed polygons** on **Google Maps** — perfect for visualizing map zones, areas, or custom boundaries.

---
## Example Screenshot

![Dotted Polygon Example](https://raw.githubusercontent.com/Ngetsophun/google_map_dotted_polygon/main/example/assets/screenshot.jpg)

## ✨ Features

✅ Draw **dotted** or **dashed** polygons  
✅ Customize **color**, **gap**, and **stroke width**  
✅ Lightweight and **easy to integrate**  
✅ Works with `google_maps_flutter`

---

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  google_map_dotted_polygon: ^0.0.1


## Usage

final dottedPolygons = GoogleMapDottedPolygon.createDottedPolygon(
  points: myZonePoints,
  color: Colors.red,
  gap: 0.0003,
);
