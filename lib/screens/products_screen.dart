import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../constants/app_constants.dart';
import '../widgets/responsive_navbar.dart';
import '../widgets/app_footer.dart';

// --- DUMMY DATA FOR PRODUCTS SCREEN ---
class ProductData {
  final String title;
  final String description;
  final IconData icon;
  final String tag;
  final Color color;

  ProductData({required this.title, required this.description, required this.icon, required this.tag, required this.color});
}

final List<ProductData> _featuredProducts = [
  ProductData(
    title: 'Ultra-Low Temperature Freezers',
    description: 'Reliable, energy-efficient storage down to -86°C for biological samples and critical vaccines.',
    icon: Icons.ac_unit,
    tag: 'Cold Chain',
    color: AppColors.primaryBlue,
  ),
  ProductData(
    title: 'High-Resolution Digital Microscopes',
    description: 'Advanced optics and automated imaging for high-throughput laboratory analysis and diagnostics.',
    icon: Icons.science,
    tag: 'Laboratory Tech',
    color: AppColors.primaryGreen,
  ),
  ProductData(
    title: 'Smart Infusion Pumps (IoT)',
    description: 'Networked pumps with dose error reduction software, ensuring patient safety and accurate medication delivery.',
    icon: Icons.medical_services,
    tag: 'Patient Care',
    // FIX: Replaced AppColors.primaryRed with a dark blue theme color
    color: AppColors.darkBlue, 
  ),
  ProductData(
    title: 'Portable Diagnostic Ultrasound',
    description: 'Compact, battery-powered imaging for emergency services and remote medical outreach programs.',
    icon: Icons.monitor_heart,
    tag: 'Imaging & Diagnostics',
    // FIX: Replaced AppColors.teal with primary green
    color: AppColors.primaryGreen, 
  ),
  ProductData(
    title: 'Hospital Asset Tracking Tags (RFID)',
    description: 'Real-time location and utilization data for beds, wheelchairs, and critical mobile equipment.',
    icon: Icons.location_on,
    tag: 'Logistics Tech',
    color: AppColors.textMuted,
  ),
  ProductData(
    title: 'Sterile Surgical Consumables Kit',
    description: 'Pre-packaged, certified sterile kits designed for efficiency in operating rooms and minor procedures.',
    icon: Icons.precision_manufacturing,
    tag: 'Consumables',
    color: AppColors.darkBlue,
  ),
];

// --- MAIN SCREEN WIDGET ---
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine if the screen is desktop size for responsive layout adjustments
    bool isDesktop = MediaQuery.of(context).size.width > 1000;
    
    // The screen now includes its own Scaffold, Navbar, and Footer
    return Scaffold(
      appBar: const ResponsiveNavBar(), 
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Hero Section
            _buildHero(context),

            // 2. Core Categories Section
            _buildCoreCategories(context, isDesktop),

            // 3. Featured Products Grid
            _buildFeaturedProducts(context, isDesktop),

            // 4. Technical Focus Section (Cold Chain/Compliance)
            _buildTechnicalFocus(context, isDesktop),

            // 5. Call to Action (CTA) Banner
            _buildCTABanner(context),

            // 6. Footer
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  // --- SECTION 1: HERO ---
  Widget _buildHero(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.1, 
        vertical: 100.0,
      ),
      // FIX: Implemented Green/Blue Gradient
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryGreen.withOpacity(0.1), // Light green start
            AppColors.primaryBlue.withOpacity(0.1),  // Light blue end
          ], 
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'High-Grade Medical Products. Delivered.',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.darkBlue,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'From advanced laboratory instruments to critical patient care consumables, explore our meticulously curated catalog designed for reliability and compliance in the most demanding healthcare environments.',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download, color: Colors.white),
            label: const Text('Download Full Catalog (PDF)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }

  // --- SECTION 2: CORE CATEGORIES ---
  Widget _buildCoreCategories(BuildContext context, bool isDesktop) {
    final List<Map<String, dynamic>> categories = [
      // FIX: Replaced AppColors.primaryRed with Dark Blue
      {'title': 'Clinical Devices', 'icon': Icons.favorite_border, 'color': AppColors.darkBlue},
      {'title': 'Lab & Research', 'icon': Icons.biotech, 'color': AppColors.primaryBlue},
      // FIX: Replaced AppColors.teal with Primary Green
      {'title': 'Surgical Consumables', 'icon': Icons.gavel, 'color': AppColors.primaryGreen},
      {'title': 'Cold Chain Solutions', 'icon': Icons.thermostat, 'color': AppColors.darkBlue},
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100.0 : 20.0, vertical: 60.0),
      color: AppColors.lightBackground,
      child: Column(
        children: [
          Text(
            'Specialized Product Streams',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkBlue,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            alignment: WrapAlignment.center,
            children: categories.map((cat) => _CategoryPill(
              title: cat['title'],
              icon: cat['icon'],
              color: cat['color'],
            )).toList(),
          ),
        ],
      ),
    );
  }

  // --- SECTION 3: FEATURED PRODUCTS GRID ---
  Widget _buildFeaturedProducts(BuildContext context, bool isDesktop) {
    final int crossAxisCount = isDesktop ? 3 : 1;
    final double childAspectRatio = isDesktop ? 1.2 : 2.5;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100.0 : 20.0, vertical: 80.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured Equipment & Technology',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'A glimpse into our leading-edge inventory, focused on performance and regulatory clearance.',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 50),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _featuredProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 30.0,
              mainAxisSpacing: 30.0,
              childAspectRatio: childAspectRatio,
            ),
            itemBuilder: (context, index) {
              final product = _featuredProducts[index];
              return _ProductCard(
                title: product.title,
                icon: product.icon,
                description: product.description,
                tag: product.tag,
                color: product.color,
              );
            },
          ),
        ],
      ),
    );
  }

  // --- SECTION 4: TECHNICAL FOCUS (Compliance) ---
  Widget _buildTechnicalFocus(BuildContext context, bool isDesktop) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100.0 : 20.0, vertical: 80.0),
      color: const Color(0xFFF0F4F8), // Subtle background for contrast
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'The Spectrum Quality Guarantee',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGreen,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Text(
            'Every product in our catalog adheres to rigorous international standards, ensuring patient and operational safety.',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.textDark),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          isDesktop ? _buildComplianceRow(context) : _buildComplianceColumn(context),
        ],
      ),
    );
  }

  Widget _buildComplianceRow(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ComplianceFeature(icon: Icons.gpp_good, title: 'Regulatory Clearance', subtitle: 'FDA, CE, and country-specific approvals verified.'),
        _ComplianceFeature(icon: Icons.safety_check, title: 'ISO 13485 Certified', subtitle: 'Compliance in Medical Device Quality Management.'),
        _ComplianceFeature(icon: Icons.local_shipping, title: 'Validated Cold Chain', subtitle: 'Full temperature monitoring traceability for sensitive goods.'),
      ],
    );
  }

  Widget _buildComplianceColumn(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ComplianceFeature(icon: Icons.gpp_good, title: 'Regulatory Clearance', subtitle: 'FDA, CE, and country-specific approvals verified.'),
        SizedBox(height: 30),
        _ComplianceFeature(icon: Icons.safety_check, title: 'ISO 13485 Certified', subtitle: 'Compliance in Medical Device Quality Management.'),
        SizedBox(height: 30),
        _ComplianceFeature(icon: Icons.local_shipping, title: 'Validated Cold Chain', subtitle: 'Full temperature monitoring traceability for sensitive goods.'),
      ],
    );
  }

  // --- SECTION 5: CTA BANNER ---
  Widget _buildCTABanner(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.darkBlue,
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 60.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              Text(
                'Need a Custom Sourcing Solution?',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textLight,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                'Our procurement experts can locate specialized, hard-to-find equipment and manage the entire supply process.',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.textMuted),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.support_agent, color: AppColors.primaryGreen),
                label: const Text('Speak to a Specialist', style: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primaryGreen, width: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- WIDGETS USED IN PRODUCTS SCREEN ---

class _ProductCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;
  final String tag;
  final Color color;

  const _ProductCard({required this.title, required this.icon, required this.description, required this.tag, required this.color});

  @override
  Widget build(BuildContext context) {
    // Determine aspect ratio based on screen size for consistent card look
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Card(
      elevation: 8,
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tag (Chip)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(tag, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: isMobile ? 12 : 14)),
            ),
            
            const Spacer(),
            
            // Icon and Title
            Row(
              children: [
                Icon(icon, size: isMobile ? 30 : 40, color: color), 
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title, 
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.primaryBlue, 
                      fontWeight: FontWeight.w700
                    ), 
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ), 
              ],
            ),
            
            const SizedBox(height: 15),
            
            // Description
            Text(description, style: const TextStyle(color: AppColors.textMuted)),
            
            const Spacer(),

            // CTA Button
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_ios, size: 16, color: color),
              label: Text('Request Quote', style: TextStyle(color: color, fontWeight: FontWeight.bold)), 
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _CategoryPill({required this.title, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            radius: 20,
            child: Icon(icon, size: 24, color: color),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComplianceFeature extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ComplianceFeature({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primaryGreen.withOpacity(0.1),
            radius: 35,
            child: Icon(icon, size: 40, color: AppColors.primaryGreen),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkBlue,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}