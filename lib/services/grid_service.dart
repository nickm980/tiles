import 'dart:convert';

import 'package:app2/models/Grid.dart';
import 'package:app2/models/tile_metadata.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

bool debugMode = true;

class TileServer {
  final String baseUrl;

  TileServer({required this.baseUrl});

  factory TileServer.debug() {
    return TileServer(baseUrl: "http://localhost:5000");
  }

  factory TileServer.production() {
    return TileServer(baseUrl: "https://myurl.com");
  }

  Future<Response> get(String path) async {
    if (path.startsWith("/")) {
      path.replaceFirst("/", "");
    }

    final uri = Uri.parse('$baseUrl$path');

    return http.get(uri);
  }
}

/// Provides services related to managing a grid of tiles.
class GridService {
  final TileServer server = TileServer.debug();
  late Grid grid;
  
  /// Gets the current grid if available, otherwise returns null.
  ///
  /// Returns a [Grid] object representing the current state of the cached grid
  Grid? getGrid() {
    return null;
  }

  /// Refreshes the grid data by fetching the latest information from the server.
  ///
  /// This method initiates a request to the server to update the grid data.
  /// After a successful refresh, the grid will reflect the latest changes.
  void refreshGrid() {
  }

  /// Retrieves metadata for a specific tile at the given coordinates [x] and [y].
  ///
  /// The [x] and [y] parameters represent the coordinates of the tile to fetch.
  /// Returns a [TileMetadata] object containing information about the tile.
  ///
  /// Throws an [Exception] if the request to the server fails or if the server
  /// responds with a non-200 status code.
  Future<TileMetadata> getTileMetadata(int x, int y) async {
    final response = await server.get("/pixel?x=$x&y=$y");

    if (response.statusCode == 200) {
      return TileMetadata.fromJson(json.decode(response.body));
    } else {
      throw Exception("Request failed");
    }
  }
}
