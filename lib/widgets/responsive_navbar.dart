// lib/widgets/responsive_navbar.dart
import 'dart:ui'; // For blur effect
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../constants/app_constants.dart';

// --- SHARED BRAND GRADIENT ---
const LinearGradient _brandGradient = LinearGradient(
  colors: [AppColors.primaryGreen, AppColors.primaryBlue],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

// --- 1. PRO SEARCH BAR ---
class _ProSearchBar extends StatefulWidget {
  final bool fullWidth; 
  const _ProSearchBar({this.fullWidth = false});

  @override
  State<_ProSearchBar> createState() => _ProSearchBarState();
}

class _ProSearchBarState extends State<_ProSearchBar> {
  bool _isPressed = false;
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _performSearch() {
    context.go('/products');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      constraints: widget.fullWidth 
          ? null 
          : const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        gradient: _brandGradient,
        borderRadius: BorderRadius.circular(13.5),
      ),
      padding: const EdgeInsets.all(1.5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _textController,
                onSubmitted: (_) => _performSearch(),
                onChanged: (text) => setState(() {}),
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark),
                decoration: InputDecoration(
                  hintText: "Search Surgical Tools...",
                  hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                  border: InputBorder.none,
                  isDense: true,
                  suffixIcon: _textController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close, color: AppColors.textMuted, size: 18),
                          onPressed: () {
                            _textController.clear();
                            setState(() {});
                          },
                        )
                      : null,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: GestureDetector(
                onTapDown: (_) => setState(() => _isPressed = true),
                onTapUp: (_) => setState(() => _isPressed = false),
                onTapCancel: () => setState(() => _isPressed = false),
                onTap: _performSearch,
                child: AnimatedScale(
                  scale: _isPressed ? 0.88 : 1.0,
                  duration: const Duration(milliseconds: 100),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: _brandGradient,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryBlue.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: const Icon(Icons.search_rounded, color: Colors.white, size: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 2. LOGO WIDGET ---
class _NavBarLogo extends StatelessWidget {
  const _NavBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/'),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => _brandGradient.createShader(bounds),
            child: Image.asset(
              'assets/images/spectrum_logo.png',
              height: 40.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => _brandGradient.createShader(bounds),
                child: Text(
                  'SPECTRUM',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              ShaderMask(
                shaderCallback: (bounds) => _brandGradient.createShader(bounds),
                child: const Text(
                  'MEDICAL LOGISTICS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- 3. NAV LINK (Desktop) ---
class _NavBarLink extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  const _NavBarLink({required this.text, required this.onPressed});

  @override
  State<_NavBarLink> createState() => _NavBarLinkState();
}

class _NavBarLinkState extends State<_NavBarLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            widget.text,
            style: TextStyle(
              color: _isHovered ? AppColors.primaryBlue : AppColors.textDark,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

// --- 4. DROPDOWN ACTION BUTTON ---
class _NavBarActionDropdown extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<PopupMenuEntry<String>> items;
  final void Function(String)? onSelected;

  const _NavBarActionDropdown({
    required this.icon,
    required this.label,
    required this.items,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: PopupMenuThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.white,
          elevation: 8,
        ),
      ),
      child: PopupMenuButton<String>(
        onSelected: onSelected,
        offset: const Offset(0, 50),
        itemBuilder: (context) => items,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: AppColors.textDark),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.expand_more, size: 18, color: AppColors.textDark),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 5. MAIN RESPONSIVE NAVBAR ---
class ResponsiveNavBar extends StatelessWidget implements PreferredSizeWidget {
  const ResponsiveNavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(90.0);

  void _showMobileMenu(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Menu",
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const Align(
          alignment: Alignment.centerRight,
          child: _MobileDrawer(),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 1200;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: preferredSize.height,
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.75),
            border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.05))),
          ),
          child: Row(
            children: [
              const _NavBarLogo(),
              const Spacer(),

              if (isDesktop) ...[
                const _ProSearchBar(),
                const SizedBox(width: 25),
                _NavBarLink(text: "Products", onPressed: () => context.go('/products')),
                _NavBarLink(text: "Solutions", onPressed: () => context.go('/solutions')),
                _NavBarLink(text: "Upload", onPressed: () => context.go('/upload')),
              ],

              const Spacer(),

              Row(
                children: [
                  if (isDesktop) ...[
                    // --- Account ---
                    _NavBarActionDropdown(
                      icon: Icons.perm_identity,
                      label: "Account",
                      items: _buildAccountItems(context),
                    ),
                    const SizedBox(width: 12),

                    // --- Help ---
                    _NavBarActionDropdown(
                      icon: Icons.help_outline,
                      label: "Help",
                      items: _buildHelpItems(),
                    ),
                    const SizedBox(width: 20),
                  ],

                  // --- Medical Cart (UPDATED) ---
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      IconButton(
                        onPressed: () => context.go('/cart'), // <--- UPDATED ACTION
                        icon: ShaderMask(
                          shaderCallback: (bounds) => _brandGradient.createShader(bounds),
                          child: const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 28),
                        ),
                        tooltip: "Medical Supply Cart",
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5, right: 5),
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      )
                    ],
                  ),

                  // --- Mobile Menu Trigger ---
                  if (!isDesktop) ...[
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(Icons.menu_rounded, color: AppColors.darkBlue, size: 30),
                      onPressed: () => _showMobileMenu(context),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Methods for Popups ---

  List<PopupMenuEntry<String>> _buildAccountItems(BuildContext context) {
    return [
      PopupMenuItem(
        enabled: false,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 8),
          child: ElevatedButton(
            onPressed: () => context.go('/sign-in'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              shadowColor: Colors.transparent,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ).copyWith(
              backgroundBuilder: (ctx, states, child) => Container(
                decoration: BoxDecoration(
                  gradient: _brandGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: child,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text("Sign In", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
      const PopupMenuDivider(),
      _buildPopupLink(Icons.person_outline, "My Account"),
      _buildPopupLink(Icons.inventory_2_outlined, "Orders"),
      _buildPopupLink(Icons.pending_actions_outlined, "Pending Orders"),
    ];
  }

  List<PopupMenuEntry<String>> _buildHelpItems() {
    return [
      const PopupMenuItem(
        enabled: false,
        child: Text("Help Center", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.textMuted)),
      ),
      _buildPopupLink(null, "Place an order"),
      _buildPopupLink(null, "Payment options"),
      _buildPopupLink(null, "Track an order"),
      _buildPopupLink(null, "Returns & Refunds"),
      
      const PopupMenuDivider(),
      
      _buildPopupLink(Icons.support_agent, "Live Chat Support", iconColor: AppColors.primaryBlue),
      _buildPopupLink(Icons.chat_bubble_outline, "WhatsApp Support", iconColor: AppColors.primaryGreen),
    ];
  }

  PopupMenuItem<String> _buildPopupLink(IconData? icon, String text, {Color? iconColor}) {
    return PopupMenuItem<String>(
      value: text,
      height: 40,
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: iconColor ?? AppColors.textDark),
            const SizedBox(width: 12),
          ],
          Text(text, style: const TextStyle(fontSize: 14, color: AppColors.textDark)),
        ],
      ),
    );
  }
}

// --- 6. MOBILE DRAWER COMPONENT ---
class _MobileDrawer extends StatelessWidget {
  const _MobileDrawer();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(-5, 0))],
        ),
        child: Column(
          children: [
            // Drawer Header
            Container(
              padding: const EdgeInsets.only(top: 50, bottom: 20, left: 24, right: 24),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
              ),
              child: Row(
                children: [
                  const Text(
                    "Menu",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.darkBlue),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: AppColors.textMuted),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
            
            // Drawer Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _ProSearchBar(fullWidth: true),
                    const SizedBox(height: 32),
                    
                    _buildMobileNavItem(context, "Products", Icons.inventory_2_outlined, () => context.go('/products')),
                    _buildMobileNavItem(context, "Solutions", Icons.lightbulb_outline, () => context.go('/solutions')),
                    _buildMobileNavItem(context, "Upload", Icons.cloud_upload_outlined, () => context.go('/upload')),
                    
                    const Divider(height: 40, color: Color(0xFFEEEEEE)),
                    
                    const Text("ACCOUNT", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textMuted, letterSpacing: 1.2)),
                    ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      leading: const Icon(Icons.perm_identity, color: AppColors.darkBlue),
                      title: const Text("My Account", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                      children: [
                        ListTile(title: const Text("Orders"), onTap: () {}),
                        ListTile(title: const Text("Pending Orders"), onTap: () {}),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ElevatedButton(
                            onPressed: () => context.go('/sign-in'),
                             style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryBlue,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 45),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text("Sign In / Sign Up"),
                          ),
                        )
                      ],
                    ),

                    ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      leading: const Icon(Icons.help_outline, color: AppColors.darkBlue),
                      title: const Text("Help Center", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                      children: [
                         ListTile(title: const Text("Track an order"), onTap: () {}),
                         ListTile(title: const Text("Returns & Refunds"), onTap: () {}),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Drawer Footer (Support Hub)
            Container(
              padding: const EdgeInsets.all(24),
              color: const Color(0xFFFAFAFA),
              child: Column(
                children: [
                  // LIVE CHAT BUTTON
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.support_agent, size: 20, color: AppColors.primaryBlue),
                    label: const Text("Live Chat Support", style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryBlue),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // WHATSAPP BUTTON
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.chat_bubble_outline, size: 20, color: AppColors.primaryGreen),
                    label: const Text("WhatsApp", style: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryGreen),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryBlue, size: 24),
            const SizedBox(width: 16),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}