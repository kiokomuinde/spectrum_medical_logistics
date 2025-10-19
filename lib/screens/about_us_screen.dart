import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive_navbar.dart';
import '../widgets/app_footer.dart';

// --- 1. DUMMY DATA FOR ABOUT US SCREEN ---
class CoreValue {
  final String title;
  final String description;
  final IconData icon;

  CoreValue({required this.title, required this.description, required this.icon});
}

final List<CoreValue> _coreValues = [
  CoreValue(
    title: 'Patient-First Integrity',
    description: 'Our decisions prioritize patient safety and ethical handling above all logistics metrics.',
    icon: Icons.favorite_border,
  ),
  CoreValue(
    title: 'Logistics Excellence',
    description: 'We commit to the highest standards of operational quality, striving for zero-defect delivery.',
    icon: Icons.lightbulb_outline,
  ),
  CoreValue(
    title: 'Sustainable Growth',
    description: 'Balancing client success with responsible, environmentally conscious supply chain practices.',
    icon: Icons.eco_outlined,
  ),
  CoreValue(
    title: 'Collaborative Partnership',
    description: 'Fostering deep, transparent relationships with clients to co-engineer resilient supply chains.',
    icon: Icons.handshake_outlined,
  ),
];

final List<Map<String, dynamic>> _impactStats = [
  {'number': '15+', 'label': 'Years in Medical Logistics', 'color': AppColors.primaryBlue},
  {'number': '2M+', 'label': 'Critical Deliveries Managed Annually', 'color': AppColors.primaryGreen},
  {'number': '99.9%', 'label': 'On-Time, Temperature-Safe Rate', 'color': AppColors.darkBlue},
];

// --- LEADERSHIP TEAM UPDATED WITH NEW NAMES ---
final List<Map<String, String>> _leadershipTeam = [
  {'name': 'DR Samuel Papa', 'role': 'CEO & Founder', 'initials': 'SP'}, // Updated Name & Initials
  {'name': 'Kioko Muinde', 'role': 'Chief Operations Officer', 'initials': 'KM'}, // Updated Name & Initials
  {'name': 'Sarah Khan', 'role': 'Head of Global Compliance', 'initials': 'SK'},
];

// --- 2. MAIN SCREEN WIDGET ---
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 1000;
    
    return Scaffold(
      // 1. Navbar
      appBar: const ResponsiveNavBar(),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 2. Hero Section (History/Founding)
            _buildHeroHistory(context, isDesktop),

            // 3. Mission & Vision Statement
            _buildMissionVision(context),

            // 4. Core Values Pillars (Unique Component)
            _buildCoreValues(context, isDesktop),

            // 5. Impact Statistics
            _buildImpactStats(context, isDesktop),
            
            // 6. Leadership Section
            _buildLeadership(context, isDesktop),

            // 7. Final CTA
            _buildFinalCTA(context),

            // 8. Footer
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  // --- SECTION 1: HERO & HISTORY ---
  Widget _buildHeroHistory(BuildContext context, bool isDesktop) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80.0 : 20.0, 
        vertical: 100.0,
      ),
      color: AppColors.darkBlue, // Solid dark background for a serious tone
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: _buildHistoryText(context)),
                  const SizedBox(width: 60),
                  Expanded(flex: 2, child: _buildVisualTimeline()),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHistoryText(context),
                  const SizedBox(height: 50),
                  _buildVisualTimeline(),
                ],
              ),
        ),
      ),
    );
  }

  Widget _buildHistoryText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Founding Story',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryGreen,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          'Bridging the Gap Between Innovation and Care',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textLight,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 25),
        Text(
          'Founded in 2010 by a team of ex-biomedical engineers and supply chain experts, Spectrum was created to solve the unique compliance and handling challenges of the medical technology sector. We recognized that standard logistics couldn\'t safely transport life-critical, high-value assets.',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.textMuted),
        ),
        const SizedBox(height: 10),
        Text(
          'From a single validated cold-chain route, we have expanded into a global network that operates with the precision of a surgical team, ensuring that every shipment contributes directly to improving patient outcomes.',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.textMuted),
        ),
      ],
    );
  }

  Widget _buildVisualTimeline() {
    // Unique vertical element
    return Container(
      padding: const EdgeInsets.only(left: 20),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: AppColors.primaryBlue, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TimelineEvent(year: '2010', event: 'Company Founded; Focus on Cold Chain Logistics.'),
          _TimelineEvent(year: '2015', event: 'Attained ISO 13485 Certification, Expanding Global Footprint.'),
          _TimelineEvent(year: '2020', event: 'Launched Integrated Technical Installation Services (White Glove).'),
          _TimelineEvent(year: 'Today', event: 'Over 200 Certified Logisticians Operating in 40+ Countries.'),
        ],
      ),
    );
  }

  // --- SECTION 2: MISSION & VISION ---
  Widget _buildMissionVision(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryGreen.withOpacity(0.05),
            AppColors.primaryBlue.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Text(
                'Our Purpose Defines Our Path',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Floating Card with subtle shadow and border
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(40.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryGreen.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2), width: 1),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.star, size: 40, color: AppColors.primaryGreen),
                    const SizedBox(height: 20),
                    Text(
                      'Mission: To deliver life-enhancing medical innovations to any point on the globe with zero compromise on quality, speed, or compliance.',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontStyle: FontStyle.italic,
                        color: AppColors.darkBlue,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Divider(height: 50, color: AppColors.textMuted),
                    Text(
                      'Vision: To be the world\'s most trusted and technologically advanced logistics partner for the healthcare industry.',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.textMuted),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- SECTION 3: CORE VALUES PILLARS ---
  Widget _buildCoreValues(BuildContext context, bool isDesktop) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80.0 : 20.0, vertical: 80.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The Pillars of Our Operations',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGreen,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Our values drive our decision-making, from the warehouse floor to the boardroom.',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 60),
          // Using a custom horizontal list/wrap layout for a different look
          Wrap(
            spacing: 40.0,
            runSpacing: 40.0,
            alignment: WrapAlignment.center,
            children: _coreValues.map((value) => _ValuePillar(value: value, isDesktop: isDesktop)).toList(),
          ),
        ],
      ),
    );
  }

  // --- SECTION 4: IMPACT STATISTICS ---
  Widget _buildImpactStats(BuildContext context, bool isDesktop) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryBlue, AppColors.darkBlue],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: isDesktop
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _impactStats.map((stat) => _ImpactStat(stat: stat)).toList(),
              )
            : Column(
                children: _impactStats.map((stat) => Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: _ImpactStat(stat: stat),
                )).toList(),
              ),
        ),
      ),
    );
  }

  // --- SECTION 5: LEADERSHIP ---
  Widget _buildLeadership(BuildContext context, bool isDesktop) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80.0 : 20.0, vertical: 80.0),
      color: AppColors.lightBackground,
      child: Column(
        children: [
          Text(
            'Meet Our Leadership',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkBlue,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Driven by experience, powered by vision.',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 50.0,
            runSpacing: 50.0,
            alignment: WrapAlignment.center,
            children: _leadershipTeam.map((member) => _LeadershipCard(member: member)).toList(),
          ),
        ],
      ),
    );
  }

  // --- SECTION 6: FINAL CTA ---
  Widget _buildFinalCTA(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primaryGreen,
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 60.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Text(
                'Ready to Connect with Spectrum?',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBlue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                'We invite you to reach out directly to discuss how our mission aligns with your objectives.',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.darkBlue.withOpacity(0.8)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.group, color: Colors.white),
                label: const Text('Contact Our Team', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white, width: 2),
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

// --- WIDGETS USED IN ABOUT US SCREEN ---

class _TimelineEvent extends StatelessWidget {
  final String year;
  final String event;

  const _TimelineEvent({required this.year, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Year (Bolded text as the marker)
          SizedBox(
            width: 70,
            child: Text(
              year,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 20),
          // Event Description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ValuePillar extends StatelessWidget {
  final CoreValue value;
  final bool isDesktop;

  const _ValuePillar({required this.value, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: isDesktop ? 450 : double.infinity),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: AppColors.lightBackground, // Light gray/blue
          borderRadius: BorderRadius.circular(12),
          border: Border(left: BorderSide(color: AppColors.primaryBlue, width: 6)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(value.icon, size: 35, color: AppColors.primaryBlue),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value.title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBlue,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(value.description, style: const TextStyle(color: AppColors.textMuted)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImpactStat extends StatelessWidget {
  final Map<String, dynamic> stat;

  const _ImpactStat({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          stat['number'],
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontWeight: FontWeight.w900,
            color: AppColors.primaryGreen, // Green for impact numbers
            fontSize: 60,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          stat['label'],
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: stat['color'] as Color, // Use the associated color (Blue, Green, Dark Blue)
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _LeadershipCard extends StatelessWidget {
  final Map<String, String> member;

  const _LeadershipCard({required this.member});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          CircleAvatar(
            radius: 70,
            backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
            child: Text(
              member['initials']!,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: AppColors.darkBlue,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            member['name']!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkBlue,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            member['role']!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}