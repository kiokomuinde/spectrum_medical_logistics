import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive_navbar.dart';
import '../widgets/app_footer.dart';

// --- 1. DUMMY DATA FOR QUALITY & COMPLIANCE ---
class ComplianceStandard {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  ComplianceStandard({required this.title, required this.description, required this.icon, required this.color});
}

final List<ComplianceStandard> _certifications = [
  ComplianceStandard(
    title: 'ISO 13485:2016',
    description: 'Quality Management Systems for medical devices. The gold standard for device logistics and handling.',
    icon: Icons.iso,
    color: AppColors.primaryBlue,
  ),
  ComplianceStandard(
    title: 'Good Distribution Practice (GDP)',
    description: 'Ensuring the quality and integrity of medicines throughout the supply chain from manufacturer to patient.',
    icon: Icons.local_shipping,
    color: AppColors.primaryGreen,
  ),
  ComplianceStandard(
    title: 'FDA 21 CFR Part 11',
    description: 'Compliance with electronic records and electronic signatures, guaranteeing data integrity and security.',
    icon: Icons.security,
    color: AppColors.darkBlue,
  ),
  ComplianceStandard(
    title: 'Validated GxP Cold Chain',
    description: 'Qualification and validation of temperature-controlled storage and transport for pharmaceuticals and biologics.',
    icon: Icons.thermostat_auto,
    color: AppColors.primaryGreen.withOpacity(0.8),
  ),
];

// --- 2. MAIN SCREEN WIDGET ---
class QualityComplianceScreen extends StatelessWidget {
  const QualityComplianceScreen({super.key});

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

            // 3. Certifications Grid
            _buildCertificationsGrid(context, isDesktop),

            // 4. Quality Management System (QMS) Overview
            _buildQMSOverview(context, isDesktop),

            // 5. Audit Readiness CTA
            _buildAuditCTA(context),

            // 6. Footer
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  // --- SECTION 1: HERO (Trust-Focused) ---
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
            AppColors.primaryBlue.withOpacity(0.1), 
            AppColors.primaryGreen.withOpacity(0.1),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              const Icon(Icons.verified_user, size: 60, color: AppColors.primaryBlue),
              const SizedBox(height: 20),
              Text(
                'Unwavering Commitment to Quality & Compliance',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.darkBlue,
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              Text(
                'Our logistics operations are built on a foundation of rigorous standards, ensuring total patient safety and regulatory integrity across every market we serve.',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download, color: AppColors.darkBlue),
                label: const Text('Download Compliance Overview', style: TextStyle(color: AppColors.darkBlue, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.darkBlue, width: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- SECTION 2: CERTIFICATIONS GRID ---
  Widget _buildCertificationsGrid(BuildContext context, bool isDesktop) {
    final int crossAxisCount = isDesktop ? 4 : (MediaQuery.of(context).size.width > 600 ? 2 : 1);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80.0 : 20.0, vertical: 80.0),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Our Key Certifications & Standards',
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
            itemCount: _certifications.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 30.0,
              mainAxisSpacing: 30.0,
              childAspectRatio: isDesktop ? 0.8 : 1.0, 
            ),
            itemBuilder: (context, index) {
              final cert = _certifications[index];
              return _CertificationCard(cert: cert);
            },
          ),
        ],
      ),
    );
  }

  // --- SECTION 3: QUALITY MANAGEMENT SYSTEM (QMS) OVERVIEW ---
  Widget _buildQMSOverview(BuildContext context, bool isDesktop) {
    // This section explains the "how" behind the compliance
    Widget content = isDesktop
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildQMSImagePlaceholder(context)),
              const SizedBox(width: 50),
              Expanded(child: _buildQMSText(context)),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildQMSImagePlaceholder(context),
              const SizedBox(height: 40),
              _buildQMSText(context),
            ],
          );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80.0 : 20.0, vertical: 80.0),
      color: AppColors.lightBackground, // Light gray/blue for contrast
      child: content,
    );
  }

  Widget _buildQMSImagePlaceholder(BuildContext context) {
    // Placeholder for a diagram/image of a continuous quality loop
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.primaryGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primaryGreen, width: 3),
      ),
      child: const Center(
        child: Icon(Icons.loop, size: 80, color: AppColors.primaryGreen),
      ),
    );
  }

  Widget _buildQMSText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Chip(
          label: const Text('SYSTEM IN PLACE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
          backgroundColor: AppColors.darkBlue,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        const SizedBox(height: 20),
        Text(
          'Our Integrated Quality Management System (QMS)',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkBlue,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 20),
        _QMSFeature(
          icon: Icons.check_circle_outline,
          title: 'Document Control',
          subtitle: 'Centralized management of all SOPs, training records, and validation protocols.',
          color: AppColors.primaryBlue,
        ),
        _QMSFeature(
          icon: Icons.monitor_heart,
          title: 'Risk-Based Audits',
          subtitle: 'Proactive internal and external audits focused on high-risk areas like cold chain integrity.',
          color: AppColors.primaryGreen,
        ),
        _QMSFeature(
          icon: Icons.call_split,
          title: 'CAPA Management',
          subtitle: 'Robust system for Corrective and Preventive Actions, driving continuous process improvement.',
          color: AppColors.darkBlue,
        ),
      ],
    );
  }

  // --- SECTION 4: AUDIT READINESS CTA ---
  Widget _buildAuditCTA(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primaryBlue,
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Text(
                'Ready for Your Next Audit? So are we.',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textLight,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                'We welcome third-party inspections and client audits. Partner with Spectrum and gain total visibility into a fully compliant supply chain.',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.textMuted),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.business_center, color: AppColors.darkBlue),
                label: const Text('Schedule a Verification Tour', style: TextStyle(color: AppColors.darkBlue, fontWeight: FontWeight.bold)),
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

// --- WIDGETS USED IN QUALITY & COMPLIANCE SCREEN ---

class _CertificationCard extends StatelessWidget {
  final ComplianceStandard cert;

  const _CertificationCard({required this.cert});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: cert.color.withOpacity(0.5), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Icon(cert.icon, size: 50, color: cert.color),
            
            const SizedBox(height: 25),
            
            // Title
            Text(
              cert.title, 
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.darkBlue, 
                fontWeight: FontWeight.w800
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 10),
            
            // Description
            Text(cert.description, style: const TextStyle(color: AppColors.textMuted)),
            
            const Spacer(),

            // Status Link
            Row(
              children: [
                Icon(Icons.check_circle, size: 20, color: cert.color),
                const SizedBox(width: 8),
                Text('Active & Verified', style: TextStyle(color: cert.color, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QMSFeature extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _QMSFeature({required this.icon, required this.title, required this.subtitle, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 28, color: color),
          ),
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