/// Represents metadata information for a tile.
class TileMetadata {
  final int x;
  final int y;
  final String color;
  final String author;
  final int price;

  TileMetadata(
      {required this.x,
      required this.y,
      required this.color,
      required this.author,
      required this.price});

  factory TileMetadata.none(){
    return TileMetadata(x: 0, y: 0, color: "white", author: "None", price: 0);
  }
  /// Creates a [TileMetadata] instance from a JSON map.
  ///
  /// The [json] parameter should contain a JSON map with keys matching the
  /// expected properties: "x", "y", "color", "author", and "price".
  factory TileMetadata.fromJson(Map<String, dynamic> json) {
    return TileMetadata(
        x: json["x"],
        y: json["y"],
        color: json["color"],
        author: json["author"],
        price: json["price"]);
  }
}
