import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive_navbar.dart';
import '../widgets/app_footer.dart';

// --- 1. DUMMY DATA FOR SERVICES SCREEN ---
class ServiceCategory {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  ServiceCategory({required this.title, required this.description, required this.icon, required this.color});
}

final List<ServiceCategory> _coreServices = [
  ServiceCategory(
    title: 'Precision Global Freight',
    description: 'Specialized air, ocean, and ground transport for high-value and time-critical medical freight.',
    icon: Icons.flight_takeoff,
    color: AppColors.primaryBlue,
  ),
  ServiceCategory(
    title: 'White Glove Installation',
    description: 'Certified engineers handle setup, calibration, and commissioning of complex medical devices on site.',
    icon: Icons.handshake,
    color: AppColors.primaryGreen,
  ),
  ServiceCategory(
    title: 'Regulatory & Customs',
    description: 'Full compliance management for import/export, ensuring adherence to FDA, CE, and local health standards.',
    icon: Icons.gavel,
    color: AppColors.darkBlue,
  ),
  ServiceCategory(
    title: 'Temperature-Controlled Storage',
    description: 'Validated warehousing with controlled room temperature (CRT) and cold chain storage zones.',
    icon: Icons.warehouse,
    color: AppColors.primaryBlue, // Reuse primary color
  ),
];

final List<Map<String, dynamic>> _processSteps = [
  {'title': 'Consult & Scope', 'desc': 'Detailed needs assessment and customized logistics blueprint creation.', 'icon': Icons.lightbulb_outline},
  {'title': 'Compliance Check', 'desc': 'Pre-shipment regulatory screening and documentation preparation.', 'icon': Icons.verified_user_outlined},
  {'title': 'Validated Transport', 'desc': 'Execution via specialized carriers with real-time tracking and monitoring.', 'icon': Icons.local_shipping_outlined},
  {'title': 'Last Mile & Install', 'desc': 'On-site delivery, unpacking, placement, and technical installation.', 'icon': Icons.home_work_outlined},
  {'title': 'Post-Delivery Audit', 'desc': 'Final documentation handover and performance review.', 'icon': Icons.list_alt},
];

// --- 2. MAIN SCREEN WIDGET ---
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 1000;
    
    return Scaffold(
      // 1. Navbar
      appBar: const ResponsiveNavBar(),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 2. Hero Section (Green/Blue Gradient)
            _buildHero(context),

            // 3. Core Services Grid
            _buildCoreServicesGrid(context, isDesktop),

            // 4. Process Flow/Infographic
            _buildProcessFlow(context, isDesktop),

            // 5. Specialized Service Focus (Engineering & Maintenance)
            _buildSpecializedFocus(context, isDesktop),

            // 6. Call to Action Banner
            _buildCTABanner(context),

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
      // Green/Blue Gradient Background
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryGreen.withOpacity(0.1), // Light green start
            AppColors.primaryBlue.withOpacity(0.1),  // Light blue end
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Global Reach, Local Precision.',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.darkBlue,
              height: 1.1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          Text(
            'We provide an integrated suite of services—from regulatory clearance and specialty freight to on-site technical installation—ensuring seamless operational readiness for every client.',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.support_agent, color: Colors.white),
            label: const Text('Get a Service Quote', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 8,
            ),
          ),
        ],
      ),
    );
  }

  // --- SECTION 2: CORE SERVICES GRID ---
  Widget _buildCoreServicesGrid(BuildContext context, bool isDesktop) {
    final int crossAxisCount = isDesktop ? 4 : (MediaQuery.of(context).size.width > 600 ? 2 : 1);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80.0 : 20.0, vertical: 80.0),
      color: AppColors.lightBackground,
      child: Column(
        children: [
          Text(
            'Integrated Logistics Ecosystem',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _coreServices.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 30.0,
              mainAxisSpacing: 30.0,
              childAspectRatio: isDesktop ? 0.9 : 1.2, 
            ),
            itemBuilder: (context, index) {
              final service = _coreServices[index];
              return _ServiceCard(
                service: service,
              );
            },
          ),
        ],
      ),
    );
  }

  // --- SECTION 3: PROCESS FLOW/INFOGRAPHIC ---
  Widget _buildProcessFlow(BuildContext context, bool isDesktop) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80.0 : 20.0, vertical: 80.0),
      child: Column(
        children: [
          Text(
            'The Spectrum 5-Step Assurance Process',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkBlue,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            'Our modular approach guarantees accountability and quality control at every stage of the medical supply chain journey.',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          // Use a Row for desktop, or Wrap/Column for mobile
          isDesktop 
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _processSteps.map((step) => Expanded(child: _ProcessStep(step: step))).toList(),
              )
            : Wrap(
                spacing: 30.0,
                runSpacing: 30.0,
                alignment: WrapAlignment.center,
                children: _processSteps.map((step) => _ProcessStep(step: step)).toList(),
              ),
        ],
      ),
    );
  }

  // --- SECTION 4: SPECIALIZED SERVICE FOCUS ---
  Widget _buildSpecializedFocus(BuildContext context, bool isDesktop) {
    // This section highlights a high-value, complex service
    Widget content = isDesktop
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _buildFocusImage(context)),
              const SizedBox(width: 50),
              Expanded(child: _buildFocusText(context)),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFocusImage(context),
              const SizedBox(height: 40),
              _buildFocusText(context),
            ],
          );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80.0 : 20.0, vertical: 80.0),
      color: AppColors.darkBlue,
      child: content,
    );
  }

  Widget _buildFocusImage(BuildContext context) {
    // Placeholder for an image or animation relevant to specialized installation
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primaryGreen, width: 4),
      ),
      child: const Center(
        child: Icon(Icons.precision_manufacturing, size: 80, color: Colors.white),
      ),
    );
  }

  Widget _buildFocusText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Chip(
          label: const Text('VALUE-ADDED SERVICE', style: TextStyle(color: AppColors.darkBlue, fontWeight: FontWeight.bold, fontSize: 12)),
          backgroundColor: AppColors.primaryGreen,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        const SizedBox(height: 20),
        Text(
          'Integrated Engineering & Technical Maintenance',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textLight,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Beyond delivery, our specialized biomedical engineers provide full assembly, calibration, and routine preventive maintenance, reducing downtime and extending equipment lifespan.',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.textMuted),
        ),
        const SizedBox(height: 20),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.settings, color: AppColors.primaryGreen),
          label: const Text('Explore Maintenance Plans →', style: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)), 
        ),
      ],
    );
  }


  // --- SECTION 5: CTA BANNER ---
  Widget _buildCTABanner(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryBlue, AppColors.darkBlue],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 60.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              Text(
                'Ready for a Service Partnership?',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textLight,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                'Let\'s discuss how a dedicated service contract can secure your operations and provide peace of mind.',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.textMuted),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.phone, color: AppColors.darkBlue),
                label: const Text('Call Now to Start', style: TextStyle(color: AppColors.darkBlue, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
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

// --- WIDGETS USED IN SERVICES SCREEN ---

class _ServiceCard extends StatelessWidget {
  final ServiceCategory service;

  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: service.color.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: service.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(service.icon, size: 40, color: service.color),
          ),
          
          const SizedBox(height: 25),
          
          // Title
          Text(
            service.title, 
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: AppColors.darkBlue, 
              fontWeight: FontWeight.w700
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: 10),
          
          // Description
          Text(service.description, style: const TextStyle(color: AppColors.textMuted)),
          
          const Spacer(),

          // CTA Link
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.arrow_right_alt, size: 24, color: service.color),
            label: Text('View Details', style: TextStyle(color: service.color, fontWeight: FontWeight.bold)), 
          ),
        ],
      ),
    );
  }
}

class _ProcessStep extends StatelessWidget {
  final Map<String, dynamic> step;

  const _ProcessStep({required this.step});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 200),
      child: Column(
        children: [
          // Step Number Circle
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primaryBlue,
            child: Icon(step['icon'] as IconData, size: 30, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Text(
            step['title'],
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGreen,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            step['desc'],
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}