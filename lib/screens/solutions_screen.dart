import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive_navbar.dart';
import '../widgets/app_footer.dart';

// --- DUMMY DATA FOR SOLUTIONS SCREEN ---
class SolutionItem {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  // Constructor fixed: removed duplicate 'required'
  SolutionItem({required this.title, required this.description, required this.icon, required this.color});
}

final List<SolutionItem> _keySolutions = [
  SolutionItem(
    title: 'Optimized Supply Chain',
    description: 'End-to-end management, inventory optimization, and just-in-time (JIT) delivery for clinical settings.',
    icon: Icons.alt_route, // Icon added/corrected
    color: AppColors.primaryBlue,
  ),
  SolutionItem(
    title: 'Validated Cold Chain',
    description: 'Continuous temperature monitoring, validated packaging, and regulatory compliance for sensitive biologics.',
    icon: Icons.ac_unit,
    color: AppColors.darkBlue,
  ),
  SolutionItem(
    title: 'Precision Asset Tracking',
    description: 'Real-time RFID and IoT tracking of high-value equipment to maximize utilization and prevent loss.',
    icon: Icons.location_searching,
    color: AppColors.primaryGreen,
  ),
  SolutionItem(
    title: 'Strategic Procurement',
    description: 'Access to a global network for sourcing specialized, hard-to-find, or bulk medical equipment.',
    icon: Icons.gavel,
    color: AppColors.primaryGreen.withOpacity(0.8), // Using a darker green shade for variety
  ),
];

// --- MAIN SCREEN WIDGET ---
class SolutionsScreen extends StatelessWidget {
  const SolutionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 1000;
    
    return Scaffold(
      // 1. Navbar
      appBar: const ResponsiveNavBar(),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 2. Hero Section
            _buildHero(context),

            // 3. Key Solutions Grid
            _buildSolutionsGrid(context, isDesktop),

            // 4. In-Depth Feature: Cold Chain Focus
            _buildDetailedColdChain(context, isDesktop),

            // 5. Compliance & Trust Banner
            _buildComplianceBanner(context),

            // 6. Footer CTA
            _buildFooterCTA(context),

            // 7. Footer
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
      // Blue/Green Gradient Background
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryBlue.withOpacity(0.1), // Light blue start
            AppColors.primaryGreen.withOpacity(0.1),  // Light green end
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Custom Logistics Solutions for Healthcare Pioneers',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.darkBlue,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 25),
          Text(
            'We don\'t just move products; we engineer resilient supply chains tailored to your operational complexity, ensuring maximum efficiency and unwavering compliance.',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.handshake, color: Colors.white),
            label: const Text('Book a Solution Consultation', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 8,
            ),
          ),
        ],
      ),
    );
  }

  // --- SECTION 2: KEY SOLUTIONS GRID ---
  Widget _buildSolutionsGrid(BuildContext context, bool isDesktop) {
    final int crossAxisCount = isDesktop ? 4 : (MediaQuery.of(context).size.width > 600 ? 2 : 1);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80.0 : 20.0, vertical: 80.0),
      child: Column(
        children: [
          Text(
            'Solve Your Biggest Logistics Challenges',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGreen,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _keySolutions.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 30.0,
              mainAxisSpacing: 30.0,
              childAspectRatio: isDesktop ? 1.0 : 1.2, 
            ),
            itemBuilder: (context, index) {
              final item = _keySolutions[index];
              return _SolutionCard(
                item: item,
                isDesktop: isDesktop,
              );
            },
          ),
        ],
      ),
    );
  }

  // --- SECTION 3: IN-DEPTH FEATURE (Cold Chain Focus) ---
  Widget _buildDetailedColdChain(BuildContext context, bool isDesktop) {
    // Determine the layout based on desktop vs mobile
    Widget content = isDesktop
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildColdChainText(context)),
              const SizedBox(width: 50),
              Expanded(child: _buildColdChainFeatures(context)),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildColdChainText(context),
              const SizedBox(height: 40),
              _buildColdChainFeatures(context),
            ],
          );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80.0 : 20.0, vertical: 80.0),
      color: const Color(0xFFF7F9FC), // Very light background
      child: content,
    );
  }

  Widget _buildColdChainText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Chip(
          label: const Text('FEATURED SOLUTION', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
          backgroundColor: AppColors.primaryBlue,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        const SizedBox(height: 20),
        Text(
          'Next-Generation Temperature-Controlled Logistics',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkBlue,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Handling life-saving drugs and biological samples requires zero-tolerance on temperature deviations. Our solution combines advanced active and passive technologies with specialized personnel training.',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.textMuted),
        ),
      ],
    );
  }

  Widget _buildColdChainFeatures(BuildContext context) {
    return Column(
      children: [
        _FeatureBullet(
          icon: Icons.thermostat,
          title: 'Active and Passive Packaging',
          subtitle: 'Utilizing phase change materials (PCMs) and active refrigeration units for multi-day protection.',
          color: AppColors.primaryBlue,
        ),
        _FeatureBullet(
          icon: Icons.sensors,
          title: '24/7 Sensor Monitoring',
          subtitle: 'Real-time data loggers with cloud access and automated alerts for proactive intervention.',
          color: AppColors.darkBlue,
        ),
        _FeatureBullet(
          icon: Icons.verified_user,
          title: 'Regulatory Validation',
          subtitle: 'Full qualification protocols (IQ/OQ/PQ) ensuring adherence to global GDP guidelines.',
          color: AppColors.primaryGreen,
        ),
      ],
    );
  }

  // --- SECTION 4: COMPLIANCE & TRUST BANNER ---
  Widget _buildComplianceBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primaryGreen,
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 30,
            runSpacing: 20,
            children: [
              _TrustBadge(icon: Icons.security, title: 'HIPAA Compliant', color: Colors.white),
              _TrustBadge(icon: Icons.science, title: 'GAMP 5 Ready', color: Colors.white),
              _TrustBadge(icon: Icons.iso, title: 'ISO 9001:2015', color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }


  // --- SECTION 5: FOOTER CTA ---
  Widget _buildFooterCTA(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.darkBlue,
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Text(
                'Ready to Build a Resilient Supply Chain?',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textLight,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                'Schedule a free consultation with our logistics architects to design a bespoke solution that transforms your operational challenges into competitive advantages.',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.textMuted),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.calendar_today, color: AppColors.primaryGreen),
                label: const Text('Schedule Consultation', style: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
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

// --- WIDGETS USED IN SOLUTIONS SCREEN ---

class _SolutionCard extends StatelessWidget {
  final SolutionItem item;
  final bool isDesktop;

  const _SolutionCard({required this.item, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: item.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item.icon, size: 35, color: item.color),
            ),
            
            const SizedBox(height: 20),
            
            // Title
            Text(
              item.title, 
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.darkBlue, 
                fontWeight: FontWeight.w700
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 10),
            
            // Description
            Text(item.description, style: const TextStyle(color: AppColors.textMuted)),
            
            const Spacer(),

            // CTA Link
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.arrow_right_alt, size: 24, color: item.color),
              label: Text('Learn More', style: TextStyle(color: item.color, fontWeight: FontWeight.bold)), 
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureBullet extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _FeatureBullet({required this.icon, required this.title, required this.subtitle, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Icon(icon, size: 24, color: color),
          const SizedBox(width: 15),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TrustBadge extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _TrustBadge({required this.icon, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 28, color: color),
        const SizedBox(width: 10),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: color, 
            fontWeight: FontWeight.w600
          ),
        ),
      ],
    );
  }
}