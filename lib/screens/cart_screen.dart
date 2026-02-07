import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Optional: for smooth animations if you have it, otherwise standard anims used
import '../theme/app_theme.dart';
import '../widgets/responsive_navbar.dart';

// --- MOCK MODEL FOR UI DEMO ---
class CartItemModel {
  final String id;
  final String title;
  final String subtitle;
  final double price;
  final String imageUrl;
  int quantity;

  CartItemModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Mock Data - In a real app, this comes from Provider/Riverpod/Bloc
  List<CartItemModel> cartItems = [
    CartItemModel(
      id: '1',
      title: 'Digital X-Ray Sensor',
      subtitle: 'High Resolution / Dental',
      price: 1250.00,
      imageUrl: 'https://via.placeholder.com/150', // Replace with real asset
      quantity: 1,
    ),
    CartItemModel(
      id: '2',
      title: 'Surgical Nitrile Gloves',
      subtitle: 'Box of 100 / Powder Free',
      price: 15.50,
      imageUrl: 'https://via.placeholder.com/150',
      quantity: 5,
    ),
    CartItemModel(
      id: '3',
      title: 'Ultrasound Gel (5L)',
      subtitle: 'Conductive / Clear',
      price: 45.00,
      imageUrl: 'https://via.placeholder.com/150',
      quantity: 2,
    ),
  ];

  double get subtotal => cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  double get vat => subtotal * 0.16; // 16% VAT Example
  double get shipping => subtotal > 500 ? 0 : 25.0; // Free shipping over 500
  double get total => subtotal + vat + shipping;

  void _increment(int index) {
    setState(() {
      cartItems[index].quantity++;
    });
  }

  void _decrement(int index) {
    setState(() {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      } else {
        _removeItem(index);
      }
    });
  }

  void _removeItem(int index) {
    CartItemModel removed = cartItems[index];
    setState(() {
      cartItems.removeAt(index);
    });
    
    // Undo SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${removed.title} removed"),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() => cartItems.insert(index, removed));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50, // Clean background
      appBar: const ResponsiveNavBar(),
      body: cartItems.isEmpty ? _buildEmptyState() : _buildCartContent(),
    );
  }

  // --- 1. EMPTY STATE ---
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.shopping_cart_outlined, size: 80, color: AppColors.primaryBlue),
          ),
          const SizedBox(height: 24),
          const Text(
            "Your Cart is Empty",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textDark),
          ),
          const SizedBox(height: 12),
          const Text(
            "Looks like you haven't added any medical supplies yet.",
            style: TextStyle(fontSize: 16, color: AppColors.textMuted),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () => context.go('/products'), // Adjust route as needed
            icon: const Icon(Icons.arrow_back, size: 18),
            label: const Text("Start Shopping"),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          )
        ],
      ),
    );
  }

  // --- 2. MAIN CONTENT (Responsive Split) ---
  Widget _buildCartContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 900;

        if (isLargeScreen) {
          // DESKTOP: Two columns
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: const EdgeInsets.all(40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: _buildItemsList()),
                  const SizedBox(width: 40),
                  Expanded(flex: 1, child: _buildOrderSummaryCard()),
                ],
              ),
            ),
          );
        } else {
          // MOBILE: Scrollable column with sticky bottom
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildItemsList(),
                      const SizedBox(height: 24),
                      _buildOrderSummaryCard(isMobile: true),
                    ],
                  ),
                ),
              ),
              _buildMobileCheckoutBar(),
            ],
          );
        }
      },
    );
  }

  // --- 3. CART ITEM LIST ---
  Widget _buildItemsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Shopping Cart",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "${cartItems.length} Items",
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cartItems.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            return _CartItemTile(
              item: cartItems[index],
              onIncrement: () => _increment(index),
              onDecrement: () => _decrement(index),
              onRemove: () => _removeItem(index),
            );
          },
        ),
      ],
    );
  }

  // --- 4. ORDER SUMMARY CARD ---
  Widget _buildOrderSummaryCard({bool isMobile = false}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Order Summary",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark),
          ),
          const SizedBox(height: 24),
          _SummaryRow(label: "Subtotal", value: subtotal),
          const SizedBox(height: 12),
          _SummaryRow(label: "VAT (16%)", value: vat),
          const SizedBox(height: 12),
          _SummaryRow(
            label: "Shipping", 
            value: shipping, 
            isFree: shipping == 0,
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.textDark)),
              Text(
                "\$${total.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.primaryGreen),
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          if (!isMobile) // Desktop shows button inside card
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 5,
                  shadowColor: AppColors.primaryGreen.withOpacity(0.4),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [AppColors.primaryGreen, AppColors.primaryBlue]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Proceed to Checkout",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            
          const SizedBox(height: 20),
          // Security Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_outline, size: 14, color: AppColors.textMuted),
              const SizedBox(width: 8),
              Text(
                "Secure Checkout Encrypted", 
                style: TextStyle(fontSize: 12, color: AppColors.textMuted.withOpacity(0.7)),
              ),
            ],
          )
        ],
      ),
    );
  }

  // --- 5. MOBILE FLOATING CHECKOUT ---
  Widget _buildMobileCheckoutBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          )
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppColors.primaryGreen, AppColors.primaryBlue]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Checkout", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                    child: Text("\$${total.toStringAsFixed(2)}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- HELPER WIDGETS ---

class _SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final bool isFree;

  const _SummaryRow({required this.label, required this.value, this.isFree = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 15)),
        isFree
            ? const Text("FREE", style: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold))
            : Text("\$${value.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
      ],
    );
  }
}

class _CartItemTile extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const _CartItemTile({
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(item.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textDark),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 18, color: AppColors.textMuted),
                      onPressed: onRemove,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    )
                  ],
                ),
                const SizedBox(height: 4),
                Text(item.subtitle, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${item.price.toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: AppColors.primaryBlue),
                    ),
                    // Quantity Stepper
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          _StepperButton(icon: Icons.remove, onTap: onDecrement),
                          SizedBox(
                            width: 30,
                            child: Text(
                              "${item.quantity}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          _StepperButton(icon: Icons.add, onTap: onIncrement),
                        ],
                      ),
                    )
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

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _StepperButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, size: 16, color: AppColors.textDark),
      ),
    );
  }
}