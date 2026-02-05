import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart'; // Ensure this matches your folder structure

class MedicalProductDetailScreen extends StatefulWidget {
  final String productId;

  const MedicalProductDetailScreen({super.key, required this.productId});

  @override
  State<MedicalProductDetailScreen> createState() => _MedicalProductDetailScreenState();
}

class _MedicalProductDetailScreenState extends State<MedicalProductDetailScreen> {
  // Placeholder for product data. In a real app, you would fetch this from Firebase.
  late Map<String, dynamic> _productData;

  @override
  void initState() {
    super.initState();
    _loadProductData();
  }

  void _loadProductData() {
    // SIMULATED DATA: matching the ID passed in, or falling back to a default
    // You can replace this logic with your Firebase/Backend call later.
    _productData = {
      'id': widget.productId,
      'name': 'Advanced MRI Scanner X${widget.productId}',
      'manufacturer': 'Spectrum Imaging',
      'price': '\$125,000',
      'description':
          'High-fidelity magnetic resonance imaging system designed for rapid diagnostics. '
          'Features include reduced noise levels, faster scan times, and AI-assisted imagery analysis. '
          'Ideal for high-volume trauma centers and specialized clinics.',
      'specs': [
        '1.5 Tesla Field Strength',
        '70cm Open Bore Design',
        'Silent Scan Technology',
        'Weight: 4,500 kg',
      ],
      'imageUrl': 'https://via.placeholder.com/600x400/1976D2/FFFFFF?text=Medical+Device', // Placeholder image
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // --- 1. Sliver App Bar with Hero Image ---
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            backgroundColor: AppColors.primaryBlue,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                _productData['name'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  shadows: [Shadow(color: Colors.black45, blurRadius: 10)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    _productData['imageUrl'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.medical_services, size: 80, color: Colors.white),
                      );
                    },
                  ),
                  // Gradient overlay for text readability
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.pop(),
            ),
          ),

          // --- 2. Product Details Body ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Manufacturer & Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        label: Text(_productData['manufacturer']),
                        backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                        labelStyle: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _productData['price'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Description Title
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Description Text (This was causing your error before)
                  Text(
                    _productData['description'],
                    style: const TextStyle(
                      height: 1.6,
                      fontSize: 16,
                      // Using textDark (aliased as textMain in your theme now)
                      color: Colors.blue, 
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Specifications
                  const Text(
                    "Technical Specifications",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...(_productData['specs'] as List<String>).map((spec) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_outline, size: 20, color: AppColors.teal),
                            const SizedBox(width: 10),
                            Text(
                              spec,
                              style: const TextStyle(color: AppColors.textMuted, fontSize: 15),
                            ),
                          ],
                        ),
                      )),

                  const SizedBox(height: 40),

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement Add to Cart or Order Logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Request added to logistics queue')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppColors.darkBlue,
                      ),
                      child: const Text("REQUEST LOGISTICS QUOTE"),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}