import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class MedicalProductDetailScreen extends StatefulWidget {
  final String productId;

  const MedicalProductDetailScreen({super.key, required this.productId});

  @override
  State<MedicalProductDetailScreen> createState() =>
      _MedicalProductDetailScreenState();
}

class _MedicalProductDetailScreenState
    extends State<MedicalProductDetailScreen> {
  late Map<String, dynamic> _product;
  int _currentImageIndex = 0;
  bool _isFavorite = false;
  int _selectedQuantity = 1;

  @override
  void initState() {
    super.initState();
    _loadProductData();
  }

  void _loadProductData() {
    _product = {
      'id': widget.productId,
      'name': 'Titanium Surgical Hemostat Set (Pro Series)',
      'brand': 'Spectrum Surgical',
      'sku': 'SURG-X99-${widget.productId}',
      'price': 450.00,
      'currency': 'USD',
      'rating': 4.9,
      'reviewCount': 124,
      'inStock': true,
      'leadTime': '2-3 Business Days',
      'warranty': 'Lifetime Structural Warranty',
      'description':
          'Precision-engineered for high-stakes surgical environments. '
          'Our Pro Series Hemostats are forged from aerospace-grade titanium, '
          'offering a lightweight yet durable solution for vascular control. '
          'Features a non-reflective matte finish to reduce glare under operating lights.',
      'images': [
        'https://placehold.co/600x400/png?text=Product+Front',
        'https://placehold.co/600x400/png?text=Detail+View',
        'https://placehold.co/600x400/png?text=Packaging',
      ],
      'specs': {
        'Material': 'Medical Grade Titanium (Ti-6Al-4V)',
        'Length': '16 cm (6.25 inches)',
        'Jaw Type': 'Serrated, Curved',
        'Sterilization': 'Autoclave Compatible (134°C)',
        'Weight': '45g',
        'Compliance': 'ISO 13485, FDA Class I',
      },
      'certifications': ['FDA Approved', 'CE Marked', 'ISO Certified'],
      // NEW: Bulk Pricing Data
      'bulkPricing': [
        {'qty': '1-9', 'price': 450.00, 'saving': '0%'},
        {'qty': '10-49', 'price': 425.00, 'saving': '5%'},
        {'qty': '50+', 'price': 400.00, 'saving': '11%'},
      ],
      'documents': [
        {'title': 'User Manual', 'size': '1.2 MB'},
        {'title': 'Sterilization Guide', 'size': '0.8 MB'},
        {'title': 'Warranty Certificate', 'size': '0.5 MB'},
      ],
      // NEW: Reviews Data
      'reviews': [
        {
          'user': 'Dr. Sarah M.',
          'role': 'Chief of Surgery, Nairobi Hospital',
          'rating': 5.0,
          'date': 'Oct 24, 2025',
          'comment': 'Excellent balance and grip. The titanium build makes a huge difference during long procedures.'
        },
        {
          'user': 'James K.',
          'role': 'Procurement Officer, MedLife',
          'rating': 4.5,
          'date': 'Sep 12, 2025',
          'comment': 'Great quality instruments. Delivery was slightly delayed but customer support was helpful.'
        },
      ],
      // NEW: FAQ Data
      'faqs': [
        {
          'question': 'Is this instrument autoclavable?',
          'answer': 'Yes, it is fully compatible with standard autoclave cycles at 134°C for 18 minutes.'
        },
        {
          'question': 'Do you offer laser marking services?',
          'answer': 'Yes, we can laser mark your hospital/clinic name on the handle for inventory tracking upon request.'
        },
      ],
      'relatedProducts': [
        {'name': 'Scalpel Handle #3', 'price': 25.00},
        {'name': 'Surgical Forceps', 'price': 35.50},
        {'name': 'Retractor Set', 'price': 120.00},
      ]
    };
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                _buildSliverAppBar(context),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 120.0 : 20.0,
                      vertical: 30.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBreadCrumbs(),
                        const SizedBox(height: 20),
                        
                        // Main Two-Column Layout (Desktop) or Stack (Mobile)
                        if (isDesktop)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left: Images + Video + Reviews
                              Expanded(flex: 3, child: _buildLeftMainColumn()),
                              const SizedBox(width: 50),
                              // Right: Info + Action Card
                              Expanded(flex: 2, child: _buildRightStickyColumn()),
                            ],
                          )
                        else ...[
                          _buildHeaderSection(),
                          const SizedBox(height: 20),
                          _buildGallerySection(),
                          const SizedBox(height: 30),
                          _buildBulkPricingTable(),
                          const SizedBox(height: 30),
                          _buildDescriptionSection(),
                          const SizedBox(height: 30),
                          _buildVideoDemoSection(), 
                          const SizedBox(height: 30),
                          _buildSpecsSection(),
                          const SizedBox(height: 30),
                          _buildRightStickyColumn(), // Info Card
                          const SizedBox(height: 30),
                          _buildReviewsSection(),
                          const SizedBox(height: 30),
                          _buildFAQSection(),
                        ],

                        const SizedBox(height: 60),
                        _buildRelatedProducts(),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildStickyBottomBar(context),
    );
  }

  // --- COMPONENT BUILDERS ---

  Widget _buildLeftMainColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGallerySection(),
        const SizedBox(height: 40),
        _buildVideoDemoSection(), // NEW
        const SizedBox(height: 40),
        _buildDescriptionSection(),
        const SizedBox(height: 40),
        _buildSpecsSection(),
        const SizedBox(height: 40),
        _buildReviewsSection(), // NEW
        const SizedBox(height: 40),
        _buildFAQSection(), // NEW
      ],
    );
  }

  Widget _buildRightStickyColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // On desktop, header is on the right side
        if (MediaQuery.of(context).size.width > 900) _buildHeaderSection(),
        const SizedBox(height: 20),
        
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 8))
            ],
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBulkPricingTable(), // NEW: Pricing tiers
              const Divider(height: 40),
              const Text("Documentation",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              ...(_product['documents'] as List).map((doc) => _buildDocTile(doc)),
              const SizedBox(height: 20),
              _buildTrustBadge(Icons.local_shipping_outlined, "Fast Delivery", "Ships in ${_product['leadTime']}"),
              const SizedBox(height: 12),
              _buildTrustBadge(Icons.verified_outlined, "Warranty", _product['warranty']),
            ],
          ),
        ),
      ],
    );
  }

  // --- SECTION WIDGETS ---

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
        onPressed: () => context.canPop() ? context.pop() : context.go('/products'),
      ),
      title: Text(
        _product['name'],
        style: const TextStyle(
            color: AppColors.textDark,
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: _isFavorite ? Colors.red : AppColors.textMuted,
          ),
          onPressed: () => setState(() => _isFavorite = !_isFavorite),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildBreadCrumbs() {
    return Row(
      children: [
        const Text("Products", style: TextStyle(color: AppColors.textMuted)),
        const SizedBox(width: 8),
        const Icon(Icons.chevron_right, size: 16, color: AppColors.textMuted),
        const SizedBox(width: 8),
        const Text("Surgical", style: TextStyle(color: AppColors.textMuted)),
        const SizedBox(width: 8),
        const Icon(Icons.chevron_right, size: 16, color: AppColors.textMuted),
        const SizedBox(width: 8),
        Text("Hemostats", style: TextStyle(color: AppColors.primaryBlue.withOpacity(0.8), fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            _product['brand'].toUpperCase(),
            style: const TextStyle(
                color: AppColors.primaryBlue,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _product['name'],
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Row(
              children: List.generate(5, (index) => Icon(
                index < (_product['rating'] as double).round() ? Icons.star : Icons.star_border,
                color: Colors.amber, size: 18
              )),
            ),
            const SizedBox(width: 8),
            Text(
              "${_product['rating']} (${_product['reviewCount']} Reviews)",
              style: const TextStyle(
                  color: AppColors.textDark, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Text("SKU: ${_product['sku']}",
                style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildGallerySection() {
    return Container(
      height: 450,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Stack(
        children: [
          PageView.builder(
            itemCount: (_product['images'] as List).length,
            onPageChanged: (index) => setState(() => _currentImageIndex = index),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(40.0),
                child: Image.network(
                  _product['images'][index],
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                (_product['images'] as List).length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentImageIndex == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentImageIndex == index
                        ? AppColors.primaryGreen
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulkPricingTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Volume Pricing", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        Table(
          border: TableBorder.all(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey.shade50),
              children: const [
                Padding(padding: EdgeInsets.all(8), child: Text("Qty", style: TextStyle(fontWeight: FontWeight.bold))),
                Padding(padding: EdgeInsets.all(8), child: Text("Price", style: TextStyle(fontWeight: FontWeight.bold))),
                Padding(padding: EdgeInsets.all(8), child: Text("Savings", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryGreen))),
              ]
            ),
            ...(_product['bulkPricing'] as List).map((tier) => TableRow(
              children: [
                Padding(padding: const EdgeInsets.all(8), child: Text(tier['qty'])),
                Padding(padding: const EdgeInsets.all(8), child: Text("\$${tier['price']}")),
                Padding(padding: const EdgeInsets.all(8), child: Text(tier['saving'], style: const TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold))),
              ]
            )),
          ],
        ),
      ],
    );
  }

  Widget _buildVideoDemoSection() {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
           image: NetworkImage("https://placehold.co/800x400/111/444?text=Video+Thumbnail"),
           fit: BoxFit.cover,
           opacity: 0.5
        )
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2)
          ),
          child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 48),
        ),
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Product Overview"),
        Text(
          _product['description'],
          style: const TextStyle(fontSize: 16, height: 1.8, color: AppColors.textDark),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: (_product['certifications'] as List).map<Widget>((cert) {
            return Chip(
              avatar: const Icon(Icons.verified, size: 16, color: AppColors.primaryGreen),
              label: Text(cert),
              backgroundColor: AppColors.primaryGreen.withOpacity(0.08),
              side: BorderSide.none,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSpecsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Technical Specifications"),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: (_product['specs'] as Map<String, dynamic>).entries.map((entry) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text(entry.key, style: const TextStyle(color: AppColors.textMuted))),
                    Expanded(flex: 3, child: Text(entry.value, style: const TextStyle(fontWeight: FontWeight.w500))),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle("Verified Reviews"),
            TextButton(onPressed: (){}, child: const Text("Write a Review")),
          ],
        ),
        ...(_product['reviews'] as List).map((review) => Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                    child: Text(review['user'][0], style: const TextStyle(color: AppColors.primaryBlue)),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(review['user'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(review['role'], style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(4)),
                    child: Row(
                      children: [
                        Text(review['rating'].toString(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                        const Icon(Icons.star, size: 12, color: Colors.green),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Text(review['comment'], style: const TextStyle(color: AppColors.textDark)),
              const SizedBox(height: 8),
              Text(review['date'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Questions & Answers"),
        ...(_product['faqs'] as List).map((faq) => ExpansionTile(
          title: Text(faq['question'], style: const TextStyle(fontWeight: FontWeight.w600)),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(faq['answer'], style: const TextStyle(color: AppColors.textMuted)),
            )
          ],
        )),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark)),
    );
  }

  Widget _buildDocTile(Map<String, dynamic> doc) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
        child: const Icon(Icons.picture_as_pdf, color: Colors.red, size: 20),
      ),
      title: Text(doc['title'], style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
      subtitle: Text(doc['size'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
      trailing: const Icon(Icons.download_rounded, color: AppColors.primaryBlue, size: 20),
      onTap: () {},
    );
  }

  Widget _buildTrustBadge(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryGreen, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildRelatedProducts() {
    final List related = _product['relatedProducts'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Related Instruments"),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: related.length,
            separatorBuilder: (c, i) => const SizedBox(width: 15),
            itemBuilder: (context, index) {
              final item = related[index];
              return Container(
                width: 220,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50, width: 50,
                      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.medical_services_outlined, color: AppColors.primaryBlue),
                    ),
                    const Spacer(),
                    Text(item['name'], maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("\$${item['price'].toStringAsFixed(2)}", style: const TextStyle(color: AppColors.textMuted)),
                        const Icon(Icons.add_circle_outline, color: AppColors.primaryGreen, size: 20),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStickyBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Total (excl. shipping)", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                Text(
                  "\$${_product['price'].toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),
              ],
            ),
            const Spacer(),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                side: const BorderSide(color: AppColors.primaryBlue),
              ),
              child: const Text("Chat with Sales"),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to Quote Request')));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                elevation: 0,
              ),
              child: const Text("ADD TO QUOTE", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}