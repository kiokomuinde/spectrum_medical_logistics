import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive_navbar.dart';
import '../widgets/app_footer.dart'; // Import your custom Footer

class SolutionsScreen extends StatefulWidget {
  const SolutionsScreen({super.key});

  @override
  State<SolutionsScreen> createState() => _SolutionsScreenState();
}

class _SolutionsScreenState extends State<SolutionsScreen> {
  // Tracks the currently selected solution for the "Deep Dive" view
  int _selectedIndex = 0;

  final ScrollController _scrollController = ScrollController();

  // RICH DATA MODEL: Detailed info for each solution
  final List<Map<String, dynamic>> _solutions = [
    {
      "title": "Global Sourcing",
      "subtitle": "Authentic Medical Supplies",
      "desc": "We leverage a network of over 500+ global manufacturers to source FDA and CE-approved medical equipment directly.",
      "icon": Icons.public,
      "features": ["Direct Manufacturer Access", "Quality Assurance Checks", "Bulk Procurement Discounts"],
      "stat": "500+",
      "statLabel": "Global Partners"
    },
    {
      "title": "Cold Chain Logistics",
      "subtitle": "Temperature Controlled",
      "desc": "End-to-end cold chain integrity for vaccines, insulin, and biologics using IoT-enabled real-time monitoring.",
      "icon": Icons.ac_unit,
      "features": ["Real-time Temp Monitoring", "Refrigerated Fleet", "Backup Power Systems"],
      "stat": "0°C",
      "statLabel": "Temp Deviation"
    },
    {
      "title": "Inventory Management",
      "subtitle": "AI-Driven Stock Control",
      "desc": "Smart warehousing solutions that predict consumption patterns to prevent stockouts and reduce wastage.",
      "icon": Icons.inventory_2_outlined,
      "features": ["Predictive Analytics", "Automated Reordering", "Expiry Date Tracking"],
      "stat": "30%",
      "statLabel": "Cost Reduction"
    },
    {
      "title": "Biomedical Engineering",
      "subtitle": "Maintenance & Repair",
      "desc": "Certified engineers ready to install, calibrate, and repair complex imaging and diagnostic machinery.",
      "icon": Icons.medical_services_outlined,
      "features": ["24/7 On-Call Support", "Preventive Maintenance", "Calibration Certificates"],
      "stat": "4hr",
      "statLabel": "Response Time"
    },
    {
      "title": "Last-Mile Delivery",
      "subtitle": "Rapid Response Network",
      "desc": "Motorbike and drone-assisted delivery systems to reach the most remote clinics in the region on time.",
      "icon": Icons.local_shipping_outlined,
      "features": ["GPS Tracking", "Emergency Dispatch", "Remote Area Access"],
      "stat": "99%",
      "statLabel": "On-Time Delivery"
    },
    {
      "title": "Turnkey Projects",
      "subtitle": "Concept to Launch",
      "desc": "Full-service project management for setting up new ICUs, operating theatres, and dialysis centers.",
      "icon": Icons.construction_outlined,
      "features": ["Layout Design", "Equipment Installation", "Staff Training"],
      "stat": "5+",
      "statLabel": "Completed Projects"
    },
  ];

  void _onSolutionSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: const ResponsiveNavBar(),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const _SolutionsHero(),
            
            // Interactive Grid Menu
            _SolutionsSelectionGrid(
              solutions: _solutions,
              selectedIndex: _selectedIndex,
              onSelected: _onSolutionSelected,
            ),
            
            // Dynamic Details Section
            _SolutionDetailView(
              data: _solutions[_selectedIndex],
            ),

            const _ProcessWorkflow(),
            const _FAQSection(),
            const _CTASection(),
            
            // FOOTER: Updated to use your custom AppFooter
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}

// --- 1. HERO SECTION (Fixed with ConstrainedBox) ---
class _SolutionsHero extends StatelessWidget {
  const _SolutionsHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 140, bottom: 100, left: 24, right: 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.darkBlue, AppColors.primaryBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        image: const DecorationImage(
          image: NetworkImage("https://www.transparenttextures.com/patterns/cubes.png"),
          opacity: 0.1,
          repeat: ImageRepeat.repeat,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: const Text(
              "END-TO-END HEALTHCARE LOGISTICS",
              style: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold, letterSpacing: 1.2, fontSize: 12),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Innovative Solutions for\nModern Healthcare",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                  fontSize: 42,
                ),
          ),
          const SizedBox(height: 24),
          // FIXED: Using ConstrainedBox instead of SizedBox with named param maxWidth
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: const Text(
              "Select a service below to explore how Spectrum Medical Logistics can streamline your procurement and delivery operations.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 18, height: 1.6),
            ),
          ),
        ],
      ),
    );
  }
}

// --- 2. SELECTION GRID ---
class _SolutionsSelectionGrid extends StatelessWidget {
  final List<Map<String, dynamic>> solutions;
  final int selectedIndex;
  final Function(int) onSelected;

  const _SolutionsSelectionGrid({
    required this.solutions,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0, -60, 0), // Pull up to overlap hero
      padding: const EdgeInsets.symmetric(horizontal: 24),
      constraints: const BoxConstraints(maxWidth: 1200),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 1;
          if (constraints.maxWidth > 900) crossAxisCount = 3;
          else if (constraints.maxWidth > 600) crossAxisCount = 2;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.1, 
            ),
            itemCount: solutions.length,
            itemBuilder: (context, index) {
              final isSelected = index == selectedIndex;
              return _SelectableCard(
                title: solutions[index]['title'],
                icon: solutions[index]['icon'],
                isSelected: isSelected,
                onTap: () => onSelected(index),
              );
            },
          );
        },
      ),
    );
  }
}

class _SelectableCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectableCard({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isSelected ? AppColors.primaryBlue.withOpacity(0.4) : Colors.black.withOpacity(0.05),
              blurRadius: isSelected ? 20 : 10,
              offset: const Offset(0, 5),
            )
          ],
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : Colors.grey.shade200,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withOpacity(0.2) : AppColors.primaryBlue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: isSelected ? Colors.white : AppColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            if (isSelected)
              const Icon(Icons.keyboard_arrow_down, color: Colors.white70)
          ],
        ),
      ),
    );
  }
}

// --- 3. DETAILED VIEW (ANIMATED) ---
class _SolutionDetailView extends StatelessWidget {
  final Map<String, dynamic> data;

  const _SolutionDetailView({required this.data});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(animation),
          child: child,
        ));
      },
      child: Container(
        key: ValueKey<String>(data['title']),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        constraints: const BoxConstraints(maxWidth: 1000),
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade200, blurRadius: 20, offset: const Offset(0, 10))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['subtitle'].toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.primaryGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          letterSpacing: 1.1,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        data['title'],
                        style: const TextStyle(
                          color: AppColors.textDark,
                          fontWeight: FontWeight.w900,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        data['desc'],
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 18,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: (data['features'] as List).map<Widget>((feature) {
                          return Chip(
                            avatar: const Icon(Icons.check_circle, size: 18, color: AppColors.primaryBlue),
                            label: Text(feature),
                            backgroundColor: AppColors.primaryBlue.withOpacity(0.05),
                            side: BorderSide.none,
                            padding: const EdgeInsets.all(8),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.chat_bubble_outline, size: 18),
                        label: Text("Consult on ${data['title']}"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ],
                  ),
                ),
                if (MediaQuery.of(context).size.width > 800) ...[
                  const SizedBox(width: 60),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Icon(data['icon'], size: 60, color: AppColors.primaryGreen),
                          const SizedBox(height: 20),
                          Text(
                            data['stat'],
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryGreen,
                            ),
                          ),
                          Text(
                            data['statLabel'],
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.textDark,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Divider(),
                          const SizedBox(height: 10),
                          const Text(
                            "Trusted by leading hospitals across Kenya.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                          )
                        ],
                      ),
                    ),
                  )
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- 4. WORKFLOW SECTION ---
class _ProcessWorkflow extends StatelessWidget {
  const _ProcessWorkflow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: Colors.white,
      child: Column(
        children: [
          const Text("How It Works", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 40),
          LayoutBuilder(builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 700;
            return Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _StepItem(number: "01", title: "Consultation", desc: "We analyze your supply chain needs.", isMobile: isMobile),
                _ArrowDivider(isMobile: isMobile),
                _StepItem(number: "02", title: "Strategy", desc: "We design a custom logistics plan.", isMobile: isMobile),
                _ArrowDivider(isMobile: isMobile),
                _StepItem(number: "03", title: "Execution", desc: "Seamless implementation & delivery.", isMobile: isMobile),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final String number;
  final String title;
  final String desc;
  final bool isMobile;

  const _StepItem({required this.number, required this.title, required this.desc, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMobile ? double.infinity : 200,
      padding: const EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: isMobile ? 10 : 0),
      child: Column(
        children: [
          Text(number, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppColors.primaryGreen)),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(desc, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
        ],
      ),
    );
  }
}

class _ArrowDivider extends StatelessWidget {
  final bool isMobile;
  const _ArrowDivider({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Icon(
      isMobile ? Icons.keyboard_arrow_down : Icons.arrow_forward,
      color: Colors.grey, 
      size: 30
    );
  }
}

// --- 5. FAQ SECTION ---
class _FAQSection extends StatelessWidget {
  const _FAQSection();

  static const List<Map<String, String>> faqs = [
    {
      "q": "Do you handle customs clearance for global imports?",
      "a": "Yes, our Global Sourcing service includes full customs clearing and forwarding support at the Port of Mombasa and JKIA."
    },
    {
      "q": "What temperature range can you maintain for cold chain?",
      "a": "We maintain ranges from -20°C to +8°C, covering standard vaccines, insulin, and specialized reagents."
    },
    {
      "q": "How quickly can you deliver emergency supplies?",
      "a": "For Nairobi and Environs, our 'Last-Mile' service guarantees delivery within 4 hours for emergency orders."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      constraints: const BoxConstraints(maxWidth: 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Frequently Asked Questions", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          ...faqs.map((faq) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ExpansionTile(
              title: Text(faq['q']!, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(faq['a']!, style: const TextStyle(color: AppColors.textMuted)),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}

// --- 6. CTA SECTION ---
class _CTASection extends StatelessWidget {
  const _CTASection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: Colors.white,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          padding: const EdgeInsets.all(50),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [AppColors.primaryGreen, AppColors.primaryBlue]),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(color: AppColors.primaryBlue.withOpacity(0.3), blurRadius: 30, offset: const Offset(0, 15))
            ],
          ),
          child: Column(
            children: [
              const Text(
                "Ready to Optimize Your Medical Supply Chain?",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 16),
              const Text(
                "Contact our team today for a free consultation on how we can improve your logistics efficiency.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  context.go('/contact');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primaryBlue,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text("Get in Touch", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}