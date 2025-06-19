import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/destinations_provider.dart';
import '../models/destination.dart';
import 'destination_detail_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Destinations Map'),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<DestinationsProvider>(
        builder: (context, destinationsProvider, child) {
          if (destinationsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final destinations = destinationsProvider.destinations;

          return Stack(
            children: [
              // Map placeholder with destination pins
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=800'),
                    fit: BoxFit.cover,
                    opacity: 0.3,
                  ),
                ),
                child: CustomPaint(
                  painter: MapPainter(destinations),
                  size: Size.infinite,
                ),
              ),
              
              // Destination list overlay
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Destinations (${destinations.length})',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: destinations.length,
                          itemBuilder: (context, index) {
                            final destination = destinations[index];
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              margin: const EdgeInsets.only(right: 12),
                              child: Card(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DestinationDetailScreen(
                                          destination: destination,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            destination.images.first,
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Container(
                                                width: 50,
                                                height: 50,
                                                color: Colors.grey[300],
                                                child: const Icon(Icons.image_not_supported),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                destination.name,
                                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                destination.location,
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  color: Colors.grey[600],
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                '${destination.currency} ${destination.price.toStringAsFixed(0)}',
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  color: Theme.of(context).primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Category Legend
              Positioned(
                top: 16,
                right: 16,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Categories',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        _buildLegendItem('Cultural', Colors.red),
                        _buildLegendItem('Beach', Colors.blue),
                        _buildLegendItem('Urban', Colors.green),
                        _buildLegendItem('Adventure', Colors.orange),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLegendItem(String category, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(category, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class MapPainter extends CustomPainter {
  final List<Destination> destinations;

  MapPainter(this.destinations);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // Draw simplified markers for each destination
    for (int i = 0; i < destinations.length; i++) {
      final destination = destinations[i];
      // Convert lat/lng to screen coordinates (simplified)
      final x = (destination.longitude + 180) / 360 * size.width;
      final y = (90 - destination.latitude) / 180 * size.height;
      
      // Draw marker
      canvas.drawCircle(
        Offset(x, y),
        8,
        paint..color = _getCategoryColor(destination.category),
      );
      
      // Draw white border
      canvas.drawCircle(
        Offset(x, y),
        8,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'cultural':
        return Colors.red;
      case 'beach':
        return Colors.blue;
      case 'urban':
        return Colors.green;
      case 'adventure':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
} 