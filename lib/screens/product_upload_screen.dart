// lib/screens/product_upload_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class ProductUploadScreen extends StatefulWidget {
  const ProductUploadScreen({super.key});

  @override
  State<ProductUploadScreen> createState() => _ProductUploadScreenState();
}

class _ProductUploadScreenState extends State<ProductUploadScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // --- CONTROLLERS: STEP 1 (BASICS) ---
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _leadTimeController = TextEditingController();
  bool _inStock = true;

  // --- CONTROLLERS: STEP 2 (DETAILS) ---
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _warrantyController = TextEditingController();
  final TextEditingController _certInputController = TextEditingController();
  final List<String> _certifications = [];

  // --- CONTROLLERS: STEP 3 (SPECS & MEDIA) ---
  final List<Map<String, TextEditingController>> _specsControllers = [];
  final List<TextEditingController> _imageControllers = [TextEditingController()];

  // --- CONTROLLERS: STEP 4 (ADVANCED) ---
  final List<Map<String, TextEditingController>> _bulkControllers = [];
  final List<Map<String, TextEditingController>> _faqControllers = [];

  @override
  void initState() {
    super.initState();
    _addSpecRow();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // --- LOGIC HELPERS ---
  void _nextPage() {
    if (_currentStep < 3) {
      _pageController.animateToPage(
        _currentStep + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep += 1);
    } else {
      _submitProduct();
    }
  }

  void _prevPage() {
    if (_currentStep > 0) {
      _pageController.animateToPage(
        _currentStep - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep -= 1);
    }
  }

  void _addSpecRow() {
    setState(() {
      _specsControllers.add({'key': TextEditingController(), 'value': TextEditingController()});
    });
  }

  void _removeSpecRow(int index) {
    setState(() {
      _specsControllers.removeAt(index);
    });
  }

  void _addImageField() {
    setState(() {
      _imageControllers.add(TextEditingController());
    });
  }

  void _removeImageField(int index) {
    setState(() {
      _imageControllers.removeAt(index);
    });
  }

  void _addBulkTier() {
    setState(() {
      _bulkControllers.add({
        'qty': TextEditingController(),
        'price': TextEditingController(),
        'saving': TextEditingController(),
      });
    });
  }

  void _removeBulkTier(int index) {
    setState(() {
      _bulkControllers.removeAt(index);
    });
  }

  void _addFaq() {
    setState(() {
      _faqControllers.add({'q': TextEditingController(), 'a': TextEditingController()});
    });
  }

  void _removeFaq(int index) {
    setState(() {
      _faqControllers.removeAt(index);
    });
  }

  void _submitProduct() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product Uploaded Successfully!'),
          backgroundColor: AppColors.primaryGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
      // Navigate to Products Catalog after success
      context.go('/products');
    }
  }

  // --- MAIN BUILD ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Clean off-white background
      appBar: AppBar(
        title: const Text("New Inventory", style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w700, letterSpacing: -0.5)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: AppColors.textDark),
          onPressed: () => context.go('/products'),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: (_currentStep + 1) / 4,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
            minHeight: 4,
          ),
        ),
      ),
      body: Column(
        children: [
          // Step Indicator Header
          _buildStepIndicator(),
          
          // Main Form Content
          Expanded(
            child: Form(
              key: _formKey,
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Disable swipe to enforce validation/buttons
                children: [
                  _buildStep1_Basics(),
                  _buildStep2_Details(),
                  _buildStep3_Specs(),
                  _buildStep4_Advanced(),
                ],
              ),
            ),
          ),
          
          // Bottom Navigation Bar
          _buildBottomBar(),
        ],
      ),
    );
  }

  // --- WIDGET: STEP INDICATOR ---
  Widget _buildStepIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStepLabel("1. Basics", 0),
          _buildStepLabel("2. Details", 1),
          _buildStepLabel("3. Media", 2),
          _buildStepLabel("4. Pricing", 3),
        ],
      ),
    );
  }

  Widget _buildStepLabel(String label, int index) {
    final isActive = _currentStep == index;
    final isCompleted = _currentStep > index;
    
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: (isActive || isCompleted) ? 1.0 : 0.4,
      child: Text(
        label,
        style: TextStyle(
          fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
          color: isActive ? AppColors.primaryBlue : AppColors.textDark,
          fontSize: 13,
        ),
      ),
    );
  }

  // --- WIDGET: BOTTOM BAR ---
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5))
        ],
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            TextButton.icon(
              onPressed: _prevPage,
              icon: const Icon(Icons.arrow_back, size: 18),
              label: const Text("Back"),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textMuted,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
            ),
          const Spacer(),
          ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              foregroundColor: Colors.white,
              elevation: 4,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Row(
              children: [
                Text(_currentStep == 3 ? "PUBLISH NOW" : "CONTINUE", style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                if (_currentStep != 3) ...[
                   const SizedBox(width: 8),
                   const Icon(Icons.arrow_forward, size: 18)
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // PAGES (STEPS)
  // ===========================================================================

  // --- STEP 1: BASICS ---
  Widget _buildStep1_Basics() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Core Information", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 8),
          const Text("Let's start with the basic identification details.", style: TextStyle(color: AppColors.textMuted)),
          const SizedBox(height: 32),
          
          _buildInputLabel("Product Name"),
          _buildStyledTextField(controller: _nameController, hint: "e.g. Surgical Forceps Pro"),
          
          const SizedBox(height: 20),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputLabel("Brand"),
                    _buildStyledTextField(controller: _brandController, hint: "e.g. Spectrum", icon: Icons.business),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputLabel("SKU Code"),
                    _buildStyledTextField(controller: _skuController, hint: "PROD-001", icon: Icons.qr_code),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputLabel("Price (USD)"),
                    _buildStyledTextField(controller: _priceController, hint: "0.00", icon: Icons.attach_money, isNumber: true),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputLabel("Lead Time"),
                    _buildStyledTextField(controller: _leadTimeController, hint: "2-3 Days", icon: Icons.schedule),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: _inStock ? AppColors.primaryGreen.withOpacity(0.1) : Colors.red.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _inStock ? AppColors.primaryGreen.withOpacity(0.3) : Colors.red.withOpacity(0.3)),
            ),
            child: SwitchListTile(
              title: Text("Stock Status", style: TextStyle(fontWeight: FontWeight.bold, color: _inStock ? AppColors.primaryGreen : Colors.red)),
              subtitle: Text(_inStock ? "Item is currently in stock" : "Item is out of stock", style: const TextStyle(fontSize: 12)),
              value: _inStock,
              activeColor: AppColors.primaryGreen,
              contentPadding: EdgeInsets.zero,
              onChanged: (val) => setState(() => _inStock = val),
            ),
          ),
        ],
      ),
    );
  }

  // --- STEP 2: DETAILS ---
  Widget _buildStep2_Details() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Marketing Details", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 8),
          const Text("Provide a compelling description and certifications.", style: TextStyle(color: AppColors.textMuted)),
          const SizedBox(height: 32),

          _buildInputLabel("Description"),
          TextFormField(
            controller: _descriptionController,
            maxLines: 6,
            decoration: InputDecoration(
              hintText: "Describe key features, medical applications, and benefits...",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2)),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
          
          const SizedBox(height: 20),
          _buildInputLabel("Warranty Information"),
          _buildStyledTextField(controller: _warrantyController, hint: "e.g. 2 Years Manufacturer Warranty", icon: Icons.verified_user_outlined),

          const SizedBox(height: 24),
          const Divider(height: 40),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInputLabel("Certifications"),
              // Mini Add Button
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _buildStyledTextField(controller: _certInputController, hint: "Add Tag (e.g. ISO 9001)")),
              const SizedBox(width: 10),
              IconButton.filled(
                onPressed: () {
                   if (_certInputController.text.isNotEmpty) {
                    setState(() {
                      _certifications.add(_certInputController.text);
                      _certInputController.clear();
                    });
                  }
                },
                icon: const Icon(Icons.add),
                style: IconButton.styleFrom(backgroundColor: AppColors.darkBlue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              )
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _certifications.map((cert) => Chip(
              label: Text(cert, style: const TextStyle(color: AppColors.darkBlue, fontWeight: FontWeight.w600)),
              backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              deleteIcon: const Icon(Icons.close, size: 16, color: AppColors.darkBlue),
              onDeleted: () => setState(() => _certifications.remove(cert)),
            )).toList(),
          )
        ],
      ),
    );
  }

  // --- STEP 3: SPECS & MEDIA ---
  Widget _buildStep3_Specs() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGES SECTION
          const Text("Product Imagery", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 8),
          const Text("Add valid image URLs to showcase the product.", style: TextStyle(color: AppColors.textMuted)),
          const SizedBox(height: 24),
          
          ..._imageControllers.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                children: [
                  Container(
                    height: 50, width: 50,
                    decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.image_outlined, color: Colors.grey),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: _buildStyledTextField(controller: entry.value, hint: "Paste Image URL here...")),
                  if (_imageControllers.length > 1)
                    IconButton(icon: const Icon(Icons.remove_circle_outline, color: Colors.red), onPressed: () => _removeImageField(entry.key)),
                ],
              ),
            );
          }),
          
          TextButton.icon(
            onPressed: _addImageField,
            icon: const Icon(Icons.add_a_photo_outlined),
            label: const Text("Add Another Image URL"),
          ),

          const Divider(height: 40),

          // SPECS SECTION
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Tech Specs", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark)),
              TextButton.icon(onPressed: _addSpecRow, icon: const Icon(Icons.add), label: const Text("Add Row"))
            ],
          ),
          const SizedBox(height: 12),
          
          Container(
            // --- FIX: borderRadius moved out of Border.all ---
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Column(
              children: _specsControllers.asMap().entries.map((entry) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
                  ),
                  child: Row(
                    children: [
                      Expanded(child: _buildSmallTableInput(entry.value['key']!, "Attribute")),
                      const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text(":", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
                      Expanded(child: _buildSmallTableInput(entry.value['value']!, "Value")),
                      if (_specsControllers.length > 1)
                        IconButton(icon: const Icon(Icons.close, size: 18, color: Colors.red), onPressed: () => _removeSpecRow(entry.key))
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // --- STEP 4: PRICING & FAQ ---
  Widget _buildStep4_Advanced() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // BULK PRICING
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Bulk Pricing", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark)),
              TextButton.icon(onPressed: _addBulkTier, icon: const Icon(Icons.add_chart_outlined), label: const Text("Add Tier"))
            ],
          ),
          const Text("Define discounts for hospitals buying in volume.", style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
          const SizedBox(height: 16),

          ..._bulkControllers.asMap().entries.map((entry) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 4, offset: const Offset(0, 2))],
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Expanded(child: _buildLabeledSmallInput("Qty Range", entry.value['qty']!)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildLabeledSmallInput("Unit Price", entry.value['price']!)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildLabeledSmallInput("Savings %", entry.value['saving']!)),
                  IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () => _removeBulkTier(entry.key))
                ],
              ),
            );
          }),

          const Divider(height: 40),

          // FAQS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("FAQs", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark)),
              TextButton.icon(onPressed: _addFaq, icon: const Icon(Icons.quiz_outlined), label: const Text("Add Q&A"))
            ],
          ),
          
          ..._faqControllers.asMap().entries.map((entry) {
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(children: [
                      const Icon(Icons.help_outline, size: 18, color: AppColors.primaryBlue),
                      const SizedBox(width: 8),
                      const Expanded(child: Text("Question", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                      InkWell(onTap: () => _removeFaq(entry.key), child: const Text("Remove", style: TextStyle(color: Colors.red, fontSize: 11)))
                    ]),
                    const SizedBox(height: 4),
                    _buildSmallTableInput(entry.value['q']!, "Enter question here..."),
                    const SizedBox(height: 12),
                    Row(children: [
                      const Icon(Icons.chat_bubble_outline, size: 18, color: AppColors.primaryGreen),
                      const SizedBox(width: 8),
                      const Expanded(child: Text("Answer", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                    ]),
                    const SizedBox(height: 4),
                    _buildSmallTableInput(entry.value['a']!, "Enter detailed answer..."),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // ===========================================================================
  // WIDGET HELPERS
  // ===========================================================================

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 2),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textDark)),
    );
  }

  Widget _buildStyledTextField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    bool isNumber = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        prefixIcon: icon != null ? Icon(icon, color: AppColors.textMuted, size: 20) : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2)),
      ),
    );
  }

  Widget _buildSmallTableInput(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        isDense: true,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      ),
    );
  }

  Widget _buildLabeledSmallInput(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: const EdgeInsets.all(10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}