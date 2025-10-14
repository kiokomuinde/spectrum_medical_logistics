// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'dart:async'; // Required for the countdown timer
import '../theme/app_theme.dart';
import '../constants/app_constants.dart';

// --- FIXED: REQUIRED EXTERNAL WIDGET IMPORTS ---
// This ensures you use the external, dark-themed widgets.
import '../widgets/responsive_navbar.dart'; 
import '../widgets/app_footer.dart';        
// ---------------------------------------------

// --- HELPER FUNCTION FOR RESPONSIVE PADDING (REDUCED FURTHER FOR TIGHTER CAROUSEL) ---
double _getHorizontalPadding(BuildContext context) {
  // Desktop padding REDUCED from 60.0 to 40.0
  // Mobile padding REDUCED from 15.0 to 10.0 for a very tight fit
  return MediaQuery.of(context).size.width > 800 ? 40.0 : 10.0;
}
// ----------------------------------------------

// --- DUMMY PRODUCT DATA (DOUBLED TO 10 ITEMS) ---
final List<Map<String, dynamic>> _dummyProducts = [
  {
    'id': 1,
    'name': 'High-Resolution X-Ray System',
    'description': 'Advanced digital radiography for superior diagnostic imaging.',
    'price': 'USD 85,000',
    'icon': Icons.image_search,
    'isNew': true, 
    'rating': 4.8, 
    'reviews': 124, 
  },
  {
    'id': 2,
    'name': 'Portable Patient Monitor',
    'description': 'Real-time monitoring of vital signs (ECG, SpO2, NIBP).',
    'price': 'USD 4,500',
    'icon': Icons.monitor_heart,
    'isNew': false,
    'rating': 4.6, 
    'reviews': 288, 
  },
  {
    'id': 3,
    'name': 'Automated Lab Analyzer',
    'description': 'High-throughput system for clinical chemistry and immunoassay.',
    'price': 'USD 120,000',
    'icon': Icons.biotech,
    'isNew': false,
    'rating': 4.9, 
    'reviews': 98, 
  },
  {
    'id': 4,
    'name': 'Sterile Surgical Pack',
    'description': 'Pre-packaged, disposable kit for minor surgical procedures.',
    'price': 'USD 85',
    'icon': Icons.inventory,
    'isNew': true,
    'rating': 4.4, 
    'reviews': 450, 
  },
  {
    'id': 5,
    'name': 'Infusion Pump System',
    'description': 'Precision fluid and medication delivery with smart safety.',
    'price': 'USD 3,200',
    'icon': Icons.local_hospital,
    'isNew': false,
    'rating': 4.7, 
    'reviews': 210, 
  },
  // --- DUPLICATE ITEMS ADDED HERE ---
  {
    'id': 6,
    'name': 'Advanced Ventilator Unit',
    'description': 'Critical care ventilator with adaptive pressure support modes.',
    'price': 'USD 35,000',
    'icon': Icons.monitor_weight,
    'isNew': true,
    'rating': 4.9, 
    'reviews': 75, 
  },
  {
    'id': 7,
    'name': 'Digital Ultrasound Scanner',
    'description': 'Portable ultrasound for rapid bedside diagnostics.',
    'price': 'USD 18,500',
    'icon': Icons.medical_services,
    'isNew': false,
    'rating': 4.5, 
    'reviews': 312, 
  },
  {
    'id': 8,
    'name': 'Ophthalmic Laser System',
    'description': 'Precision laser for anterior and posterior segment procedures.',
    'price': 'USD 95,000',
    'icon': Icons.visibility,
    'isNew': false,
    'rating': 4.8, 
    'reviews': 55, 
  },
  {
    'id': 9,
    'name': 'Disposable Syringe Boxes (1000ct)',
    'description': 'Sterile, high-quality syringes for general clinical use.',
    'price': 'USD 550',
    'icon': Icons.precision_manufacturing,
    'isNew': true,
    'rating': 4.3, 
    'reviews': 980, 
  },
  {
    'id': 10,
    'name': 'Telemetry Monitoring System',
    'description': 'Wireless central station monitoring for multiple patients.',
    'price': 'USD 62,000',
    'icon': Icons.settings_remote,
    'isNew': false,
    'rating': 4.7, 
    'reviews': 180, 
  },
];
// -------------------------------------------------

// --- NEW DUMMY BUNDLE DATA ---
final List<Map<String, dynamic>> _dummyBundles = [
  {
    'name': 'Zero-Downtime Monitoring Package',
    'product_id': 2, // Portable Patient Monitor
    'accessories': ['Extra Long-Life Battery', 'Annual Calibration Service'],
    'base_price': 5200.00,
    'bundle_price': 4699.00,
    'icon': Icons.local_hospital,
  },
  {
    'name': 'Premium X-Ray Installation Kit',
    'product_id': 1, // X-Ray System
    'accessories': ['Lead Shielding Materials', '3-Day On-Site Training'],
    'base_price': 89000.00,
    'bundle_price': 86500.00,
    'icon': Icons.install_desktop,
  },
];
// -----------------------------

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // This now correctly uses the imported, external ResponsiveNavBar
      appBar: ResponsiveNavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _HeroSection(),
            _ProductSalesSection(), 
            _ServicesSection(),
            _QualityComplianceSection(),
            _TechnologySection(),
            _LogisticsSection(),
            _CareerSection(),
            _AboutUsSection(),
            _TestimonialsSection(),
            _BlogsSection(),
            // This now correctly uses the imported, external AppFooter
            AppFooter(),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// HELPER WIDGETS (Section Container - STANDARD PADDING)
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
    // Standard responsive padding for content alignment
    final double horizontalPadding = _getHorizontalPadding(context);
    
    return Container(
      color: backgroundColor ?? AppColors.lightBackground,
      // **STANDARD PADDING APPLIED HERE**
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
          const Divider(color: AppColors.primaryGreen, thickness: 3, indent: 0, endIndent: 0),
          const SizedBox(height: 50),
          // Child is now contained within the padded area
          child, 
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// E-COMMERCE ENHANCEMENTS (New Widgets)
// -----------------------------------------------------------------------------

// Widget 1: Flash Sale Countdown Timer (Urgency)
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
    // Start a timer that ticks every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining.inSeconds == 0) {
        timer.cancel();
      } else {
        if(mounted) { // Check if the widget is still mounted before calling setState
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
            'LIMITED TIME FLASH SALE! Ends in:',
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

// Widget 2: Quick View Modal (Irresistible Content)
class _ProductQuickViewModal extends StatelessWidget {
  final Map<String, dynamic> product;

  const _ProductQuickViewModal({required this.product});

  // Irresistible Value Props
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
              // Image/Icon Area with Discount Tag
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: AppColors.gentleHighlightGradient,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Icon(product['icon'] as IconData, size: 100, color: AppColors.darkBlue.withOpacity(0.8)),
                    ),
                  ),
                  // Massive Discount Badge (Urgency/Irresistibility)
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
              
              // Value Proposition Bullets (Irresistible Content)
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

// --- NEW HELPER WIDGET: Product Bundles Section ---
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

// --- NEW HELPER WIDGET: Individual Bundle Card ---
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
          // NOTE: Ensure you have an image at this path or replace with a color/gradient
          Positioned.fill(
            child: Image.asset('assets/images/hero_background.webp', fit: BoxFit.cover, 
              // Handle case where image asset is missing
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.darkBlue, // Fallback background color
                child: Center(child: Text("HERO IMAGE MISSING", style: TextStyle(color: AppColors.textLight))),
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

// 2. PRODUCT SALES SECTION
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

  // --- Navigation Methods ---
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
    // Uses the REDUCED padding from _getHorizontalPadding
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
          // Catchy Sales Copy
          Text(
            "Ignite your clinical capacity! Discover the high-value medical technology and essential consumables that *guarantee* enhanced patient outcomes. Expertly sourced, flawlessly delivered, and now with **limited-time savings.**",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: isDesktop ? 22 : 18, color: AppColors.textMuted),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 30),
          // Flash Sale Timer (Urgency)
          const _SaleTimer(),
          const SizedBox(height: 40),

          // **CAROUSEL WIDGET STACK**
          Stack(
            children: [
              // 1. The Flush-Left PageView
              Transform.translate(
                // This offset is key to pulling the carousel to the left edge of the screen
                // and compensating for the section's padding.
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
                              // *** TIGHTER PADDING APPLIED HERE (REDUCED 10.0 to 5.0) ***
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
          
          // --- BUNDLES SECTION ADDED HERE ---
          const SizedBox(height: 50),
          const _ProductBundlesSection(),
          // ------------------------------------
        ],
      ),
    );
  }
}

// Carousel Navigation Button (Transparent Gradient)
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

// Product Card Widget (Updated with QuickView and Ratings)
class _ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onQuickView;

  const _ProductCard({required this.product, required this.onQuickView});

  // Helper to render star icons
  Widget _buildRatingStars(double rating) {
    int fullStars = rating.floor();
    bool halfStar = (rating - fullStars) >= 0.25;
    List<Widget> stars = [];
    
    for (int i = 0; i < 5; i++) {
      IconData icon;
      Color color = AppColors.primaryGreen;
      if (i < fullStars) {
        icon = Icons.star;
      } else if (i == fullStars && halfStar) {
        icon = Icons.star_half;
      } else {
        icon = Icons.star_border;
        color = AppColors.textMuted.withOpacity(0.5);
      }
      stars.add(Icon(icon, color: color, size: 16));
    }
    return Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 5)
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Image Area
          SizedBox(
            height: 160,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.gentleHighlightGradient,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(product['icon'] as IconData, size: 60, color: AppColors.darkBlue.withOpacity(0.9)),
                        const SizedBox(height: 5),
                        // New/Sale Tag
                        if (product['isNew'] == true)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.primaryGreen,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text('NEW STOCK', style: TextStyle(color: AppColors.textDark, fontSize: 11, fontWeight: FontWeight.bold)),
                          ),
                      ],
                    ),
                  ),
                ),
                // Quick View Icon
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.search, color: AppColors.darkBlue, size: 28),
                    onPressed: onQuickView,
                    tooltip: 'Quick View',
                  ),
                ),
              ],
            ),
          ),

          // 2. Product Details
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  product['name'] as String,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),

                // Rating & Reviews
                Row(
                  children: [
                    _buildRatingStars(product['rating'] as double),
                    const SizedBox(width: 8),
                    Text(
                      '(${product['reviews']} reviews)',
                      style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Price
                Text(
                  product['price'] as String,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: AppColors.primaryGreen,
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 15),

                // CTA Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add to cart or Request Quote logic
                    },
                    icon: const Icon(Icons.shopping_cart_outlined, size: 18),
                    label: const Text('Add to Cart', style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: AppColors.textLight,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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

// 3. SERVICES SECTION
class _ServicesSection extends StatelessWidget {
  const _ServicesSection();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    
    return _SectionContainer(
      title: 'SPECIALIZED SERVICES',
      backgroundColor: AppColors.lightBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Beyond supply—we provide comprehensive maintenance, calibration, and support essential for clinical uptime and compliance.",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: isDesktop ? 22 : 18, color: AppColors.textMuted),
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 3 : 1,
              childAspectRatio: isDesktop ? 3.5 : 4.5,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: AppConstants.productsAndServices.length,
            itemBuilder: (context, index) {
              final service = AppConstants.productsAndServices[index];
              return _ServiceCard(
                title: service['title'],
                description: service['description'],
                icon: service['icon'],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _ServiceCard({required this.title, required this.description, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryGreen.withOpacity(0.5)),
        boxShadow: [BoxShadow(color: AppColors.textMuted.withOpacity(0.1), blurRadius: 8)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primaryGreen, size: 40),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  description,
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 4. QUALITY & COMPLIANCE SECTION (Formerly Quality)
class _QualityComplianceSection extends StatelessWidget {
  const _QualityComplianceSection();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    
    return _SectionContainer(
      title: 'QUALITY & COMPLIANCE',
      backgroundColor: AppColors.cardBackground,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop)
            const Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(right: 50.0),
                child: Text(
                  "We exceed global standards. Our commitment to ISO-certified practices ensures every product and service meets the highest regulatory bar for critical patient care.",
                  style: TextStyle(fontSize: 18, color: AppColors.textDark, height: 1.5),
                ),
              ),
            ),
          
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Compliance points
                _CompliancePoint(
                  icon: Icons.gavel_outlined,
                  title: 'Regulatory Assurance (FDA/CE)',
                  description: 'All supplied medical devices are fully certified and compliant with international governing bodies.',
                ),
                _CompliancePoint(
                  icon: Icons.verified_user_outlined,
                  title: 'ISO 13485 Certified Supply Chain',
                  description: 'Our logistics and management systems adhere strictly to the Quality Management System for medical devices.',
                ),
                _CompliancePoint(
                  icon: Icons.check_circle_outline,
                  title: 'Rigorous Quality Control',
                  description: 'Multi-stage inspection and validation before, during, and after shipment to guarantee integrity.',
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.file_download_outlined),
                  label: const Text('DOWNLOAD CERTIFICATIONS'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: AppColors.darkBlue,
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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

class _CompliancePoint extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _CompliancePoint({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primaryGreen, size: 36),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// 5. TECHNOLOGY SECTION (Placeholder for future development/remapping)
class _TechnologySection extends StatelessWidget {
  const _TechnologySection();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    
    return _SectionContainer(
      title: 'TECHNOLOGY & INNOVATION',
      backgroundColor: AppColors.lightBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "We leverage cutting-edge logistics and data management technology to predict needs, secure cold chain integrity, and provide real-time tracking for every shipment.",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: isDesktop ? 22 : 18, color: AppColors.textMuted),
          ),
          const SizedBox(height: 40),
          
          isDesktop
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: AppConstants.partnerLogos.map((logo) => Expanded(
                  child: _PartnerLogoCard(logo: logo),
                )).toList(),
              )
            : Column(
                children: AppConstants.partnerLogos.map((logo) => Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: _PartnerLogoCard(logo: logo),
                )).toList(),
              ),
        ],
      ),
    );
  }
}

class _PartnerLogoCard extends StatelessWidget {
  final Map<String, dynamic> logo;

  const _PartnerLogoCard({required this.logo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: AppColors.textMuted.withOpacity(0.1), blurRadius: 8)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(logo['icon'] as IconData, color: AppColors.darkBlue, size: 48),
          const SizedBox(height: 10),
          Text(
            logo['name'] as String,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkBlue,
            ),
          ),
        ],
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
      title: 'PRECISION LOGISTICS',
      backgroundColor: AppColors.cardBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "The journey of critical medical equipment requires military precision. Our 4-step logistics protocol guarantees integrity from our warehouse to your operating table.",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: isDesktop ? 22 : 18, color: AppColors.textMuted),
          ),
          const SizedBox(height: 50),
          
          isDesktop
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: AppConstants.logisticsSteps.map((step) => Expanded(
                  child: _LogisticsStepCard(step: step),
                )).toList(),
              )
            : Column(
                children: AppConstants.logisticsSteps.map((step) => Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: _LogisticsStepCard(step: step),
                )).toList(),
              ),
          
          const SizedBox(height: 40),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.track_changes_outlined),
              label: const Text('TRACK YOUR SHIPMENT', style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: AppColors.textLight,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogisticsStepCard extends StatelessWidget {
  final Map<String, dynamic> step;

  const _LogisticsStepCard({required this.step});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: AppColors.primaryBlue.withOpacity(0.1), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(step['icon'] as IconData, color: AppColors.primaryGreen, size: 48),
          const SizedBox(height: 15),
          Text(
            step['title'] as String,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkBlue,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            step['desc'] as String,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}


// 7. CAREER SECTION (Placeholder)
class _CareerSection extends StatelessWidget {
  const _CareerSection();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    
    return _SectionContainer(
      title: 'JOIN OUR MISSION',
      backgroundColor: AppColors.lightBackground,
      child: Center(
        child: Column(
          children: [
            Text(
              "Become a part of the specialized team dedicated to transforming healthcare logistics. We are seeking professionals in supply chain, engineering, and compliance.",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: isDesktop ? 22 : 18, color: AppColors.textMuted),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.work_outline),
              label: const Text('VIEW OPEN POSITIONS', style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: AppColors.darkBlue,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
              ),
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
      title: 'OUR MISSION',
      backgroundColor: AppColors.cardBackground,
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  flex: 2,
                  child: Text(
                    "Spectrum was founded on the principle that critical care cannot wait. We eliminate supply chain complexities, bridging the gap between world-class manufacturers and the hospitals that need them most. Our mission is to ensure every doctor has the right tool, at the right time, every time.",
                    style: TextStyle(fontSize: 20, color: AppColors.textDark, height: 1.6),
                  ),
                ),
                const SizedBox(width: 50),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _MissionStat(icon: Icons.public, title: 'Global Reach', description: 'Servicing clients across three continents.'),
                      _MissionStat(icon: Icons.trending_up, title: 'Certified Growth', description: 'Over 15% year-on-year expansion.'),
                      _MissionStat(icon: Icons.groups, title: 'Dedicated Experts', description: 'Team of regulatory and technical specialists.'),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Spectrum was founded on the principle that critical care cannot wait. We eliminate supply chain complexities, bridging the gap between world-class manufacturers and the hospitals that need them most. Our mission is to ensure every doctor has the right tool, at the right time, every time.",
                  style: TextStyle(fontSize: 18, color: AppColors.textDark, height: 1.6),
                ),
                const SizedBox(height: 30),
                _MissionStat(icon: Icons.public, title: 'Global Reach', description: 'Servicing clients across three continents.'),
                _MissionStat(icon: Icons.trending_up, title: 'Certified Growth', description: 'Over 15% year-on-year expansion.'),
                _MissionStat(icon: Icons.groups, title: 'Dedicated Experts', description: 'Team of regulatory and technical specialists.'),
              ],
            ),
    );
  }
}

class _MissionStat extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _MissionStat({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primaryBlue, size: 30),
          const SizedBox(width: 15),
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
                Text(
                  description,
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 14),
                ),
              ],
            ),
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
    
    return Container(
      color: AppColors.primaryBlue,
      padding: const EdgeInsets.symmetric(vertical: 80.0),
      child: Column(
        children: [
          Text(
            'TRUSTED BY CLINICAL LEADERS',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: isDesktop ? 38 : 28,
              color: AppColors.textLight, 
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 50),
          
          isDesktop
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: AppConstants.testimonials.map((testimonial) => Expanded(
                  child: _TestimonialCard(testimonial: testimonial),
                )).toList(),
              )
            : Column(
                children: AppConstants.testimonials.map((testimonial) => Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: _TestimonialCard(testimonial: testimonial),
                )).toList(),
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
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isDesktop ? 20 : 40),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: AppColors.darkBlue.withOpacity(0.2), blurRadius: 15)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.format_quote, color: AppColors.primaryGreen, size: 40),
          const SizedBox(height: 15),
          Text(
            testimonial['quote'] as String,
            style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: AppColors.textDark, height: 1.5),
          ),
          const SizedBox(height: 20),
          Text(
            testimonial['source'] as String,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkBlue,
            ),
          ),
        ],
      ),
    );
  }
}


// 10. BLOGS SECTION
class _BlogsSection extends StatelessWidget {
  const _BlogsSection();

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    final double horizontalPadding = _getHorizontalPadding(context);
    
    return Container(
      color: AppColors.lightBackground,
      padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INDUSTRY INSIGHTS',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: isDesktop ? 38 : 28,
              color: AppColors.darkBlue, 
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: AppColors.primaryGreen, thickness: 3, indent: 0, endIndent: 0),
          const SizedBox(height: 50),

          isDesktop
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: AppConstants.blogArticles.map((article) => Expanded(
                  child: _BlogCard(article: article),
                )).toList(),
              )
            : Column(
                children: AppConstants.blogArticles.map((article) => Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: _BlogCard(article: article),
                )).toList(),
              ),
          
          const SizedBox(height: 40),
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text('VIEW ALL ARTICLES', style: TextStyle(color: AppColors.darkBlue, decoration: TextDecoration.underline, fontSize: 16)),
            )
          )
        ],
      ),
    );
  }
}

class _BlogCard extends StatelessWidget {
  final Map<String, dynamic> article;
  const _BlogCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: AppColors.textMuted.withOpacity(0.15), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(article['tag'] as String, style: const TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(
            article['title'] as String,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textDark),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Icon(Icons.calendar_month, color: AppColors.textMuted, size: 16),
              const SizedBox(width: 5),
              Text(article['date'] as String, style: const TextStyle(color: AppColors.textMuted, fontSize: 14)),
              const Spacer(),
              const Text('Read More →', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600, fontSize: 14)),
            ],
          )
        ],
      ),
    );
  }
}