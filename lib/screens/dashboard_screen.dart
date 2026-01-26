import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive_navbar.dart';
import '../widgets/app_footer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _selectedCategory = 'All Products';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _categories = [
    {'name': 'All Products', 'icon': Icons.grid_view},
    {'name': 'Lab Consumables', 'icon': Icons.science_outlined},
    {'name': 'Imaging & X-Ray', 'icon': Icons.settings_remote_outlined},
    {'name': 'Rapid Test Kits', 'icon': Icons.biotech_outlined},
    {'name': 'Surgical Gear', 'icon': Icons.medical_services_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 1000;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ResponsiveNavBar(),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 40, 
                horizontal: isDesktop ? 60 : 20
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 30),
                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSidebar(),
                        const SizedBox(width: 30),
                        Expanded(child: _buildProductContent()),
                      ],
                    )
                  else
                    Column(
                      children: [
                        _buildMobileCategoryScroll(),
                        const SizedBox(height: 20),
                        _buildProductContent(),
                      ],
                    ),
                ],
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Inventory Dashboard',
          style: TextStyle(
            fontSize: 32, 
            fontWeight: FontWeight.bold, 
            color: AppColors.darkBlue
          ),
        ),
        const Text('Welcome back! Manage your medical supplies and facility orders.'),
        const SizedBox(height: 20),
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search consumables, devices, or SKU...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        children: _categories.map((cat) => ListTile(
          leading: Icon(cat['icon'], color: _selectedCategory == cat['name'] ? AppColors.primaryGreen : AppColors.primaryBlue),
          title: Text(cat['name'], style: TextStyle(fontWeight: _selectedCategory == cat['name'] ? FontWeight.bold : FontWeight.normal)),
          onTap: () => setState(() => _selectedCategory = cat['name']),
          selected: _selectedCategory == cat['name'],
          selectedTileColor: AppColors.primaryGreen.withOpacity(0.1),
        )).toList(),
      ),
    );
  }

  Widget _buildMobileCategoryScroll() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _categories.map((cat) => Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ChoiceChip(
            label: Text(cat['name']),
            selected: _selectedCategory == cat['name'],
            onSelected: (selected) => setState(() => _selectedCategory = cat['name']),
            selectedColor: AppColors.primaryGreen,
            labelStyle: TextStyle(color: _selectedCategory == cat['name'] ? Colors.white : AppColors.darkBlue),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildProductContent() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Adjust based on width in a real app
        childAspectRatio: 0.8,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: 6, // Dummy count
      itemBuilder: (context, index) => Card(
        child: Column(
          children: [
            Expanded(child: Container(color: Colors.grey[200], child: const Icon(Icons.medical_services, size: 50))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Medical Product #$index', style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}