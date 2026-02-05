// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'dart:async'; 
import '../theme/app_theme.dart';
import '../constants/app_constants.dart';

// --- REQUIRED EXTERNAL WIDGET IMPORTS ---
import '../widgets/responsive_navbar.dart'; 
import '../widgets/app_footer.dart';        
// ---------------------------------------------

// --- HELPER FUNCTION FOR RESPONSIVE PADDING ---
double _getHorizontalPadding(BuildContext context) {
  return MediaQuery.of(context).size.width > 800 ? 40.0 : 10.0;
}
// ----------------------------------------------

// --- KEY METRICS DATA ---
final List<Map<String, dynamic>> _keyMetrics = const [
  {'value': '99.9%', 'label': 'On-Time Delivery', 'icon': Icons.rocket_launch},
  {'value': 'ISO', 'label': '13485 Certified', 'icon': Icons.verified_user},
  {'value': '150+', 'label': 'Hospitals Served', 'icon': Icons.apartment},
  {'value': '24/7', 'label': 'Expert Support', 'icon': Icons.support_agent},
];
// ---------------------------------------------------------

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ResponsiveNavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _HeroSection(),
            _KeyMetricBar(),
            _ServicesSection(),
            _QualityComplianceSection(),
            _TechnologySection(),
            _LogisticsSection(),
            _CareerSection(),
            _AboutUsSection(),
            _TestimonialsSection(),
            _BlogsSection(),
            AppFooter(),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// HELPER WIDGETS (Section Container)
// -----------------------------------------------------------------------------

class _SectionContainer extends StatelessWidget {
  final Widget child;
  final String title;
  final Color? backgroundColor;

  const _SectionContainer({
    required this.child,
    required this.title,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    final double horizontalPadding = _getHorizontalPadding(context);
    
    return Container(
      color: backgroundColor ?? AppColors.lightBackground,
      padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: horizontalPadding), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: isDesktop ? 38 : 28,
              color: AppColors.darkBlue, 
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 3,
            width: isDesktop ? 150 : 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: const LinearGradient(
                colors: [AppColors.primaryGreen, AppColors.primaryBlue],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          const SizedBox(height: 50),
          child, 
        ],
      ),
    );
  }
}

// --- UPDATED: Hero Section with Scrim Overlay ---
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    double horizontalPadding = _getHorizontalPadding(context);
    
    return SizedBox(
      height: isDesktop ? 600 : 450,
      width: double.infinity,
      child: Stack(
        children: [
          // 1. The Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/hero_background.webp',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.darkBlue,
                child: const Center(child: Text("HERO IMAGE", style: TextStyle(color: AppColors.textLight))),
              ),
            ),
          ),
          // 2. The Scrim (Gradient Overlay)
          // This ensures the white text pops against any background
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                // REPLACED: AppColors.sereneGradient (too light)
                // WITH: AppColors.heroScrimGradient (darker, better contrast)
                gradient: AppColors.heroScrimGradient,
              ),
            ),
          ),
          // 3. The Text Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "CRITICAL CARE.\nRELIABLE DELIVERY.",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w900,
                    fontSize: isDesktop ? 60 : 36,
                    // Added a subtle shadow to text for extra legibility
                    shadows: [
                      Shadow(
                        offset: const Offset(0, 2),
                        blurRadius: 4.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: isDesktop ? 700 : double.infinity, // Limit width on desktop for readability
                  child: Text(
                    "Empowering healthcare providers with premium medical\nequipment and specialized consumables across the globe.",
                    style: TextStyle(
                      color: AppColors.textLight.withOpacity(0.95), // Increased opacity slightly
                      fontSize: isDesktop ? 22 : 16,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Optional: Add a call to action button here in the future
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- Key Metrics Bar ---
class _KeyMetricBar extends StatelessWidget {
  const _KeyMetricBar();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    
    return Container(
      color: AppColors.primaryBlue, 
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: _getHorizontalPadding(context)),
      child: isDesktop
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _keyMetrics.map((m) => Expanded(child: _MetricStat(metric: m))).toList(),
            )
          : Column(
              children: _keyMetrics.map((m) => Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: _MetricStat(metric: m),
              )).toList(),
            ),
    );
  }
}

class _MetricStat extends StatelessWidget {
  final Map<String, dynamic> metric;
  const _MetricStat({required this.metric});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Icon(metric['icon'] as IconData, color: AppColors.accentGreen, size: 40),
          const SizedBox(height: 5),
          Text(
            metric['value'] as String,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: AppColors.textLight, 
              fontWeight: FontWeight.w900,
              fontSize: 28,
            ),
          ),
          Text(
            metric['label'] as String,
            style: const TextStyle(color: AppColors.textLight, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// --- Our Expert Services ---
class _ServicesSection extends StatelessWidget {
  const _ServicesSection();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    
    final List<Map<String, dynamic>> _dummyServices = [
      {
        'title': 'Biomedical Engineering',
        'description': 'Expert maintenance, calibration, and repair services for critical hospital machinery.',
        'icon': Icons.settings_suggest,
        'color': AppColors.primaryBlue,
      },
      {
        'title': 'Supply Chain Logistics',
        'description': 'JIT (Just-In-Time) delivery and cold chain management for sensitive consumables.',
        'icon': Icons.local_shipping,
        'color': AppColors.primaryGreen,
      },
      {
        'title': 'Equipment Leasing & Finance',
        'description': 'Flexible finance options and operational leasing to minimize capital expenditure.',
        'icon': Icons.monetization_on,
        'color': Colors.orange,
      },
      {
        'title': 'Compliance & Auditing',
        'description': 'Ensuring all equipment and consumables meet ISO and local regulatory standards.',
        'icon': Icons.gavel,
        'color': Colors.redAccent,
      },
    ];

    return _SectionContainer(
      title: 'OUR EXPERT SERVICES',
      backgroundColor: AppColors.lightBackground,
      child: isDesktop ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _dummyServices.map((service) => Expanded(
          child: _ServiceCard(service: service),
        )).toList(),
      ) : Column(
        children: _dummyServices.map((service) => Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: _ServiceCard(service: service),
        )).toList(),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final Map<String, dynamic> service;
  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.textLight,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: AppColors.darkBlue.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Icon(service['icon'] as IconData, color: service['color'] as Color, size: 50),
          const SizedBox(height: 20),
          Text(
            service['title'] as String,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.darkBlue),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Text(
            service['description'] as String,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// --- Quality & Compliance ---
class _QualityComplianceSection extends StatelessWidget {
  const _QualityComplianceSection();

  @override
  Widget build(BuildContext context) {
    return const _SectionContainer(
      title: 'QUALITY & COMPLIANCE',
      backgroundColor: Colors.white,
      child: Column(
        children: [
          _ComplianceText(),
          SizedBox(height: 40),
          _ComplianceCertificates(),
        ],
      ),
    );
  }
}

class _ComplianceText extends StatelessWidget {
  const _ComplianceText();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Unwavering Commitment to Medical Standards',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: AppColors.primaryGreen,
            fontWeight: FontWeight.w900,
            fontSize: 28,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'We understand that in the medical field, there is zero room for error. Our entire operational model, from sourcing and procurement to logistics and final delivery, is built around strict international and local regulatory compliance.',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.textDark, fontSize: 18, height: 1.5),
        ),
        const SizedBox(height: 20),
        const _CompliancePoint(text: 'ISO 13485:2016 Certified for Medical Device Quality Management Systems.'),
        const _CompliancePoint(text: 'FDA and CE Mark registration verification for all imported equipment.'),
        const _CompliancePoint(text: 'Strict cold-chain monitoring for all sensitive diagnostic reagents.'),
      ],
    );
  }
}

class _CompliancePoint extends StatelessWidget {
  final String text;
  const _CompliancePoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: AppColors.primaryGreen, size: 20),
          const SizedBox(width: 15),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16, color: AppColors.textDark))),
        ],
      ),
    );
  }
}

class _ComplianceCertificates extends StatelessWidget {
  const _ComplianceCertificates();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 30,
      runSpacing: 20,
      children: [
        _CertIcon(label: 'ISO 13485', icon: Icons.verified),
        _CertIcon(label: 'CE MARK', icon: Icons.health_and_safety),
        _CertIcon(label: 'FDA APPROVED', icon: Icons.security),
      ],
    );
  }
}

class _CertIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  const _CertIcon({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 60, color: AppColors.primaryBlue.withOpacity(0.2)),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textMuted)),
      ],
    );
  }
}

// --- Technology Showcase ---
class _TechnologySection extends StatelessWidget {
  const _TechnologySection();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    
    return _SectionContainer(
      title: 'INNOVATION SPOTLIGHT',
      backgroundColor: AppColors.cardBackground,
      child: isDesktop ? Row(
        children: const [
          Expanded(child: _TechnologyImage()),
          SizedBox(width: 50),
          Expanded(child: _TechnologyContent()),
        ],
      ) : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _TechnologyImage(),
          SizedBox(height: 40),
          _TechnologyContent(),
        ],
      ),
    );
  }
}

class _TechnologyContent extends StatelessWidget {
  const _TechnologyContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Introducing the Next-Gen Portable Patient Monitor: Clarity in Crisis',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: AppColors.darkBlue,
            fontWeight: FontWeight.w900,
            fontSize: 28,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'The flagship of our monitor line combines rugged portability with crystal-clear vital signs display, making it indispensable for EMS and critical care units. Its intuitive interface requires minimal training, ensuring immediate deployment.',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.textDark, fontSize: 18, height: 1.5),
        ),
      ],
    );
  }
}

class _TechnologyImage extends StatelessWidget {
  const _TechnologyImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)],
      ),
      child: const Center(child: Icon(Icons.monitor_heart, size: 150, color: AppColors.primaryBlue)),
    );
  }
}

// --- Logistics & Distribution ---
class _LogisticsSection extends StatelessWidget {
  const _LogisticsSection();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    return _SectionContainer(
      title: 'LOGISTICS & DISTRIBUTION',
      backgroundColor: AppColors.cardBackground,
      child: Column(
        children: [
          Text(
            'Global Reach, Local Expertise: Get Your Equipment Where It Needs to Be, On Time.',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: AppColors.darkBlue,
              fontWeight: FontWeight.w900,
              fontSize: isDesktop ? 32 : 24,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          isDesktop ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Expanded(child: _LogisticsStep(step: 1, title: 'Order Fulfillment', description: 'Real-time stock checks and 24-hour dispatch guarantee.')),
              Expanded(child: _LogisticsStep(step: 2, title: 'Specialized Transport', description: 'Temperature-controlled and shock-mitigating delivery systems.')),
              Expanded(child: _LogisticsStep(step: 3, title: 'Local Delivery', description: 'Last-mile logistics ensures delivery directly to the clinical site.')),
            ],
          ) : Column(
            children: const [
              _LogisticsStep(step: 1, title: 'Order Fulfillment', description: 'Real-time stock checks and 24-hour dispatch guarantee.'),
              SizedBox(height: 30),
              _LogisticsStep(step: 2, title: 'Specialized Transport', description: 'Temperature-controlled and shock-mitigating delivery systems.'),
              SizedBox(height: 30),
              _LogisticsStep(step: 3, title: 'Local Delivery', description: 'Last-mile logistics ensures delivery directly to the clinical site.'),
            ],
          ),
        ],
      ),
    );
  }
}

class _LogisticsStep extends StatelessWidget {
  final int step;
  final String title;
  final String description;
  const _LogisticsStep({required this.step, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(radius: 30, backgroundColor: AppColors.primaryGreen, child: Text('$step', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
        const SizedBox(height: 20),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.darkBlue)),
        const SizedBox(height: 10),
        Text(description, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textMuted)),
      ],
    );
  }
}

// --- Career Section ---
class _CareerSection extends StatelessWidget {
  const _CareerSection();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
      decoration: const BoxDecoration(
        color: AppColors.darkBlue,
        image: DecorationImage(image: AssetImage('assets/images/career_bg.webp'), fit: BoxFit.cover, opacity: 0.1),
      ),
      child: Column(
        children: [
          Text(
            'Join the Mission: Impact Global Healthcare',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: AppColors.textLight,
              fontWeight: FontWeight.w900,
              fontSize: isDesktop ? 40 : 30,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'We are always looking for passionate engineers, supply chain experts, and medical sales professionals to help us deliver critical equipment worldwide.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColors.textLight.withOpacity(0.9),
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.work, color: AppColors.darkBlue, size: 20),
            label: const Text('VIEW OPENINGS', style: TextStyle(color: AppColors.darkBlue, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentGreen,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
          ),
        ],
      ),
    );
  }
}

// --- About Us Section ---
class _AboutUsSection extends StatelessWidget {
  const _AboutUsSection();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    return _SectionContainer(
      title: 'ABOUT US',
      backgroundColor: Colors.white,
      child: isDesktop ? Row(
        children: const [
          Expanded(child: _AboutContent()),
          SizedBox(width: 80),
          Expanded(child: _AboutStats()),
        ],
      ) : Column(
        children: const [
          _AboutContent(),
          SizedBox(height: 50),
          _AboutStats(),
        ],
      ),
    );
  }
}

class _AboutContent extends StatelessWidget {
  const _AboutContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'A Legacy of Healthcare Excellence Since 2010',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.darkBlue, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 25),
        const Text(
          'Founded with a vision to bridge the gap between advanced medical technology and clinical accessibility, our company has grown into a leading distributor of diagnostic equipment and laboratory consumables. We don\'t just sell products; we provide end-to-end clinical solutions that save lives.',
          style: TextStyle(fontSize: 17, height: 1.6, color: AppColors.textDark),
        ),
      ],
    );
  }
}

class _AboutStats extends StatelessWidget {
  const _AboutStats();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _StatItem(value: '10k+', label: 'Products Delivered', icon: Icons.local_shipping, color: AppColors.primaryBlue),
        _StatItem(value: '50+', label: 'Global Partners', icon: Icons.medical_services, color: AppColors.primaryGreen),
        _StatItem(value: '100%', label: 'Compliance Rate', icon: Icons.check_circle, color: Colors.orange),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;
  const _StatItem({required this.value, required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppColors.darkBlue, fontWeight: FontWeight.bold)),
              Text(label, style: const TextStyle(color: AppColors.textMuted)),
            ],
          ),
        ],
      ),
    );
  }
}

// --- Testimonials Section ---
class _TestimonialsSection extends StatelessWidget {
  const _TestimonialsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionContainer(
      title: 'WHAT OUR CLIENTS SAY',
      backgroundColor: AppColors.lightBackground,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: const [
            _TestimonialCard(testimonial: {'name': 'Dr. Sarah Chen', 'role': 'Head of ICU, General Hospital', 'quote': 'The patient monitoring systems provided are second to none in terms of reliability.'}),
            _TestimonialCard(testimonial: {'name': 'Mark Thompson', 'role': 'Supply Chain Manager', 'quote': 'Their JIT delivery for reagents has transformed our lab efficiency.'}),
          ],
        ),
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final Map<String, dynamic> testimonial;
  const _TestimonialCard({required this.testimonial});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.format_quote, color: AppColors.primaryGreen, size: 40),
          const SizedBox(height: 10),
          Text('"${testimonial['quote']}"', style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16)),
          const SizedBox(height: 20),
          Text(testimonial['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(testimonial['role'] as String, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
        ],
      ),
    );
  }
}

// --- Blogs Section ---
class _BlogsSection extends StatelessWidget {
  const _BlogsSection();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _dummyBlogs = [
      {'title': 'Future of ICU Monitoring', 'tag': 'TECHNOLOGY', 'date': 'Oct 12, 2023'},
      {'title': 'Maintaining Sterile Environments', 'tag': 'BEST PRACTICES', 'date': 'Oct 05, 2023'},
    ];

    return _SectionContainer(
      title: 'LATEST INSIGHTS',
      backgroundColor: Colors.white,
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: _dummyBlogs.map((blog) => _BlogCard(blog: blog)).toList(),
      ),
    );
  }
}

class _BlogCard extends StatelessWidget {
  final Map<String, dynamic> blog;
  const _BlogCard({required this.blog});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 200, color: AppColors.cardBackground, child: const Center(child: Icon(Icons.article, size: 50))),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(blog['tag'] as String, style: const TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(blog['title'] as String, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Icon(Icons.calendar_month, size: 16, color: AppColors.textMuted),
                    const SizedBox(width: 5),
                    Text(blog['date'] as String, style: const TextStyle(color: AppColors.textMuted)),
                    const Spacer(),
                    const Text('Read More →', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}