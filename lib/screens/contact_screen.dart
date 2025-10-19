import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive_navbar.dart'; // Added: Navbar Import
import '../widgets/app_footer.dart';      // Added: Footer Import

// --- 1. DUMMY DATA FOR CONTACT SCREEN (KENYA FOCUS) ---

// Kenya Head Office Details
final Map<String, String> _kenyaOffice = {
  'city': 'Nairobi, Kenya (Headquarters)',
  'address': 'Kijabe Street, Medical Plaza, 5th Floor, Nairobi, Kenya',
  'phone_sales': '+254 7XX XXX XXX (Procurement Hotline)',
  'phone_support': '+254 20 22XXXX (Logistics & Technical Support)',
  'email_info': 'info@spectrum-ke.com',
  'email_regulatory': 'regulatory@spectrum-ke.com',
  'hours': 'Mon - Fri: 8:00 AM to 5:00 PM EAT',
};

// Segmented Contact Channels
final List<Map<String, dynamic>> _contactChannels = [
  {'title': 'Procurement & Sales', 'subtitle': 'Volume pricing, contracts, and new product requests.', 'icon': Icons.shopping_cart_outlined, 'color': AppColors.primaryBlue},
  {'title': 'Regulatory Compliance', 'subtitle': 'KEBS, PPB, and documentation inquiries.', 'icon': Icons.gavel, 'color': AppColors.darkBlue},
  {'title': 'Logistics & Tracking', 'subtitle': 'Inquire about an active order shipment within Kenya.', 'icon': Icons.local_shipping_outlined, 'color': AppColors.primaryGreen},
  {'title': 'Technical Support', 'subtitle': 'Support for installation, use, and training on consumables.', 'icon': Icons.devices_other, 'color': AppColors.primaryBlue},
];


// --- 2. MAIN SCREEN WIDGET ---
class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 1000;
    
    return Scaffold(
      // 1. Navbar
      appBar: const ResponsiveNavBar(),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 2. Hero Section (Kenya Focused)
            _buildHero(context, isDesktop),

            // 3. Main Contact Hub (Form + Details Split - Asymmetrical)
            _buildContactHub(context, isDesktop),

            // 4. Department-Specific Channels Grid
            _buildContactChannelsSection(context, isDesktop),

            // 5. Final CTA & Regulatory Statement
            _buildRegulatoryCTA(context),

            // 6. Footer
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  // --- SECTION 1: KENYA-FOCUSED HERO ---
  Widget _buildHero(BuildContext context, bool isDesktop) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80.0 : 20.0, 
        vertical: 80.0,
      ),
      // Gentle gradient to signify precision and quality
      decoration: BoxDecoration(gradient: AppColors.sereneGradient),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              Text(
                'Your Direct Gateway to Medical Consumables in Kenya',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.darkBlue,
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'We are the local connection for global medical excellence. Reach out to our Nairobi team for precise support on importation, compliance, and supply chain management.',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- SECTION 2: MAIN CONTACT HUB (FORM + DETAILS) ---
  Widget _buildContactHub(BuildContext context, bool isDesktop) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80.0 : 20.0, vertical: 80.0),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Contact Form (Takes more space)
                    const Expanded(flex: 3, child: _ContactForm()),
                    const SizedBox(width: 60),
                    // Kenya Office Details Card (Dedicated Info)
                    Expanded(flex: 2, child: _KenyaOfficeDetailsCard(office: _kenyaOffice)),
                  ],
                )
              : Column(
                  children: [
                    const _ContactForm(),
                    const SizedBox(height: 50),
                    _KenyaOfficeDetailsCard(office: _kenyaOffice),
                  ],
                ),
        ),
      ),
    );
  }


  // --- SECTION 3: SEGMENTED CONTACT CHANNELS GRID ---
  Widget _buildContactChannelsSection(BuildContext context, bool isDesktop) {
    final int crossAxisCount = isDesktop ? 4 : (MediaQuery.of(context).size.width > 600 ? 2 : 1);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80.0 : 20.0, vertical: 80.0),
      color: AppColors.lightBackground, // Light Background for contrast
      child: Column(
        children: [
          Text(
            'Inquiry by Department: Get the Fastest Response',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkBlue,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Select the channel that best matches your need—from compliance to current order status.',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _contactChannels.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 30.0,
              mainAxisSpacing: 30.0,
              childAspectRatio: isDesktop ? 1.0 : 1.5, 
            ),
            itemBuilder: (context, index) {
              final channel = _contactChannels[index];
              return _ChannelCard(channel: channel);
            },
          ),
        ],
      ),
    );
  }

  // --- SECTION 4: REGULATORY CTA ---
  Widget _buildRegulatoryCTA(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.darkBlue,
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 60.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              Text(
                'URGENT REGULATORY CONTACT',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryGreen,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                'For immediate matters concerning **KEBS or PPB compliance,** please use our dedicated regulatory email.',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.textLight.withOpacity(0.9)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              SelectableText(
                _kenyaOffice['email_regulatory']!,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: AppColors.textLight,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- WIDGETS USED IN CONTACT SCREEN ---

class _KenyaOfficeDetailsCard extends StatelessWidget {
  final Map<String, String> office;

  const _KenyaOfficeDetailsCard({required this.office});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(35.0),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withOpacity(0.05), // Very light blue background
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primaryBlue, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.apartment, size: 30, color: AppColors.darkBlue),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  office['city']!, 
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColors.darkBlue, 
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ],
          ),
          
          const Divider(height: 30, color: AppColors.primaryGreen, thickness: 2),
          
          _DetailRow(icon: Icons.access_time, label: 'Hours:', detail: office['hours']!, detailColor: AppColors.primaryGreen, isSelectable: false),
          const SizedBox(height: 15),
          _DetailRow(icon: Icons.pin_drop, label: 'Visit:', detail: office['address']!, isSelectable: true),
          const SizedBox(height: 15),
          _DetailRow(icon: Icons.phone_in_talk, label: 'Sales:', detail: office['phone_sales']!, isSelectable: true),
          const SizedBox(height: 15),
          _DetailRow(icon: Icons.support_agent, label: 'Support:', detail: office['phone_support']!, isSelectable: true),
          const SizedBox(height: 15),
          _DetailRow(icon: Icons.email, label: 'General:', detail: office['email_info']!, isSelectable: true),
          
          const SizedBox(height: 30),
          
          // Map Placeholder
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.textMuted.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.textMuted),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map_outlined, size: 40, color: AppColors.textMuted),
                  SizedBox(height: 5),
                  Text('Local Map View Placeholder', style: TextStyle(color: AppColors.textMuted)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String detail;
  final Color detailColor;
  final bool isSelectable;

  const _DetailRow({required this.icon, required this.label, required this.detail, this.detailColor = AppColors.darkBlue, this.isSelectable = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.primaryBlue),
        const SizedBox(width: 10),
        SizedBox(
          width: 70, // Fixed width for alignment
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.darkBlue),
          ),
        ),
        Expanded(
          child: isSelectable
              ? SelectableText(
                  detail,
                  style: TextStyle(color: detailColor, fontWeight: FontWeight.w600),
                )
              : Text(
                  detail,
                  style: TextStyle(color: detailColor),
                ),
        ),
      ],
    );
  }
}

class _ContactForm extends StatelessWidget {
  const _ContactForm();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(35.0),
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Request a Callback or Consultation',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.darkBlue, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25),
          _buildInputField(context, 'Your Full Name (Required)', Icons.person),
          const SizedBox(height: 20),
          _buildInputField(context, 'Facility / Company Name', Icons.local_hospital),
          const SizedBox(height: 20),
          _buildInputField(context, 'Best Contact Phone Number', Icons.phone),
          const SizedBox(height: 20),
          _buildInputField(context, 'Official Email Address (Required)', Icons.email),
          const SizedBox(height: 20),
          _buildDropdownField(context, 'Primary Interest', Icons.category),
          const SizedBox(height: 20),
          _buildMessageField(context, 'Briefly describe your need (e.g., "Need quotes on gauze and syringes")', Icons.message),
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.gentleHighlightGradient,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent, 
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                'Submit Inquiry to Nairobi Team', 
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.darkBlue, 
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(BuildContext context, String label, IconData icon) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primaryBlue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.primaryGreen, width: 2)),
      ),
    );
  }

  Widget _buildMessageField(BuildContext context, String label, IconData icon) {
    return TextFormField(
      maxLines: 5,
      decoration: InputDecoration(
        labelText: label,
        alignLabelWithHint: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 10), // Align icon to the top left of the field
          child: Icon(icon, color: AppColors.primaryBlue),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.primaryGreen, width: 2)),
      ),
    );
  }

  Widget _buildDropdownField(BuildContext context, String label, IconData icon) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primaryBlue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.primaryGreen, width: 2)),
      ),
      items: ['New Order/Quote', 'Existing Order Status', 'Regulatory Documentation', 'Technical Support', 'Partnership/Other'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {},
    );
  }
}

class _ChannelCard extends StatelessWidget {
  final Map<String, dynamic> channel;

  const _ChannelCard({required this.channel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        color: channel['color'].withOpacity(0.08), // Light color background
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: channel['color'].withOpacity(0.5), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: channel['color'].withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(channel['icon'] as IconData, size: 30, color: channel['color']),
          ),
          
          const SizedBox(height: 20),
          
          // Title
          Text(
            channel['title'], 
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColors.darkBlue, 
              fontWeight: FontWeight.w700
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Description
          Text(
            channel['subtitle'], 
            style: const TextStyle(color: AppColors.textMuted),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          const Spacer(),

          // CTA Link
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.arrow_forward, size: 18, color: channel['color']),
            label: Text('Go to ${channel['title'].split(' ')[0]} Channel', style: TextStyle(color: channel['color'], fontWeight: FontWeight.bold)), 
          ),
        ],
      ),
    );
  }
}