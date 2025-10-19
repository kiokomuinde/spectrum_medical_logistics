// lib/constants/app_constants.dart
import 'package:flutter/material.dart';

class AppConstants {
  static const String appTitle = "Spectrum Medical Logistics";
  
  // UPDATED NAVLINKS FOR PROFESSIONAL E-COMMERCE SITE
  static const List<String> navLinks = [
    'Home',
    'Products',
    'Solutions',
    'Services',
    'Quality & Compliance',
    'About Us',
    'Contact'
  ];

  // 🔥 FIX: Explicitly defined 'navPaths' map for GoRouter to reference
  static const Map<String, String> navPaths = {
    'Home': '/',
    'Products': '/products',
    'Solutions': '/solutions',
    'Services': '/services',
    'Quality & Compliance': '/quality-compliance',
    'About Us': '/about-us',
    'Contact': '/contact',
    // Auth Routes
    'SignIn': '/sign-in',
    'SignUp': '/sign-up',
  };

  // The rest of the AppConstants content below is retained from your provided code
  static const List<Map<String, dynamic>> productsAndServices = [
    // This list now serves as the source for the Services Section in home_screen.dart
    {'title': 'Clinical Laboratory Machines', 'icon': Icons.science_outlined, 'description': 'Haematology, Biochemistry, Immunoassay, Microbiology.'},
    {'title': 'Laboratory Hardwares', 'icon': Icons.precision_manufacturing_outlined, 'description': 'Centrifuge, Microscope, Shakers, Fridges, Waterbath, Mixer.'},
    {'title': 'X-Ray Servicing', 'icon': Icons.medical_services_outlined, 'description': 'Servicing and maintenance of X-Ray machines.'},
    {'title': 'Laboratory Consumables', 'icon': Icons.biotech_outlined, 'description': 'Supply of essential lab consumables.'},
    {'title': 'Dialysis Machine Maintenance', 'icon': Icons.monitor_heart_outlined, 'description': 'Repair and maintenance of Dialysis machines.'},
    {'title': 'Waterplant Solutions', 'icon': Icons.water_drop_outlined, 'description': 'Installation, maintenance, and servicing of specialized water treatment plants.'},
  ];
  
  static const List<Map<String, dynamic>> logisticsFlowSteps = [
    {'icon': Icons.inventory_2_outlined, 'title': 'Sourcing & Procurement', 'desc': 'Global sourcing and quality checks for all medical supplies.'},
    {'icon': Icons.local_shipping_outlined, 'title': 'Specialized Transport', 'desc': 'Climate-controlled, secure transport for sensitive goods.'},
    {'icon': Icons.location_on_outlined, 'title': 'Last-Mile Delivery', 'desc': 'Precision timing and installation at the clinical site.'},
    {'icon': Icons.handshake_outlined, 'title': 'Support & Servicing', 'desc': 'Ongoing maintenance and consumables resupply.'},
  ];

  static const List<Map<String, dynamic>> partnerLogos = [
    {'icon': Icons.monitor_outlined, 'name': 'Diagnostics Co.'}, 
    {'icon': Icons.local_hospital_outlined, 'name': 'Therapy Solutions'}, 
    {'icon': Icons.track_changes_outlined, 'name': 'TrackSys'}, 
    {'icon': Icons.devices_other_outlined, 'name': 'MediTech Innov.'}
  ];

  static const List<Map<String, dynamic>> testimonials = [
    {'quote': '“Spectrum’s response time for our X-Ray maintenance is unmatched. Truly life-saving service.”', 'source': 'Dr. E. Khan, City General Hospital'},
    {'quote': '“Reliable supply of specialized laboratory consumables. They keep our research on track.”', 'source': 'M. Alami, Research Lab Director'},
    {'quote': '“The installation of our new dialysis waterplant was seamless and professional.”', 'source': 'J. Carter, Renal Care Manager'},
  ];

  static const List<Map<String, dynamic>> blogArticles = [
    {'title': 'Future of Dialysis Water Management', 'tag': 'Waterplant', 'date': 'Oct 1, 2025'},
    {'title': '5 Compliance Mistakes in Medical Cold Chain', 'tag': 'Compliance', 'date': 'Sep 20, 2025'},
    {'title': 'AI in Logistics: What it Means for You', 'tag': 'Technology', 'date': 'Sep 1, 2025'},
  ];

  static const List<Map<String, dynamic>> certificationBadges = [
    {'title': 'ISO 13485:2016', 'desc': 'Quality management system for medical devices.', 'icon': Icons.medical_services_outlined},
    {'title': 'GDP Certified', 'desc': 'Adherence to Good Distribution Practice for pharmaceuticals.', 'icon': Icons.check_circle_outline},
    {'title': 'Cold Chain Verified', 'desc': 'Validated temperature-controlled logistics processes.', 'icon': Icons.thermostat_outlined},
  ];
}