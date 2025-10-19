// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'dart:async'; // Required for the countdown timer
import '../theme/app_theme.dart';
import '../constants/app_constants.dart';

// --- FIXED: REQUIRED EXTERNAL WIDGET IMPORTS ---
import '../widgets/responsive_navbar.dart'; 
import '../widgets/app_footer.dart';        
// ---------------------------------------------\r\n

// --- HELPER FUNCTION FOR RESPONSIVE PADDING (REDUCED FURTHER FOR TIGHTER CAROUSEL) ---
double _getHorizontalPadding(BuildContext context) {
  // Desktop padding REDUCED from 60.0 to 40.0
  // Mobile padding REDUCED from 15.0 to 10.0 for a very tight fit
  return MediaQuery.of(context).size.width > 800 ? 40.0 : 10.0;
}
// ----------------------------------------------

// --- NEW DUMMY PROMO DATA (FOR AUTO CAROUSEL) ---
// UPDATED: Content changed to be product-specific, and count increased to 6
final List<Map<String, dynamic>> _dummyPromos = [
  {
    // Fix: Changed single quotes to double quotes to allow literal $ sign
    "title": "FREE ACCESSORIES: X-Ray System!", 
    'subtitle': 'Secure the High-Resolution X-Ray System and get a \$5,000 accessory kit FREE. Limited to first 5 buyers.',
    'emoji': '🦴',
    'color1': AppColors.primaryGreen,
    'color2': AppColors.accentGreen.withOpacity(0.8),
  },
  {
    'title': 'Save 30% on Infusion Pumps!',
    'subtitle': 'Special bulk pricing on our smart Infusion Pump Systems. Minimum order quantity applies. Immediate dispatch.',
    'emoji': '💉',
    'color1': Colors.redAccent,
    'color2': Colors.deepOrange.withOpacity(0.8),
  },
  {
    'title': 'Launch Exclusive: Lab Analyzer!',
    'subtitle': 'Purchase the Automated Lab Analyzer and receive 1-year of premium reagent supply included.',
    'emoji': '🧪',
    'color1': AppColors.primaryBlue,
    'color2': AppColors.darkBlue.withOpacity(0.8),
  },
  {
    // FIX APPLIED HERE: title string changed to double quotes
    "title": "Essentials Bundle: \$500 Credit!",
    'subtitle': 'Spend \$5,000 on consumables (containers, syringes, etc.) and receive a \$500 account credit for future orders.',
    'emoji': '📦',
    'color1': Colors.purple,
    'color2': Colors.pink.withOpacity(0.8),
  },
  {
    'title': 'New Ventilator System: 3 Year Warranty!',
    'subtitle': 'The Advanced Ventilator Unit now comes with an extended 3-year full-service warranty at no extra cost.',
    'emoji': '💨',
    'color1': Colors.teal,
    'color2': Colors.cyan.withOpacity(0.8),
  },
  {
    'title': 'Final Call: Patient Monitor Sale!',
    'subtitle': 'Last chance to get the Portable Patient Monitor at 20% off list price. Stock clearing event. Order today!',
    'emoji': '🩺',
    'color1': Colors.orange,
    'color2': Colors.amber.withOpacity(0.8),
  },
];
// -----------------------------------------------

// --- DUMMY PRODUCT DATA (REPLACED WITH NEW CONSUMABLES LIST - KES TO USD CONVERSION RATE: 1 KES = 0.0077 USD) ---
final List<Map<String, dynamic>> _dummyProducts = [
  {
    'id': 1,
    'name': 'Urine Container (ACEE)',
    'description': 'Sterile, high-quality container for safe sample collection.',
    "price": "USD 8.49", // Converted from KES 1,100.00
    'image_path': 'assets/images/urine_container.webp', 
    'isNew': true, 
    'rating': 4.7, 
    'reviews': 240, 
  },
  {
    'id': 2,
    'name': 'Stool Container (ACEE)',
    'description': 'Sealed container with spatula for faecal sample transport.',
    "price": "USD 8.49", // Converted from KES 1,100.00
    'image_path': 'assets/images/stool_container.webp', 
    'isNew': true,
    'rating': 4.5, 
    'reviews': 190, 
  },
  {
    'id': 3,
    'name': 'Urine Reagent Strips (Urit)',
    'description': '100 count test strips for rapid urinalysis.',
    "price": "USD 7.72", // Converted from KES 1,000.00
    'image_path': 'assets/images/urine_strips.webp', 
    'isNew': false,
    'rating': 4.9, 
    'reviews': 312, 
  },
  {
    'id': 4,
    'name': 'Rota/Adeno Ag Cassette (Cellex)',
    'description': '25 tests for rapid gastroenteritis screening.',
    "price": "USD 27.02", // Converted from KES 3,500.00
    'image_path': 'assets/images/rota_adeno_ag.webp', 
    'isNew': true,
    'rating': 4.8, 
    'reviews': 55, 
  },
  {
    'id': 5,
    'name': 'HCG Pregnancy Strip (Cellex)',
    'description': '50 tests for reliable and quick pregnancy detection.',
    "price": "USD 3.47", // Converted from KES 450.00
    'image_path': 'assets/images/hcg_strip.webp', 
    'isNew': false,
    'rating': 4.6, 
    'reviews': 780, 
  },
  {
    'id': 6,
    'name': 'Typhoid Antigen Test (Cellex)',
    'description': '25 tests for quick detection of Typhoid fever antigen.',
    "price": "USD 22.39", // Converted from KES 2,900.00
    'image_path': 'assets/images/typhoid_ag.webp', 
    'isNew': false,
    'rating': 4.4, 
    'reviews': 95, 
  },
  {
    'id': 7,
    'name': 'SONY ULTRASOUND THERMAL ROLL (Original)',
    'description': 'High-grade thermal paper (UPP 110HG) for SONY ultrasound printers.',
    "price": "USD 18.53", // Converted from KES 2,400.00
    'image_path': 'assets/images/sony_ultrasound_thermal.webp', 
    'isNew': true,
    'rating': 4.9, 
    'reviews': 150, 
  },
  {
    'id': 8,
    'name': 'DURICO THERMAL PAPER (Original)',
    'description': 'Premium thermal recording paper for various medical devices.',
    "price": "USD 17.76", // Converted from KES 2,300.00
    'image_path': 'assets/images/durico_thermal_paper.webp', 
    'isNew': false,
    'rating': 4.7, 
    'reviews': 310, 
  },
  {
    'id': 9,
    'name': 'Endoscopy Sony Paper UCP-21L',
    'description': 'Specialized thermal paper for endoscopic printing units (Original).',
    "price": "USD 162.14", // Converted from KES 21,000.00
    'image_path': 'assets/images/endoscopy_sony_paper.webp', 
    'isNew': true,
    'rating': 4.8, 
    'reviews': 70, 
  },
  {
    'id': 10,
    'name': 'Endoscopy Stent System Introducer 10"60',
    'description': 'Single-use introducer for complex endoscopic stent placement (Original).',
    "price": "USD 463.25", // Converted from KES 60,000.00
    'image_path': 'assets/images/endoscopy_stent_system.webp', 
    'isNew': false,
    'rating': 4.3, 
    'reviews': 25, 
  },
];
// -----------------------------------------------------------------

// --- NEW DUMMY BUNDLE DATA (MODIFIED FOR CONSUMABLES) ---
final List<Map<String, dynamic>> _dummyBundles = [
  {
    'name': 'Lab Testing Essentials Package',
    'product_id': 4, // Rota/Adeno Ag Cassette
    'accessories': ['2x Extra Reagent Kits', 'Free Next-Day Shipping'],
    'base_price': 300.00,
    'bundle_price': 275.00,
    'icon': Icons.local_hospital,
  },
  {
    'name': 'Bulk Specimen Collection Kit',
    'product_id': 1, // Urine Container
    'accessories': ['500 Extra Containers', 'Discounted Hazardous Waste Disposal'],
    'base_price': 100.00,
    'bundle_price': 90.00,
    'icon': Icons.install_desktop,
  },
];
// -----------------------------

// --- NEW KEY METRICS DATA (Professional Trust Building) ---
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
            _ProductSalesSection(), 
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
              gradient: LinearGradient(
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
// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------
// NEW AUTO-CAROUSEL AND TIMER WIDGETS
// -----------------------------------------------------------------------------

// Widget 1: Flash Sale Countdown Timer (Urgency) - Moved and reused
class _SaleTimer extends StatefulWidget {
  const _SaleTimer();

  @override
  State<_SaleTimer> createState() => _SaleTimerState();
}

class _SaleTimerState extends State<_SaleTimer> {
  late Timer _timer;
  Duration _timeRemaining = const Duration(hours: 48, minutes: 30, seconds: 0);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining.inSeconds == 0) {
        timer.cancel();
      } else {
        if(mounted) {
          setState(() {
            _timeRemaining = _timeRemaining - const Duration(seconds: 1);
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      decoration: BoxDecoration(
        color: AppColors.accentGreen,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: AppColors.accentGreen.withOpacity(0.5), blurRadius: 10)],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.flash_on, color: AppColors.darkBlue, size: 24),
          const SizedBox(width: 10),
          Text(
            'LIMITED TIME CELEBRATION! Ends in:',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColors.darkBlue,
              fontWeight: FontWeight.w900,
              fontSize: isDesktop ? 18 : 14,
            ),
          ),
          const SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.darkBlue,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              _formatTime(_timeRemaining),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.textLight,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                fontSize: isDesktop ? 20 : 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget 2: Promo Card (Stylized, Celebratory)
class _PromoCard extends StatelessWidget {
  final Map<String, dynamic> promo;

  const _PromoCard({required this.promo});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: isDesktop ? 20 : 10), // Original
      margin: const EdgeInsets.symmetric(horizontal: 0), // MODIFIED: Removed margin to increase card width
      decoration: BoxDecoration(
        // Vibrant Gradient
        gradient: LinearGradient(
          colors: [
            promo['color1'] as Color,
            promo['color2'] as Color,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: (promo['color1'] as Color).withOpacity(0.5), blurRadius: 20)],
      ),
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  promo['title'] as String,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: AppColors.textLight,
                    fontSize: isDesktop ? 48 : 30,
                    fontWeight: FontWeight.w900,
                    shadows: [const Shadow(color: Colors.black38, blurRadius: 5)],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  promo['subtitle'] as String,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColors.textLight.withOpacity(0.9),
                    fontSize: isDesktop ? 22 : 16,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.flash_on, color: AppColors.darkBlue, size: 24),
                  label: const Text('UNLOCK SAVINGS', style: TextStyle(color: AppColors.darkBlue, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentGreen,
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
          // Emoji/Icon Art
          if (isDesktop)
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                promo['emoji'] as String,
                style: const TextStyle(fontSize: 120),
              ),
            ),
        ],
      ),
    );
  }
}

// Widget 3: Auto-Playing Promo Carousel
class _PromoSalesHeader extends StatefulWidget {
  const _PromoSalesHeader();

  @override
  State<_PromoSalesHeader> createState() => _PromoSalesHeaderState();
}

class _PromoSalesHeaderState extends State<_PromoSalesHeader> {
  late PageController _pageController;
  late Timer _autoplayTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0);

    // Start Autoplay (New requirement)
    _autoplayTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentPage + 1) % _dummyPromos.length;
        _pageController.animateToPage(
          nextPage, 
          duration: const Duration(milliseconds: 800), 
          curve: Curves.easeInOut
        );
      }
    });

    _pageController.addListener(_pageListener);
  }

  void _pageListener() {
    if (_pageController.hasClients && _pageController.page != null) {
      int next = _pageController.page!.round();
      if (next != _currentPage) {
        setState(() {
          _currentPage = next;
        });
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoplayTimer.cancel(); // Cancel timer on dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double carouselHeight = MediaQuery.of(context).size.width > 800 ? 300 : 250;
    
    return Column(
      children: [
        // 1. Sale Timer
        const _SaleTimer(),
        const SizedBox(height: 30),

        // 2. Auto-Playing Carousel
        SizedBox(
          height: carouselHeight,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _dummyPromos.length,
            itemBuilder: (context, index) {
              return _PromoCard(promo: _dummyPromos[index]);
            },
          ),
        ),

        const SizedBox(height: 10),

        // 3. Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_dummyPromos.length, (index) {
            return Container(
              width: _currentPage == index ? 16.0 : 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: _currentPage == index ? AppColors.primaryBlue : AppColors.textMuted.withOpacity(0.4),
              ),
            );
          }),
        ),
      ],
    );
  }
}
// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------
// E-COMMERCE ENHANCEMENTS (Updated for Non-Auto-Sliding)
// -----------------------------------------------------------------------------

// Widget: Product Card (Modified for New Data)
class _ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onQuickView;

  const _ProductCard({required this.product, required this.onQuickView});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.textLight,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkBlue.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and Quick View Button
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Image.asset(
                        product['image_path'] as String,
                        height: 150,
                        fit: BoxFit.contain,
                        // Fallback for missing image asset
                        errorBuilder: (context, error, stackTrace) => 
                            Icon(Icons.medication_liquid, size: 80, color: AppColors.darkBlue.withOpacity(0.8))
                      ),
                    ),
                  ),
                ),
                if (product['isNew'] == true)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('NEW', style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColors.textLight, fontWeight: FontWeight.bold)),
                    ),
                  ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.zoom_in, color: AppColors.darkBlue),
                    onPressed: onQuickView,
                    tooltip: 'Quick View',
                    style: IconButton.styleFrom(backgroundColor: AppColors.textLight.withOpacity(0.8)),
                  ),
                ),
              ],
            ),
          ),
          // Product Details
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'] as String,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColors.darkBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  product['description'] as String,
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                // Price and Rating Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product['price'] as String,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${product['rating']} (${product['reviews']})',
                          style: const TextStyle(color: AppColors.textMuted, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // CTA Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Add to Inquiry', style: TextStyle(color: AppColors.textLight, fontWeight: FontWeight.bold)),
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

// Widget: Quick View Modal
class _ProductQuickViewModal extends StatelessWidget {
  final Map<String, dynamic> product;

  const _ProductQuickViewModal({required this.product});

  final List<String> valueProps = const [
    '20% Flash Discount (Save Thousands!)',
    'Zero-Downtime Guarantee & 3-Year Warranty',
    'Free On-Site Installation & Training',
    'Immediate Stock & Global Express Shipping',
  ];

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    
    return AlertDialog(
      backgroundColor: AppColors.lightBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.fromLTRB(25, 20, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                product['name'] as String,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.darkBlue, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.textMuted),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      content: SingleChildScrollView(
        child: Container(
          width: isDesktop ? 700 : double.maxFinite,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: AppColors.gentleHighlightGradient,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // --- FIXED: Replaced Icon with Image.asset for Quick View ---
                    child: Center(
                      child: Image.asset(
                        product['image_path'] as String,
                        height: 150, 
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => 
                            Icon(Icons.image_not_supported, size: 100, color: AppColors.darkBlue.withOpacity(0.8)) // Fallback
                      ),
                    ),
                    // ----------------------------------------------------------
                  ),
                  Positioned(
                    top: 15,
                    left: 15,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'FLASH 20% OFF!',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColors.textLight,
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              Text(
                product['description'] as String,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.textDark, fontSize: 18),
              ),
              const SizedBox(height: 25),
              
              // Value Proposition Bullets
              ...valueProps.map((prop) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_outline, color: AppColors.primaryGreen, size: 24),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        prop,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.darkBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              )).toList(),

              const Divider(height: 30),
              
              // Final CTA Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SALE PRICE: ${product['price']}',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColors.primaryGreen,
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Logic for immediate contact
                    },
                    icon: const Icon(Icons.local_hospital, color: AppColors.textLight, size: 24),
                    label: const Text('INQUIRE NOW', style: TextStyle(color: AppColors.textLight, fontWeight: FontWeight.bold, fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Product Bundles Section ---
class _ProductBundlesSection extends StatelessWidget {
  const _ProductBundlesSection();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '🔥 Don\'t Leave Value on the Table: Complete Your Setup & Save',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: AppColors.darkBlue,
            fontWeight: FontWeight.w900,
            fontSize: isDesktop ? 28 : 22,
          ),
        ),
        const SizedBox(height: 20),
        
        isDesktop
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _dummyBundles.map((bundle) => Expanded(
                  child: _BundleCard(bundle: bundle),
                )).toList(),
              )
            : Column(
                children: _dummyBundles.map((bundle) => Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: _BundleCard(bundle: bundle),
                )).toList(),
              ),
      ],
    );
  }
}

// --- Individual Bundle Card ---
class _BundleCard extends StatelessWidget {
  final Map<String, dynamic> bundle;
  const _BundleCard({required this.bundle});

  @override
  Widget build(BuildContext context) {
    // Calculate the saving amount
    double savingAmount = (bundle['base_price'] as double) - (bundle['bundle_price'] as double);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withOpacity(0.1),
        border: Border.all(color: AppColors.primaryBlue, width: 2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: AppColors.primaryBlue.withOpacity(0.2), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(bundle['icon'] as IconData, color: AppColors.primaryBlue, size: 36),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  bundle['name'] as String,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColors.darkBlue, 
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const Divider(color: AppColors.primaryBlue, height: 25),
          
          // Value Breakdown
          ... (bundle['accessories'] as List<String>).map((acc) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                const Icon(Icons.star_half, color: AppColors.primaryGreen, size: 18),
                const SizedBox(width: 8),
                Expanded(child: Text(acc, style: const TextStyle(fontSize: 14, color: AppColors.textDark))),
              ],
            ),
          )).toList(),
          
          const SizedBox(height: 15),

          // Pricing and Savings
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Retail Price:', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                  Text(
                    // Interpolation needed here, which is fine in double quotes.
                    '\$${(bundle['base_price'] as double).toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.red,
                      decoration: TextDecoration.lineThrough,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Your Bundle Price:', style: TextStyle(color: AppColors.darkBlue, fontSize: 14)),
                  Text(
                    // Interpolation needed here, which is fine in double quotes.
                    '\$${(bundle['bundle_price'] as double).toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.primaryGreen,
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          // Bundle CTA
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                // Interpolation needed here, which is fine in double quotes.
                'ORDER BUNDLE & SAVE \$${savingAmount.toStringAsFixed(2)}',
                style: const TextStyle(color: AppColors.textLight, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SECTION IMPLEMENTATIONS
// -----------------------------------------------------------------------------

// 1. HERO SECTION
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 1000;
    final double horizontalPadding = _getHorizontalPadding(context);

    return SizedBox(
      height: isDesktop ? 600 : 450,
      width: double.infinity,
      child: Stack(
        children: [
          // Background Image (must exist in assets/images/hero_background.webp)
          Positioned.fill(
            child: Image.asset(
              'assets/images/hero_background.webp',
              fit: BoxFit.cover,
              // Handle case where image asset is missing
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.darkBlue, // Fallback background color
                child: Text("HERO IMAGE MISSING", style: TextStyle(color: AppColors.textLight)),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(gradient: AppColors.sereneGradient),
            ),
          ),
          // Content Layer (PADDED MANUALLY, as it sits on top of stack)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "CRITICAL CARE. RELIABLE DELIVERY.",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: isDesktop ? 64 : 36,
                    color: AppColors.textLight,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: isDesktop ? 600 : double.infinity,
                  child: Text(
                    "Your specialized partner in medical equipment and consumables logistics. We ensure timely, compliant supply with unparalleled peace of mind.",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: isDesktop ? 22 : 16,
                      color: AppColors.textLight.withOpacity(0.9)
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: AppColors.gentleHighlightGradient,
                    boxShadow: [BoxShadow(color: AppColors.primaryBlue.withOpacity(0.5), blurRadius: 10)],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios, size: 18, color: AppColors.textDark),
                    label: const Text('EXPLORE SERVICES', style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
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

// 2. PRODUCT SALES SECTION (Updated for separate promo carousel and manual product carousel)
class _ProductSalesSection extends StatefulWidget {
  const _ProductSalesSection();

  @override
  State<_ProductSalesSection> createState() => _ProductSalesSectionState();
}

class _ProductSalesSectionState extends State<_ProductSalesSection> {
  late PageController _pageController;
  int _currentPage = 0;
  double _currentViewportFraction = 0.85;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: _currentViewportFraction);
    _pageController.addListener(_pageListener);
    // AUTOPLAY TIMER REMOVED HERE
  }

  void _pageListener() {
    if (_pageController.hasClients && _pageController.page != null) {
      int next = _pageController.page!.round();
      if (next != _currentPage) {
        setState(() {
          _currentPage = next;
        });
      }
    }
  }

  double _calculateNewViewportFraction(double screenWidth) {
    if (screenWidth >= 1200) {
      return 0.23;
    } else if (screenWidth >= 800) {
      return 0.30;
    } else {
      return 0.85;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final screenWidth = MediaQuery.of(context).size.width;
    double newViewportFraction = _calculateNewViewportFraction(screenWidth);
    if (_currentViewportFraction != newViewportFraction) {
      _currentViewportFraction = newViewportFraction;
      _pageController.removeListener(_pageListener);
      // Recreate controller with new fraction
      _pageController = PageController(viewportFraction: _currentViewportFraction, initialPage: _currentPage);
      _pageController.addListener(_pageListener);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // --- Navigation Methods (NO TIMER RESET - purely manual scroll) ---
  void _scrollToPrevious() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut
      );
    }
  }

  void _scrollToNext() {
    if (_currentPage < _dummyProducts.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut
      );
    }
  }
  // --------------------------

  // Method to show the modal
  void _showQuickView(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _ProductQuickViewModal(product: product);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    final double standardHorizontalPadding = _getHorizontalPadding(context);
    final double carouselOffsetAmount = standardHorizontalPadding;
    final bool canScrollLeft = _currentPage > 0;
    final bool canScrollRight = _currentPage < _dummyProducts.length - 1;

    return _SectionContainer(
      title: 'FEATURED PRODUCTS',
      backgroundColor: AppColors.cardBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. The new Auto-Playing Promo Header with Timer
          const _PromoSalesHeader(),
          const SizedBox(height: 50),
          
          // Catchy Sales Copy for Manual Carousel
          // START: REPLACED TEXT WIDGET WITH RICHTEXT FOR GRADIENT ON *GUARANTEE*
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: isDesktop ? 22 : 18, color: AppColors.textMuted, height: 1.5),
              children: [
                const TextSpan(
                  text: "Browse our expertly sourced medical technology and essential consumables that ",
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [AppColors.primaryGreen, AppColors.primaryBlue],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: Text(
                      // Text is rendered white/light by the shader mask's blend mode, showing the gradient
                      'guarantee', 
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: isDesktop ? 22 : 18,
                        color: Colors.white, // The text color itself is overridden by the mask, but must be non-transparent
                        fontWeight: FontWeight.w900,
                        shadows: [Shadow(color: AppColors.darkBlue.withOpacity(0.3), blurRadius: 2)],
                      ),
                    ),
                  ),
                ),
                const TextSpan(
                  text: " enhanced patient outcomes. Find exactly what your facility needs below.",
                ),
              ],
            ),
          ),
          // END: REPLACED TEXT WIDGET
          const SizedBox(height: 30),

          // **MANUAL CAROUSEL WIDGET STACK**
          Stack(
            children: [
              // 1. The Flush-Left PageView (User-controlled)
              Transform.translate(
                offset: Offset(-carouselOffsetAmount, 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _dummyProducts.length,
                    clipBehavior: Clip.none,
                    itemBuilder: (context, index) {
                      double scale = 1.0;
                      if (_pageController.hasClients && _pageController.page != null) {
                        scale = 1.0 - (_pageController.page! - index).abs() * 0.1;
                        if (scale < 0.9) scale = 0.9;
                      }
                      return AnimatedScale(
                        scale: scale,
                        duration: const Duration(milliseconds: 300),
                        child: Opacity(
                          opacity: scale > 0.95 ? 1.0 : 0.8,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: carouselOffsetAmount + 5.0,
                              right: 5.0,
                              top: 15.0,
                              bottom: 15.0
                            ),
                            child: _ProductCard(
                              product: _dummyProducts[index],
                              onQuickView: () => _showQuickView(_dummyProducts[index]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // 2. Navigation Buttons (Only visible on desktop/wider screens)
              if (isDesktop) ...[
                // Left Button
                Positioned(
                  left: 0,
                  top: 150, // Center vertically within the 400 height
                  child: Opacity(
                    opacity: canScrollLeft ? 1.0 : 0.5,
                    child: _CarouselButton(
                      icon: Icons.arrow_back_ios_new,
                      onPressed: canScrollLeft ? _scrollToPrevious : null,
                    ),
                  ),
                ),
                // Right Button
                Positioned(
                  right: 0,
                  top: 150, // Center vertically within the 400 height
                  child: Opacity(
                    opacity: canScrollRight ? 1.0 : 0.5,
                    child: _CarouselButton(
                      icon: Icons.arrow_forward_ios,
                      onPressed: canScrollRight ? _scrollToNext : null,
                    ),
                  ),
                ),
              ]
            ],
          ),
          
          const SizedBox(height: 10),

          // Carousel Indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_dummyProducts.length, (index) {
              return Container(
                width: _currentPage == index ? 16.0 : 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: _currentPage == index ? AppColors.primaryGreen : AppColors.textMuted.withOpacity(0.4),
                ),
              );
            }),
          ),
          
          // --- BUNDLES SECTION ---
          const SizedBox(height: 50),
          const _ProductBundlesSection(),
        ],
      ),
    );
  }
}

// Carousel Navigation Button
class _CarouselButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _CarouselButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // Green and Blue Gradient with Transparency
        gradient: LinearGradient(
          colors: [
            AppColors.primaryGreen.withOpacity(0.8),
            AppColors.primaryBlue.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.darkBlue.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: AppColors.textLight, size: 24),
        onPressed: onPressed,
        padding: const EdgeInsets.all(12),
        style: IconButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: const CircleBorder(),
        ),
      ),
    );
  }
}

// 3. SERVICES SECTION
class _ServicesSection extends StatelessWidget {
  const _ServicesSection();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;

    // Dummy service data (kept generic as per original structure)
    final List<Map<String, dynamic>> _dummyServices = [
      {
        'title': 'Advanced Imaging Support',
        'description': 'Maintenance, repair, and remote diagnostics for CT, MRI, and X-Ray systems.',
        'icon': Icons.image_search,
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
      child: isDesktop
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _dummyServices.map((service) => Expanded(
                child: _ServiceCard(service: service),
              )).toList(),
            )
          : Column(
              children: _dummyServices.map((service) => Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: _ServiceCard(service: service),
              )).toList(),
            ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final Map<String, dynamic> service;
  const _ServiceCard({required this.service});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: AppColors.textLight,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: _isHovering ? (widget.service['color'] as Color) : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovering ? (widget.service['color'] as Color).withOpacity(0.5) : AppColors.darkBlue.withOpacity(0.1),
              blurRadius: _isHovering ? 20 : 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              widget.service['icon'] as IconData,
              color: widget.service['color'] as Color,
              size: 50,
            ),
            const SizedBox(height: 20),
            Text(
              widget.service['title'] as String,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: AppColors.darkBlue,
                fontWeight: FontWeight.w800,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.service['description'] as String,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 16),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Learn More',
                  style: TextStyle(
                    color: widget.service['color'] as Color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5),
                Icon(Icons.arrow_forward, color: widget.service['color'] as Color, size: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// 4. QUALITY & COMPLIANCE SECTION
class _QualityComplianceSection extends StatelessWidget {
  const _QualityComplianceSection();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    
    return _SectionContainer(
      title: 'QUALITY & COMPLIANCE',
      backgroundColor: AppColors.cardBackground,
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _ComplianceText()),
                const SizedBox(width: 50),
                Expanded(child: _ComplianceCertificates()),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
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
        const _CompliancePoint(text: 'Complete end-to-end documentation trail for auditing and traceability.'),
      ],
    );
  }
}

class _ComplianceCertificates extends StatelessWidget {
  const _ComplianceCertificates();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: [
        _CertificateBadge(title: 'ISO 13485', subtitle: 'Medical QMS', icon: Icons.verified_user, color: AppColors.primaryBlue),
        _CertificateBadge(title: 'CE MARK', subtitle: 'European Conformity', icon: Icons.gavel, color: AppColors.primaryGreen),
        _CertificateBadge(title: 'Local FDA', subtitle: 'Registered & Approved', icon: Icons.local_hospital, color: Colors.orange),
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
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.security, color: AppColors.primaryBlue, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(color: AppColors.darkBlue, fontSize: 16))),
        ],
      ),
    );
  }
}

class _CertificateBadge extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  const _CertificateBadge({required this.title, required this.subtitle, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.textLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3), width: 2),
        boxShadow: [BoxShadow(color: color.withOpacity(0.2), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 40),
          const SizedBox(height: 10),
          Text(title, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.darkBlue, fontWeight: FontWeight.w900, fontSize: 20)),
          Text(subtitle, style: const TextStyle(color: AppColors.textMuted, fontSize: 14)),
        ],
      ),
    );
  }
}


// 5. TECHNOLOGY SPOTLIGHT SECTION
class _TechnologySection extends StatelessWidget {
  const _TechnologySection();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;

    return _SectionContainer(
      title: 'TECHNOLOGY SPOTLIGHT',
      backgroundColor: AppColors.lightBackground,
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(child: _TechnologyImage()),
                SizedBox(width: 50),
                Expanded(child: _TechnologyContent()),
              ],
            )
          : Column(
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
        const SizedBox(height: 25),
        const _TechnologyFeature(
          icon: Icons.battery_full,
          title: '48-Hour Continuous Battery',
          description: 'Industry-leading battery life for extended field operations.',
        ),
        const _TechnologyFeature(
          icon: Icons.wifi,
          title: 'Telemetry Integration',
          description: 'Seamless wireless data transfer to central monitoring stations.',
        ),
        const _TechnologyFeature(
          icon: Icons.shield,
          title: 'IP67 Rated Durability',
          description: 'Fully protected against dust and temporary water immersion.',
        ),
        const SizedBox(height: 30),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.document_scanner, color: AppColors.textLight, size: 20),
          label: const Text('Download Tech Specs', style: TextStyle(color: AppColors.textLight, fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryGreen,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}

class _TechnologyFeature extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  const _TechnologyFeature({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.textLight, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.darkBlue, fontWeight: FontWeight.bold)),
                Text(description, style: const TextStyle(color: AppColors.textMuted, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TechnologyImage extends StatelessWidget {
  const _TechnologyImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.cardBackground,
        boxShadow: [BoxShadow(color: AppColors.darkBlue.withOpacity(0.2), blurRadius: 15)],
      ),
      child: Center(
        child: Image.asset(
          'assets/images/patient_monitor.webp', // Placeholder image asset
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => 
              Icon(Icons.monitor_heart, size: 150, color: AppColors.darkBlue.withOpacity(0.8))
        ),
      ),
    );
  }
}


// 6. LOGISTICS SECTION
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
          isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Expanded(child: _LogisticsStep(step: 1, title: 'Order Fulfillment', description: 'Real-time stock checks and 24-hour dispatch guarantee.')),
                    Expanded(child: _LogisticsStep(step: 2, title: 'Specialized Transport', description: 'Temperature-controlled and shock-mitigating delivery systems.')),
                    Expanded(child: _LogisticsStep(step: 3, title: 'Last-Mile Delivery', description: 'Dedicated fleet for rapid delivery to remote and critical care facilities.')),
                  ],
                )
              : Column(
                  children: const [
                    _LogisticsStep(step: 1, title: 'Order Fulfillment', description: 'Real-time stock checks and 24-hour dispatch guarantee.'),
                    _LogisticsStep(step: 2, title: 'Specialized Transport', description: 'Temperature-controlled and shock-mitigating delivery systems.'),
                    _LogisticsStep(step: 3, title: 'Last-Mile Delivery', description: 'Dedicated fleet for rapid delivery to remote and critical care facilities.'),
                  ],
                ),
          const SizedBox(height: 20), // Reduced space after steps
          // REMOVED: The "Track Your Delivery" button has been removed as requested.
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
    bool isDesktop = MediaQuery.of(context).size.width > 800;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primaryGreen,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.darkBlue, width: 3),
            ),
            child: Center(
              child: Text(
                '$step',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.darkBlue, fontWeight: FontWeight.w900, fontSize: 30),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.darkBlue, fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          if (!isDesktop && step < 3)
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Icon(Icons.arrow_downward, color: AppColors.textMuted),
            )
        ],
      ),
    );
  }
}


// 7. CAREER SECTION
class _CareerSection extends StatelessWidget {
  const _CareerSection();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;

    return _SectionContainer(
      title: 'CAREERS',
      backgroundColor: AppColors.lightBackground,
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          gradient: AppColors.sereneGradient,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: AppColors.darkBlue.withOpacity(0.2), blurRadius: 15)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.textLight.withOpacity(0.9),
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.work, color: AppColors.darkBlue, size: 20),
                  label: const Text('VIEW OPENINGS', style: TextStyle(color: AppColors.darkBlue, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentGreen,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(width: 20),
                if (isDesktop)
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.info_outline, color: AppColors.textLight),
                    label: const Text('Why Work With Us?', style: TextStyle(color: AppColors.textLight, fontWeight: FontWeight.w600)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// 8. ABOUT US SECTION
class _AboutUsSection extends StatelessWidget {
  const _AboutUsSection();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    
    return _SectionContainer(
      title: 'ABOUT US',
      backgroundColor: AppColors.cardBackground,
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(child: _AboutContent()),
                SizedBox(width: 50),
                Expanded(child: _CompanyStats()),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _AboutContent(),
                SizedBox(height: 40),
                _CompanyStats(),
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
          'More Than a Supplier: Your Dedicated Medical Partner',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: AppColors.darkBlue,
            fontWeight: FontWeight.w900,
            fontSize: 28,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Founded by a team of former medical engineers and logistics veterans, our company was built to solve the most persistent problems in medical supply: compliance, lead times, and reliable technical support. We are obsessed with operational excellence.',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.textDark, fontSize: 18, height: 1.5),
        ),
        const SizedBox(height: 20),
        Text(
          'Our mission is to empower healthcare providers by ensuring they have the highest quality tools, exactly when they need them, allowing them to focus purely on patient care.',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.primaryGreen, fontWeight: FontWeight.bold, fontSize: 18, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}

class _CompanyStats extends StatelessWidget {
  const _CompanyStats();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _StatItem(value: '10+', label: 'Years in Operation', icon: Icons.schedule, color: AppColors.primaryBlue),
        _StatItem(value: '3,000+', label: 'Products in Catalog', icon: Icons.medical_services, color: AppColors.primaryGreen),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppColors.darkBlue, fontWeight: FontWeight.w900, fontSize: 32)),
              Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}


// 9. TESTIMONIALS SECTION
class _TestimonialsSection extends StatelessWidget {
  const _TestimonialsSection();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;

    final List<Map<String, dynamic>> _dummyTestimonials = [
      {
        'quote': 'The best service we have ever received. Their turnaround time on a critical X-Ray part saved us hundreds of operating hours.',
        'name': 'Dr. Evelyn Reed',
        'title': 'Chief Radiologist, City Central Hospital',
        'avatar': 'assets/images/avatar_evelyn.webp',
      },
      {
        'quote': 'Compliance documentation is always perfect, and their cold chain for reagents is completely reliable. True partners in laboratory operations.',
        'name': 'James Kwena',
        'title': 'Supply Chain Director, Regional Lab Network',
        'avatar': 'assets/images/avatar_james.webp',
      },
      {
        'quote': 'The sales team is technically proficient. They don\'t just sell, they consult. Highly recommend their telemetry systems.',
        'name': 'Nurse Lydia Chen',
        'title': 'Head of ICU, St. Jude\'s Medical Center',
        'avatar': 'assets/images/avatar_lydia.webp',
      },
    ];

    return _SectionContainer(
      title: 'TESTIMONIALS',
      backgroundColor: AppColors.lightBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What Our Partners Say About Our Service',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: AppColors.primaryGreen,
              fontWeight: FontWeight.w900,
              fontSize: isDesktop ? 32 : 24,
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: isDesktop ? 300 : null, // Fixed height for desktop carousel effect
            child: isDesktop
                ? Row(
                    children: _dummyTestimonials.map((t) => Expanded(child: _TestimonialCard(testimonial: t))).toList(),
                  )
                : Column(
                    children: _dummyTestimonials.map((t) => Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: _TestimonialCard(testimonial: t),
                    )).toList(),
                  ),
          ),
          
          const SizedBox(height: 40),
          // NEW BUTTON: View All Testimonials
          Center(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.reviews, color: AppColors.textLight, size: 20),
              label: const Text('VIEW ALL 500+ TESTIMONIALS', style: TextStyle(color: AppColors.textLight, fontWeight: FontWeight.bold, fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
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
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.textLight,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.1), width: 1),
        boxShadow: [BoxShadow(color: AppColors.darkBlue.withOpacity(0.1), blurRadius: 10)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.format_quote, color: AppColors.primaryGreen, size: 40),
          const SizedBox(height: 20),
          Expanded(
            child: Text(
              testimonial['quote'] as String,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontStyle: FontStyle.italic, color: AppColors.darkBlue, fontSize: 18, height: 1.6),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          // Divider(color: AppColors.textMuted.withOpacity(0.3)),
          // const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar Placeholder
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.primaryBlue,
                child: Text(
                  (testimonial['name'] as String).split(' ').map((e) => e.substring(0, 1)).join(),
                  style: const TextStyle(color: AppColors.textLight, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(testimonial['name'] as String, style: const TextStyle(color: AppColors.darkBlue, fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(testimonial['title'] as String, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 10. BLOGS/NEWS SECTION
class _BlogsSection extends StatelessWidget {
  const _BlogsSection();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    
    final List<Map<String, dynamic>> _dummyBlogs = [
      {'title': 'The Future of AI in Diagnostic Imaging', 'tag': 'Technology', 'date': 'Oct 25, 2024'},
      {'title': 'Navigating New European Medical Device Regulations (MDR)', 'tag': 'Compliance', 'date': 'Oct 10, 2024'},
      {'title': 'Cold Chain Best Practices for Temperature-Sensitive Reagents', 'tag': 'Logistics', 'date': 'Sep 28, 2024'},
    ];

    return _SectionContainer(
      title: 'LATEST INSIGHTS',
      backgroundColor: AppColors.cardBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Stay Ahead with Expert Analysis and Industry News',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: AppColors.darkBlue,
              fontWeight: FontWeight.w900,
              fontSize: isDesktop ? 32 : 24,
            ),
          ),
          const SizedBox(height: 40),
          isDesktop
              ? Row(
                  children: _dummyBlogs.map((b) => Expanded(child: _BlogCard(blog: b))).toList(),
                )
              : Column(
                  children: _dummyBlogs.map((b) => Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: _BlogCard(blog: b),
                  )).toList(),
                ),
          
          const SizedBox(height: 40),
          // NEW BUTTON: View All Articles
          Center(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.menu_book, color: AppColors.textLight, size: 20),
              label: const Text('VIEW ALL ARTICLES & NEWS', style: TextStyle(color: AppColors.textLight, fontWeight: FontWeight.bold, fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlogCard extends StatelessWidget {
  final Map<String, dynamic> blog;
  const _BlogCard({required this.blog});

  @override
  Widget build(BuildContext context) {
    final String title = blog['title'] as String;
    final String tag = blog['tag'] as String;
    final String date = blog['date'] as String;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.textLight,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: AppColors.darkBlue.withOpacity(0.1), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image/Icon Placeholder
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              gradient: AppColors.gentleHighlightGradient,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Center(child: Icon(Icons.article, color: AppColors.darkBlue.withOpacity(0.8), size: 40)),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tag, style: const TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.darkBlue),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Icon(Icons.calendar_month, color: AppColors.textMuted, size: 16),
                    const SizedBox(width: 5),
                    Text(date, style: const TextStyle(color: AppColors.textMuted, fontSize: 14)),
                    const Spacer(),
                    const Text('Read More →', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600, fontSize: 14)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}