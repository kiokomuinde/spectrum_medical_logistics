// lib/screens/product_catalog_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui'; 
import '../widgets/responsive_navbar.dart';
import '../theme/app_theme.dart';

// --- ENRICHED MOCK DATA ---
// Added: ratings, reviews, brand, isSale, originalPrice, description
final List<Map<String, dynamic>> _richProducts = [
  {
    'id': 1,
    'title': 'Titanium Surgical Hemostat - Curved 5"',
    'sku': 'SRG-8821-C',
    'price': 145.00,
    'originalPrice': 180.00,
    'isSale': true,
    'category': 'Surgical Tools',
    'brand': 'MediSteel',
    'badge': 'BEST SELLER',
    'rating': 4.8,
    'reviews': 124,
    'imageIcon': Icons.cut,
    'inStock': true,
    'description': 'Premium grade titanium hemostat for precision vascular control.',
  },
  {
    'id': 2,
    'title': 'Digital Vital Signs Monitor (Portable Series)',
    'sku': 'EQP-9910-X',
    'price': 1250.00,
    'originalPrice': 1250.00,
    'isSale': false,
    'category': 'Equipment',
    'brand': 'TechCare',
    'badge': 'FDA APPROVED',
    'rating': 5.0,
    'reviews': 42,
    'imageIcon': Icons.monitor_heart,
    'inStock': true,
    'description': 'Compact multi-parameter monitor for ambulatory and bedside use.',
  },
  {
    'id': 3,
    'title': 'Sterile Scalpel Blades #10 (Box of 100)',
    'sku': 'CNS-1102-S',
    'price': 45.99,
    'originalPrice': 45.99,
    'isSale': false,
    'category': 'Consumables',
    'brand': 'SharpEdge',
    'badge': 'BULK SAVE',
    'rating': 4.5,
    'reviews': 89,
    'imageIcon': Icons.vaccines, 
    'inStock': true,
    'description': 'Carbon steel sterile blades, individually foil wrapped.',
  },
  {
    'id': 4,
    'title': 'Diagnostic Ultrasound Gel - 5L Canister',
    'sku': 'DGN-5501-G',
    'price': 28.50,
    'originalPrice': 35.00,
    'isSale': true,
    'category': 'Diagnostic',
    'brand': 'EchoClear',
    'badge': null,
    'rating': 4.2,
    'reviews': 310,
    'imageIcon': Icons.water_drop,
    'inStock': true,
    'description': 'Hypoallergenic, acoustically correct viscous gel.',
  },
  {
    'id': 5,
    'title': 'Autoclave Sterilizer Class B (23L)',
    'sku': 'STR-3301-A',
    'price': 3499.00,
    'originalPrice': 3499.00,
    'isSale': false,
    'category': 'Sterilization',
    'brand': 'CleanTech',
    'badge': 'ISO 13485',
    'rating': 4.9,
    'reviews': 15,
    'imageIcon': Icons.cleaning_services,
    'inStock': false, // Out of stock
    'description': 'Advanced vacuum steam sterilizer for dental and medical clinics.',
  },
  {
    'id': 6,
    'title': 'N95 Medical Grade Respirator Masks (20/Box)',
    'sku': 'PPE-9901-M',
    'price': 24.00,
    'originalPrice': 24.00,
    'isSale': false,
    'category': 'PPE',
    'brand': 'SafeGuard',
    'badge': 'NIOSH',
    'rating': 4.6,
    'reviews': 1500,
    'imageIcon': Icons.masks,
    'inStock': true,
    'description': 'Fluid resistant particulate respirator.',
  },
  {
    'id': 7,
    'title': 'Littmann Cardiology IV Stethoscope',
    'sku': 'DG-LIT-04',
    'price': 189.00,
    'originalPrice': 210.00,
    'isSale': true,
    'category': 'Diagnostic',
    'brand': '3M',
    'badge': 'NEW',
    'rating': 4.9,
    'reviews': 850,
    'imageIcon': Icons.headphones, 
    'inStock': true,
    'description': 'Outstanding acoustic performance with better audibility of high-frequency sounds.',
  },
  {
    'id': 8,
    'title': 'Latex Examination Gloves (Powder Free)',
    'sku': 'PPE-GLV-L',
    'price': 12.50,
    'originalPrice': 12.50,
    'isSale': false,
    'category': 'PPE',
    'brand': 'SafeGuard',
    'badge': null,
    'rating': 4.3,
    'reviews': 220,
    'imageIcon': Icons.back_hand,
    'inStock': true,
    'description': 'Textured fingertips for improved grip. Box of 100.',
  },
];

class ProductCatalogScreen extends StatefulWidget {
  const ProductCatalogScreen({super.key});

  @override
  State<ProductCatalogScreen> createState() => _ProductCatalogScreenState();
}

class _ProductCatalogScreenState extends State<ProductCatalogScreen> {
  // Filters State
  final RangeValues _currentPriceRange = const RangeValues(0, 5000);
  final Set<String> _selectedCategories = {};
  final Set<String> _selectedBrands = {};
  bool _isGridView = true;
  String _sortBy = 'Relevance';
  
  // Responsive Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isDesktop = width >= tabletBreakpoint;
        final isMobile = width < mobileBreakpoint;

        return Scaffold(
          backgroundColor: const Color(0xFFF5F7FA), // Very light grey/blue background
          appBar: const ResponsiveNavBar(),
          
          // Mobile Filter Button
          floatingActionButton: !isDesktop
              ? FloatingActionButton.extended(
                  onPressed: _openMobileFilterSheet,
                  backgroundColor: AppColors.primaryBlue,
                  icon: const Icon(Icons.tune, color: Colors.white),
                  label: const Text("Filters & Sort", style: TextStyle(color: Colors.white)),
                )
              : null,
              
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- LEFT SIDEBAR (Desktop Only) ---
              if (isDesktop)
                Container(
                  width: 280,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(right: BorderSide(color: Colors.grey.withOpacity(0.1))),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: _buildFilterContent(),
                  ),
                ),

              // --- MAIN CONTENT ---
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    // 1. Breadcrumbs & Header
                    SliverToBoxAdapter(
                      child: _buildCatalogHeader(isDesktop, isMobile),
                    ),
                    
                    // 2. Product Grid/List
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 16 : 32, 
                        vertical: 16
                      ),
                      sliver: _isGridView
                          ? SliverGrid(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: _calculateGridCount(width),
                                childAspectRatio: 0.62, // Taller cards for "Rich" content
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (ctx, i) => _RichProductCard(
                                  product: _richProducts[i],
                                  isGrid: true,
                                ),
                                childCount: _richProducts.length,
                              ),
                            )
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (ctx, i) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: _RichProductCard(
                                    product: _richProducts[i],
                                    isGrid: false,
                                  ),
                                ),
                                childCount: _richProducts.length,
                              ),
                            ),
                    ),
                    
                    // Bottom spacing for FAB
                    const SliverToBoxAdapter(child: SizedBox(height: 80)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  int _calculateGridCount(double width) {
    if (width < 600) return 1; // Mobile
    if (width < 900) return 2; // Tablet Portrait
    if (width < 1400) return 3; // Tablet Landscape / Small Desktop
    return 4; // Large Desktop
  }

  // --- HEADER SECTION ---
  Widget _buildCatalogHeader(bool isDesktop, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Breadcrumbs
          Row(
            children: [
              InkWell(
                onTap: () => context.go('/'),
                child: const Text("Home", style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.chevron_right, size: 14, color: AppColors.textMuted),
              ),
              const Text("Catalog", style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 12),
          
          // Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Medical Supplies",
                      style: TextStyle(
                        fontSize: isMobile ? 24 : 32,
                        fontWeight: FontWeight.w900,
                        color: AppColors.darkBlue,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Premium quality surgical tools and hospital equipment.",
                      style: TextStyle(color: AppColors.textMuted, fontSize: 14),
                    ),
                  ],
                ),
              ),
              
              if (isDesktop) ...[
                // Sort Dropdown
                 Container(
                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(8),
                     border: Border.all(color: Colors.grey.shade300),
                   ),
                   child: DropdownButtonHideUnderline(
                     child: DropdownButton<String>(
                       value: _sortBy,
                       isDense: true,
                       style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark, fontSize: 14),
                       items: ["Relevance", "Price: Low to High", "Price: High to Low", "Top Rated"]
                           .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                           .toList(),
                       onChanged: (v) => setState(() => _sortBy = v!),
                     ),
                   ),
                 ),
                 const SizedBox(width: 16),
                
                // View Toggle
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.grid_view_rounded, size: 20),
                        color: _isGridView ? AppColors.primaryBlue : AppColors.textMuted,
                        onPressed: () => setState(() => _isGridView = true),
                      ),
                      Container(width: 1, height: 24, color: Colors.grey.shade300),
                      IconButton(
                        icon: const Icon(Icons.view_list_rounded, size: 20),
                        color: !_isGridView ? AppColors.primaryBlue : AppColors.textMuted,
                        onPressed: () => setState(() => _isGridView = false),
                      ),
                    ],
                  ),
                )
              ]
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
        ],
      ),
    );
  }

  // --- FILTERS CONTENT ---
  Widget _buildFilterContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("FILTERS", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 1.0)),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedCategories.clear();
                  _selectedBrands.clear();
                });
              },
              child: const Text("Reset", style: TextStyle(fontSize: 12, color: AppColors.primaryBlue)),
            )
          ],
        ),
        const SizedBox(height: 24),
        
        // Category Filter
        _buildFilterSectionTitle("Categories"),
        ...["Surgical Tools", "Consumables", "Equipment", "Sterilization", "PPE", "Diagnostic"]
            .map((c) => _buildCheckbox(c, _selectedCategories)),
        
        const Divider(height: 40),
        
        // Brand Filter
        _buildFilterSectionTitle("Brands"),
        ...["MediSteel", "TechCare", "SharpEdge", "EchoClear", "CleanTech", "SafeGuard", "3M"]
            .map((b) => _buildCheckbox(b, _selectedBrands)),

        const Divider(height: 40),

        // Price Filter
        _buildFilterSectionTitle("Price Range"),
        RangeSlider(
          values: _currentPriceRange,
          min: 0,
          max: 5000,
          activeColor: AppColors.primaryBlue,
          inactiveColor: Colors.grey[200],
          onChanged: (values) => setState(() {}), // Just update UI for demo
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$0", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Text("\$5000+", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
        ),

        const Divider(height: 40),
        
        // Rating Filter
        _buildFilterSectionTitle("Rating"),
        _buildRatingFilter(5),
        _buildRatingFilter(4),
        _buildRatingFilter(3),
      ],
    );
  }

  Widget _buildFilterSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }

  Widget _buildCheckbox(String label, Set<String> selectedSet) {
    final isSelected = selectedSet.contains(label);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onTap: () {
          setState(() {
            isSelected ? selectedSet.remove(label) : selectedSet.add(label);
          });
        },
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: isSelected ? AppColors.primaryBlue : Colors.grey.shade400),
                color: isSelected ? AppColors.primaryBlue : Colors.white,
              ),
              child: isSelected ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
            ),
            const SizedBox(width: 12),
            Text(label, style: TextStyle(fontSize: 14, color: isSelected ? AppColors.textDark : AppColors.textMuted)),
          ],
        ),
      ),
    );
  }
  
  Widget _buildRatingFilter(int stars) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(Icons.check_box_outline_blank, size: 20, color: Colors.grey.shade400),
          const SizedBox(width: 10),
          Row(
            children: List.generate(5, (index) => Icon(
              index < stars ? Icons.star : Icons.star_border,
              size: 16,
              color: Colors.amber,
            )),
          ),
          const SizedBox(width: 8),
          const Text("& Up", style: TextStyle(fontSize: 12, color: AppColors.textMuted))
        ],
      ),
    );
  }

  // Mobile Bottom Sheet
  void _openMobileFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (_, controller) => Column(
          children: [
            const SizedBox(height: 12),
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
            Expanded(
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.all(24),
                children: [
                  _buildFilterContent(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("APPLY FILTERS", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// --- RICH PRODUCT CARD ---
class _RichProductCard extends StatefulWidget {
  final Map<String, dynamic> product;
  final bool isGrid;

  const _RichProductCard({required this.product, required this.isGrid});

  @override
  State<_RichProductCard> createState() => _RichProductCardState();
}

class _RichProductCardState extends State<_RichProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final bool hasDiscount = p['isSale'];
    
    // --- GRID VIEW ---
    if (widget.isGrid) {
      return MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          // Lift effect on hover
          transform: Matrix4.identity()..translate(0.0, _isHovered ? -8.0 : 0.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryBlue.withOpacity(_isHovered ? 0.15 : 0.05),
                blurRadius: _isHovered ? 25 : 10,
                offset: Offset(0, _isHovered ? 10 : 5),
              ),
            ],
            border: Border.all(
              color: _isHovered ? AppColors.primaryBlue.withOpacity(0.5) : Colors.transparent,
              width: 1.5
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. IMAGE AREA
              Expanded(
                flex: 6,
                child: Stack(
                  children: [
                    // Background
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFF0F4F8), // Very light cool grey
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                      ),
                      width: double.infinity,
                      child: Center(
                        child: Icon(p['imageIcon'], size: 70, color: AppColors.primaryBlue.withOpacity(0.6)),
                      ),
                    ),
                    
                    // Badges (Top Left)
                    Positioned(
                      top: 12, left: 12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (p['badge'] != null)
                            Container(
                              margin: const EdgeInsets.only(bottom: 4),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.darkBlue,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                p['badge'],
                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          if (hasDiscount)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                "SALE",
                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                        ],
                      ),
                    ),
                    
                    // Wishlist Button (Top Right)
                    Positioned(
                      top: 8, right: 8,
                      child: IconButton(
                        icon: const Icon(Icons.favorite_border, size: 20, color: AppColors.textMuted),
                        onPressed: () {},
                        hoverColor: Colors.white,
                        style: IconButton.styleFrom(backgroundColor: Colors.white.withOpacity(0.8)),
                      ),
                    ),
                  ],
                ),
              ),
              
              // 2. DETAILS AREA
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Brand & Category
                      Row(
                        children: [
                          Text(p['brand'].toUpperCase(), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textMuted)),
                          const Spacer(),
                          // Star Rating
                          Icon(Icons.star, size: 14, color: Colors.amber[600]),
                          const SizedBox(width: 2),
                          Text("${p['rating']}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          Text(" (${p['reviews']})", style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      
                      // Title
                      Text(
                        p['title'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, height: 1.3, color: AppColors.textDark),
                      ),
                      
                      const Spacer(),
                      
                      // Price & Add Button
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (hasDiscount)
                                Text(
                                  "\$${p['originalPrice'].toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 12, 
                                    decoration: TextDecoration.lineThrough, 
                                    color: AppColors.textMuted
                                  ),
                                ),
                              Text(
                                "\$${p['price'].toStringAsFixed(2)}",
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.darkBlue),
                              ),
                            ],
                          ),
                          const Spacer(),
                          // Add to Cart Button
                          if (p['inStock'])
                          Material(
                            color: AppColors.primaryBlue,
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 36, height: 36,
                                alignment: Alignment.center,
                                child: const Icon(Icons.add_shopping_cart, color: Colors.white, size: 18),
                              ),
                            ),
                          )
                          else
                            const Text("Out of Stock", style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } 
    
    // --- LIST VIEW ---
    else {
      return Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            // Image
            Container(
              width: 180,
              decoration: const BoxDecoration(
                color: Color(0xFFF0F4F8),
                borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
              ),
              child: Stack(
                children: [
                  Center(child: Icon(p['imageIcon'], size: 60, color: AppColors.primaryBlue.withOpacity(0.6))),
                  if (p['badge'] != null)
                    Positioned(
                      top: 10, left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: AppColors.darkBlue, borderRadius: BorderRadius.circular(4)),
                        child: Text(p['badge'], style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                ],
              ),
            ),
            // Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${p['brand']} • ${p['category']}", style: const TextStyle(fontSize: 12, color: AppColors.textMuted, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Icon(Icons.star, size: 16, color: Colors.amber[600]),
                            const SizedBox(width: 4),
                            Text("${p['rating']} (${p['reviews']} reviews)", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(p['title'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                    const SizedBox(height: 8),
                    Text(p['description'], style: const TextStyle(color: AppColors.textMuted, fontSize: 13), maxLines: 2),
                    const Spacer(),
                    Row(
                      children: [
                        Text("\$${p['price'].toStringAsFixed(2)}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.darkBlue)),
                        const SizedBox(width: 12),
                        if (hasDiscount)
                          Text("\$${p['originalPrice'].toStringAsFixed(2)}", style: const TextStyle(decoration: TextDecoration.lineThrough, color: AppColors.textMuted)),
                        const Spacer(),
                        ElevatedButton.icon(
                          onPressed: p['inStock'] ? () {} : null,
                          icon: const Icon(Icons.add_shopping_cart, size: 16),
                          label: Text(p['inStock'] ? "Add to Cart" : "No Stock"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}