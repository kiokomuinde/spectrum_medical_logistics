// ==============================================================================
// FILE: lib/screens/product_catalog_screen.dart
// DESCRIPTION: Enterprise-grade Product Catalog with filtering, sorting,
//              responsive layout, and rich data visualization.
// ==============================================================================

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/responsive_navbar.dart';
import '../theme/app_theme.dart';

// ==============================================================================
// SECTION 1: DATA MODELS & CONSTANTS
// ==============================================================================

class Product {
  final String id;
  final String title;
  final String sku;
  final double price;
  final double? originalPrice;
  final String category;
  final String brand;
  final double rating;
  final int reviewCount;
  final bool inStock;
  final bool isNew;
  final String? badge; // e.g., "BEST SELLER", "FDA APPROVED"
  final String description;
  final List<String> tags;
  final IconData iconData;

  const Product({
    required this.id,
    required this.title,
    required this.sku,
    required this.price,
    this.originalPrice,
    required this.category,
    required this.brand,
    required this.rating,
    required this.reviewCount,
    required this.inStock,
    this.isNew = false,
    this.badge,
    required this.description,
    required this.tags,
    required this.iconData,
  });

  bool get onSale => originalPrice != null && originalPrice! > price;
}

// --- MOCK DATABASE GENERATOR (Extensive Data) ---
final List<Product> _allProducts = [
  // --- SURGICAL TOOLS ---
  const Product(
    id: 'surg-001',
    title: 'Titanium Surgical Hemostat - Curved 5"',
    sku: 'SRG-8821-C',
    price: 145.00,
    originalPrice: 180.00,
    category: 'Surgical Tools',
    brand: 'MediSteel',
    rating: 4.8,
    reviewCount: 124,
    inStock: true,
    badge: 'BEST SELLER',
    description: 'Premium grade titanium hemostat for precision vascular control. Autoclavable and corrosion resistant.',
    tags: ['surgical', 'titanium', 'hemostat'],
    iconData: Icons.cut,
  ),
  const Product(
    id: 'surg-002',
    title: 'Iris Scissors - Straight 4.5"',
    sku: 'SRG-SCIS-02',
    price: 32.50,
    category: 'Surgical Tools',
    brand: 'MediSteel',
    rating: 4.6,
    reviewCount: 45,
    inStock: true,
    description: 'Fine point surgical scissors designed for ophthalmic procedures and delicate tissue removal.',
    tags: ['surgical', 'scissors', 'ophthalmic'],
    iconData: Icons.content_cut,
  ),
  const Product(
    id: 'surg-003',
    title: 'Scalpel Handle #3 (Stainless Steel)',
    sku: 'SRG-HNDL-03',
    price: 18.00,
    category: 'Surgical Tools',
    brand: 'SharpEdge',
    rating: 4.9,
    reviewCount: 210,
    inStock: true,
    badge: 'ESSENTIAL',
    description: 'Standard #3 scalpel handle, compatible with blades #10, #11, #12, and #15.',
    tags: ['surgical', 'scalpel', 'stainless'],
    iconData: Icons.edit_attributes,
  ),
  const Product(
    id: 'surg-004',
    title: 'Needle Holder - Mayo-Hegar 6"',
    sku: 'SRG-NDL-04',
    price: 55.00,
    originalPrice: 65.00,
    category: 'Surgical Tools',
    brand: 'MediSteel',
    rating: 4.7,
    reviewCount: 88,
    inStock: true,
    description: 'Tungsten carbide inserts for superior grip and longevity. Ratcheted finger rings.',
    tags: ['surgical', 'suturing', 'needle holder'],
    iconData: Icons.medical_services,
  ),
  const Product(
    id: 'surg-005',
    title: 'Retractor - Weitlaner Self-Retaining',
    sku: 'SRG-RTR-05',
    price: 210.00,
    category: 'Surgical Tools',
    brand: 'ProSurg',
    rating: 5.0,
    reviewCount: 12,
    inStock: false,
    badge: 'OUT OF STOCK',
    description: 'Self-retaining retractor with 3x4 prongs, blunt. Ideal for orthopedic use.',
    tags: ['surgical', 'retractor', 'ortho'],
    iconData: Icons.grid_goldenratio,
  ),

  // --- DIAGNOSTIC EQUIPMENT ---
  const Product(
    id: 'diag-001',
    title: 'Digital Vital Signs Monitor (Portable)',
    sku: 'EQP-9910-X',
    price: 1250.00,
    category: 'Diagnostic',
    brand: 'TechCare',
    rating: 5.0,
    reviewCount: 42,
    inStock: true,
    badge: 'FDA APPROVED',
    description: 'Compact multi-parameter monitor (NIBP, SpO2, Temp) for ambulatory and bedside use.',
    tags: ['diagnostic', 'monitor', 'electronic'],
    iconData: Icons.monitor_heart,
  ),
  const Product(
    id: 'diag-002',
    title: 'Littmann Cardiology IV Stethoscope',
    sku: 'DG-LIT-04',
    price: 189.00,
    originalPrice: 210.00,
    category: 'Diagnostic',
    brand: '3M',
    rating: 4.9,
    reviewCount: 850,
    inStock: true,
    isNew: true,
    description: 'Outstanding acoustic performance with better audibility of high-frequency sounds.',
    tags: ['diagnostic', 'stethoscope', 'cardiology'],
    iconData: Icons.headphones,
  ),
  const Product(
    id: 'diag-003',
    title: 'Welch Allyn Diagnostic Set (Otoscope/Ophthalmoscope)',
    sku: 'DG-WA-SET',
    price: 650.00,
    category: 'Diagnostic',
    brand: 'Welch Allyn',
    rating: 4.8,
    reviewCount: 115,
    inStock: true,
    description: 'PanOptic Ophthalmoscope and MacroView Otoscope with rechargeable lithium-ion handle.',
    tags: ['diagnostic', 'ent', 'eyes'],
    iconData: Icons.visibility,
  ),
  const Product(
    id: 'diag-004',
    title: 'Non-Contact Infrared Thermometer',
    sku: 'DG-THERM-IR',
    price: 45.00,
    originalPrice: 60.00,
    category: 'Diagnostic',
    brand: 'TechCare',
    rating: 4.4,
    reviewCount: 2200,
    inStock: true,
    description: 'Hospital grade non-contact thermometer with 1-second response time.',
    tags: ['diagnostic', 'thermometer', 'fever'],
    iconData: Icons.thermostat,
  ),
  const Product(
    id: 'diag-005',
    title: 'Pulse Oximeter Finger Unit',
    sku: 'DG-OXI-05',
    price: 25.00,
    category: 'Diagnostic',
    brand: 'TechCare',
    rating: 4.2,
    reviewCount: 500,
    inStock: true,
    description: 'Reliable SpO2 and pulse rate measurement. OLED display with waveform.',
    tags: ['diagnostic', 'oxygen', 'lungs'],
    iconData: Icons.bloodtype,
  ),

  // --- STERILIZATION ---
  const Product(
    id: 'ster-001',
    title: 'Autoclave Sterilizer Class B (23L)',
    sku: 'STR-3301-A',
    price: 3499.00,
    category: 'Sterilization',
    brand: 'CleanTech',
    rating: 4.9,
    reviewCount: 15,
    inStock: false,
    badge: 'ISO 13485',
    description: 'Advanced vacuum steam sterilizer for dental and medical clinics. Digital cycle logging.',
    tags: ['sterilization', 'autoclave', 'equipment'],
    iconData: Icons.cleaning_services,
  ),
  const Product(
    id: 'ster-002',
    title: 'Ultrasonic Cleaner (10L Capacity)',
    sku: 'STR-ULT-10',
    price: 450.00,
    category: 'Sterilization',
    brand: 'CleanTech',
    rating: 4.6,
    reviewCount: 30,
    inStock: true,
    description: 'Heated ultrasonic cleaner for deep cleaning of surgical instruments before autoclaving.',
    tags: ['sterilization', 'cleaning', 'lab'],
    iconData: Icons.waves,
  ),

  // --- CONSUMABLES / PPE ---
  const Product(
    id: 'ppe-001',
    title: 'N95 Medical Grade Respirator (20/Box)',
    sku: 'PPE-9901-M',
    price: 24.00,
    category: 'PPE',
    brand: 'SafeGuard',
    rating: 4.6,
    reviewCount: 1500,
    inStock: true,
    badge: 'NIOSH',
    description: 'Fluid resistant particulate respirator. NIOSH approved for medical use.',
    tags: ['ppe', 'masks', 'safety'],
    iconData: Icons.masks,
  ),
  const Product(
    id: 'ppe-002',
    title: 'Nitrile Exam Gloves - Blue (Box 100)',
    sku: 'PPE-GLV-N',
    price: 18.50,
    category: 'PPE',
    brand: 'SafeGuard',
    rating: 4.7,
    reviewCount: 3000,
    inStock: true,
    description: 'Chemo-rated powder-free nitrile gloves. Textured fingertips.',
    tags: ['ppe', 'gloves', 'consumables'],
    iconData: Icons.back_hand,
  ),
  const Product(
    id: 'ppe-003',
    title: 'Surgical Gowns Level 3 (Pack of 10)',
    sku: 'PPE-GWN-L3',
    price: 85.00,
    category: 'PPE',
    brand: 'SafeGuard',
    rating: 4.5,
    reviewCount: 120,
    inStock: true,
    description: 'SMS non-woven fabric, sterile, reinforced zones for critical protection.',
    tags: ['ppe', 'gown', 'surgery'],
    iconData: Icons.accessibility,
  ),

  // --- IMAGING ---
  const Product(
    id: 'img-001',
    title: 'Portable Ultrasound Scanner - Wireless',
    sku: 'IMG-US-WIFI',
    price: 4200.00,
    originalPrice: 4800.00,
    category: 'Imaging',
    brand: 'EchoClear',
    rating: 4.3,
    reviewCount: 22,
    inStock: true,
    badge: 'TECH PICK',
    description: 'Handheld wireless ultrasound probe connecting iOS/Android. Linear & Convex.',
    tags: ['imaging', 'ultrasound', 'mobile'],
    iconData: Icons.wifi_tethering,
  ),
  const Product(
    id: 'img-002',
    title: 'Diagnostic Ultrasound Gel - 5L',
    sku: 'IMG-GEL-5L',
    price: 28.50,
    originalPrice: 35.00,
    category: 'Imaging',
    brand: 'EchoClear',
    rating: 4.2,
    reviewCount: 310,
    inStock: true,
    description: 'Hypoallergenic, acoustically correct viscous gel for all ultrasound procedures.',
    tags: ['imaging', 'consumables', 'gel'],
    iconData: Icons.water_drop,
  ),

  // --- FURNITURE ---
  const Product(
    id: 'fur-001',
    title: 'Hydraulic Exam Table - Adjustable',
    sku: 'FUR-TAB-HYD',
    price: 2100.00,
    category: 'Furniture',
    brand: 'Clinix',
    rating: 4.8,
    reviewCount: 18,
    inStock: true,
    description: 'Heavy duty hydraulic pump, paper roll holder, and adjustable backrest.',
    tags: ['furniture', 'clinic', 'table'],
    iconData: Icons.bed,
  ),
  const Product(
    id: 'fur-002',
    title: 'Medical Stool with Backrest',
    sku: 'FUR-STL-02',
    price: 150.00,
    category: 'Furniture',
    brand: 'Clinix',
    rating: 4.4,
    reviewCount: 65,
    inStock: true,
    description: 'Ergonomic stool with pneumatic height adjustment and 5-star base.',
    tags: ['furniture', 'seating', 'clinic'],
    iconData: Icons.chair,
  ),
];

// ==============================================================================
// SECTION 2: MAIN SCREEN WIDGET
// ==============================================================================

class ProductCatalogScreen extends StatefulWidget {
  const ProductCatalogScreen({super.key});

  @override
  State<ProductCatalogScreen> createState() => _ProductCatalogScreenState();
}

class _ProductCatalogScreenState extends State<ProductCatalogScreen> {
  // --- STATE VARIABLES ---
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  
  // Filters
  List<String> _selectedCategories = [];
  String? _selectedBrand;
  RangeValues _priceRange = const RangeValues(0, 5000);
  bool _onlyInStock = false;
  double _minRating = 0.0;
  
  // Sorting
  String _sortBy = 'featured'; // featured, priceAsc, priceDesc, rating, newest

  // Pagination (Simulated)
  int _currentPage = 1;
  final int _itemsPerPage = 12;

  // Cache for filtered results to avoid recalc on every frame
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _applyFilters();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // --- LOGIC: FILTERING & SORTING ---
  void _applyFilters() {
    List<Product> temp = List.from(_allProducts);

    // 1. Category Filter
    if (_selectedCategories.isNotEmpty) {
      temp = temp.where((p) => _selectedCategories.contains(p.category)).toList();
    }

    // 2. Brand Filter
    if (_selectedBrand != null) {
      temp = temp.where((p) => p.brand == _selectedBrand).toList();
    }

    // 3. Price Range
    temp = temp.where((p) => p.price >= _priceRange.start && p.price <= _priceRange.end).toList();

    // 4. Stock
    if (_onlyInStock) {
      temp = temp.where((p) => p.inStock).toList();
    }

    // 5. Rating
    if (_minRating > 0) {
      temp = temp.where((p) => p.rating >= _minRating).toList();
    }

    // 6. Search Query
    if (_searchController.text.isNotEmpty) {
      final q = _searchController.text.toLowerCase();
      temp = temp.where((p) {
        return p.title.toLowerCase().contains(q) || 
               p.sku.toLowerCase().contains(q) ||
               p.tags.any((t) => t.contains(q));
      }).toList();
    }

    // 7. Sorting
    switch (_sortBy) {
      case 'priceAsc':
        temp.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'priceDesc':
        temp.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'rating':
        temp.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'newest':
        temp.sort((a, b) => (a.isNew == b.isNew) ? 0 : (a.isNew ? -1 : 1));
        break;
      case 'featured':
      default:
        // Default sort (maybe by ID or random in a real app)
        break;
    }

    setState(() {
      _filteredProducts = temp;
      _currentPage = 1; // Reset to page 1 on filter change
    });
  }

  // --- LOGIC: RESET ---
  void _resetFilters() {
    setState(() {
      _selectedCategories = [];
      _selectedBrand = null;
      _priceRange = const RangeValues(0, 5000);
      _onlyInStock = false;
      _minRating = 0.0;
      _searchController.clear();
      _sortBy = 'featured';
      _applyFilters();
    });
  }

  // --- UI BUILDER ---
  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 900;
    
    // Calculate Pagination
    final int totalItems = _filteredProducts.length;
    final int totalPages = (totalItems / _itemsPerPage).ceil();
    final int startIndex = (_currentPage - 1) * _itemsPerPage;
    final int endIndex = min(startIndex + _itemsPerPage, totalItems);
    final List<Product> visibleProducts = totalItems > 0 
        ? _filteredProducts.sublist(startIndex, endIndex) 
        : [];

    return Scaffold(
      // [FIX] Replaced undefined AppColors.background with standard Color
      backgroundColor: Colors.grey[50], 
      appBar: const ResponsiveNavBar(),
      
      // Floating Action Button for Mobile Filtering
      floatingActionButton: !isDesktop 
        ? FloatingActionButton.extended(
            onPressed: () => _showMobileFilterSheet(context),
            backgroundColor: AppColors.darkBlue,
            icon: const Icon(Icons.filter_list),
            label: const Text("Filters"),
          )
        : null,

      body: Column(
        children: [
          // BREADCRUMBS & HEADER
          _buildHeader(totalItems),
          
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // DESKTOP SIDEBAR
                if (isDesktop)
                  SizedBox(
                    width: 280,
                    child: _buildSidebarFilters(),
                  ),
                
                // MAIN CONTENT AREA
                Expanded(
                  child: visibleProducts.isEmpty 
                    ? _buildEmptyState()
                    : _buildProductGrid(visibleProducts, isDesktop),
                ),
              ],
            ),
          ),
          
          // PAGINATION FOOTER
          if (totalPages > 1)
            _buildPagination(totalPages),
        ],
      ),
    );
  }

  Widget _buildHeader(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      color: Colors.white,
      child: Column(
        children: [
          // Top Row: Breadcrumbs and Search
          Row(
            children: [
              Text(
                "Home / Catalog / Medical Equipment",
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              const Spacer(),
              SizedBox(
                width: 300,
                height: 40,
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) => _applyFilters(),
                  decoration: InputDecoration(
                    hintText: "Search SKU, Name, or Brand...",
                    prefixIcon: const Icon(Icons.search, size: 20),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          // Bottom Row: Title and Sort
          Row(
            children: [
              Text(
                "All Products ($count)",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.darkBlue),
              ),
              const Spacer(),
              const Text("Sort By: ", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: _sortBy,
                underline: Container(),
                icon: const Icon(Icons.keyboard_arrow_down),
                items: const [
                  DropdownMenuItem(value: 'featured', child: Text("Featured")),
                  DropdownMenuItem(value: 'newest', child: Text("Newest Arrivals")),
                  DropdownMenuItem(value: 'priceAsc', child: Text("Price: Low to High")),
                  DropdownMenuItem(value: 'priceDesc', child: Text("Price: High to Low")),
                  DropdownMenuItem(value: 'rating', child: Text("Highest Rated")),
                ],
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _sortBy = val;
                      _applyFilters();
                    });
                  }
                },
              )
            ],
          ),
          const Divider(height: 30),
        ],
      ),
    );
  }

  // ============================================================================
  // SECTION 3: SIDEBAR FILTERS (DESKTOP)
  // ============================================================================
  Widget _buildSidebarFilters() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Colors.grey.shade200)),
      ),
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("FILTERS", style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.0)),
              TextButton(
                onPressed: _resetFilters,
                child: const Text("Reset", style: TextStyle(color: Colors.red, fontSize: 12)),
              )
            ],
          ),
          const SizedBox(height: 20),

          // Categories Group
          _buildFilterGroupTitle("CATEGORY"),
          ...['Surgical Tools', 'Diagnostic', 'Sterilization', 'PPE', 'Imaging', 'Furniture'].map((cat) {
            final isSelected = _selectedCategories.contains(cat);
            return CheckboxListTile(
              title: Text(cat, style: const TextStyle(fontSize: 14)),
              value: isSelected,
              activeColor: AppColors.primaryBlue,
              dense: true,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (val) {
                setState(() {
                  if (val == true) {
                    _selectedCategories.add(cat);
                  } else {
                    _selectedCategories.remove(cat);
                  }
                  _applyFilters();
                });
              },
            );
          }),
          
          const Divider(height: 30),

          // Brands Group
          _buildFilterGroupTitle("BRAND"),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            ),
            value: _selectedBrand,
            hint: const Text("Select Brand"),
            items: ['MediSteel', 'TechCare', '3M', 'SafeGuard', 'CleanTech', 'EchoClear', 'Clinix']
                .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                .toList(),
            onChanged: (val) {
              setState(() {
                _selectedBrand = val;
                _applyFilters();
              });
            },
          ),

          const Divider(height: 30),

          // Price Slider
          _buildFilterGroupTitle("PRICE RANGE"),
          RangeSlider(
            values: _priceRange,
            min: 0,
            max: 5000,
            divisions: 50,
            activeColor: AppColors.primaryGreen,
            inactiveColor: Colors.grey.shade200,
            labels: RangeLabels(
              "\$${_priceRange.start.round()}",
              "\$${_priceRange.end.round()}",
            ),
            onChanged: (val) {
              setState(() {
                _priceRange = val;
                _applyFilters();
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$${_priceRange.start.toStringAsFixed(0)}", style: const TextStyle(color: Colors.grey)),
              Text("\$${_priceRange.end.toStringAsFixed(0)}+", style: const TextStyle(color: Colors.grey)),
            ],
          ),

          const Divider(height: 30),

          // Rating Filter
          _buildFilterGroupTitle("MINIMUM RATING"),
          Wrap(
            spacing: 5,
            children: [4, 3, 2, 1].map((star) {
              final isSelected = _minRating == star.toDouble();
              return ChoiceChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("$star"),
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                  ],
                ),
                selected: isSelected,
                onSelected: (val) {
                  setState(() {
                    _minRating = val ? star.toDouble() : 0.0;
                    _applyFilters();
                  });
                },
              );
            }).toList(),
          ),

          const Divider(height: 30),

          // Stock Toggle
          SwitchListTile(
            title: const Text("In Stock Only", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            value: _onlyInStock,
            activeColor: AppColors.primaryGreen,
            contentPadding: EdgeInsets.zero,
            onChanged: (val) {
              setState(() {
                _onlyInStock = val;
                _applyFilters();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterGroupTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textMuted)),
    );
  }

  // ============================================================================
  // SECTION 4: PRODUCT GRID & CARDS
  // ============================================================================
  Widget _buildProductGrid(List<Product> products, bool isDesktop) {
    // Responsive Grid Count
    final width = MediaQuery.of(context).size.width;
    int crossAxisCount = 1;
    if (width > 600) crossAxisCount = 2;
    if (width > 950) crossAxisCount = 3;
    if (width > 1400) crossAxisCount = 4;

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(24),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 0.65, // Taller cards for more info
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _ProductCard(
                  product: products[index], 
                  onTap: () => _navigateToDetail(products[index].id),
                  onAddToCart: () => _simulateAddToCart(products[index]),
                );
              },
              childCount: products.length,
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToDetail(String id) {
    // GO ROUTER NAVIGATION
    context.go('/product/$id');
  }

  void _simulateAddToCart(Product p) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${p.title} added to cart."),
        backgroundColor: AppColors.primaryGreen,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(label: "UNDO", textColor: Colors.white, onPressed: () {}),
      ),
    );
  }

  // ============================================================================
  // SECTION 5: PAGINATION & EMPTY STATES
  // ============================================================================
  Widget _buildPagination(int totalPages) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: _currentPage > 1 ? () => setState(() => _currentPage--) : null,
          ),
          const SizedBox(width: 10),
          ...List.generate(totalPages, (index) {
            final pageNum = index + 1;
            final isActive = pageNum == _currentPage;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: InkWell(
                onTap: () => setState(() => _currentPage = pageNum),
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.darkBlue : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: isActive ? AppColors.darkBlue : Colors.grey.shade300),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "$pageNum",
                    style: TextStyle(
                      color: isActive ? Colors.white : AppColors.textDark,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: _currentPage < totalPages ? () => setState(() => _currentPage++) : null,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 20),
          const Text("No products found", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text("Try adjusting your filters or search terms.", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: _resetFilters,
            child: const Text("Clear All Filters"),
          )
        ],
      ),
    );
  }

  // ============================================================================
  // SECTION 6: MOBILE FILTER SHEET
  // ============================================================================
  void _showMobileFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Filter Products", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                  const Divider(),
                  // Re-using the sidebar logic but adapted for sheet
                  _buildSidebarFilters(),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBlue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text("SHOW RESULTS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ==============================================================================
// SECTION 7: SUB-WIDGETS (CARD COMPONENTS)
// ==============================================================================

class _ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const _ProductCard({
    required this.product,
    required this.onTap,
    required this.onAddToCart,
  });

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered ? (Matrix4.identity()..translate(0, -5, 0)) : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _isHovered ? AppColors.primaryBlue.withOpacity(0.5) : Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.1 : 0.05),
              blurRadius: _isHovered ? 20 : 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IMAGE AREA
                Expanded(
                  flex: 5,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        child: Center(
                          child: Icon(
                            p.iconData, 
                            size: 64, 
                            color: _isHovered ? AppColors.primaryBlue : AppColors.primaryBlue.withOpacity(0.4)
                          ),
                        ),
                      ),
                      // BADGES
                      if (p.badge != null)
                        Positioned(
                          top: 12, left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: AppColors.primaryGreen, borderRadius: BorderRadius.circular(20)),
                            child: Text(p.badge!, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      if (p.onSale)
                        Positioned(
                          top: 12, right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(4)),
                            child: const Text("SALE", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        ),
                    ],
                  ),
                ),

                // TEXT AREA
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.category.toUpperCase(),
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textMuted),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          p.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, height: 1.2),
                        ),
                        const SizedBox(height: 6),
                        // RATING
                        Row(
                          children: [
                            Icon(Icons.star, size: 14, color: Colors.amber[700]),
                            const SizedBox(width: 4),
                            Text("${p.rating}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                            Text(" (${p.reviewCount})", style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(p.brand, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                        const Spacer(),
                        const Divider(),
                        // FOOTER PRICE & CART
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "\$${p.price.toStringAsFixed(2)}",
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.darkBlue),
                                ),
                                if (p.onSale)
                                  Text(
                                    "\$${p.originalPrice!.toStringAsFixed(2)}",
                                    style: const TextStyle(fontSize: 12, decoration: TextDecoration.lineThrough, color: Colors.grey),
                                  ),
                              ],
                            ),
                            InkWell(
                              onTap: p.inStock ? widget.onAddToCart : null,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: p.inStock ? AppColors.primaryBlue.withOpacity(0.1) : Colors.grey.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.add_shopping_cart,
                                  size: 18,
                                  color: p.inStock ? AppColors.primaryBlue : Colors.grey,
                                ),
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
          ),
        ),
      ),
    );
  }
}