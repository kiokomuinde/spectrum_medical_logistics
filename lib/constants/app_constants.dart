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

  static const List<Map<String, dynamic>> productsAndServices = [
    {'title': 'Clinical Laboratory Machines', 'icon': Icons.science_outlined, 'description': 'Haematology, Biochemistry, Immunoassay, Microbiology.'},
    {'title': 'Laboratory Hardwares', 'icon': Icons.precision_manufacturing_outlined, 'description': 'Centrifuge, Microscope, Shakers, Fridges, Waterbath, Mixer.'},
    {'title': 'X-Ray Servicing', 'icon': Icons.medical_services_outlined, 'description': 'Servicing and maintenance of X-Ray machines.'},
    {'title': 'Laboratory Consumables', 'icon': Icons.biotech_outlined, 'description': 'Supply of essential lab consumables.'},
    {'title': 'Dialysis Machine Maintenance', 'icon': Icons.monitor_heart_outlined, 'description': 'Repair and maintenance of dialysis machines and consumables supply.'},
    {'title': 'Radiology Film Supply', 'icon': Icons.camera_roll_outlined, 'description': 'Supplying of X-Ray/radiology films and consumables.'},
    {'title': 'Dialysis Waterplant', 'icon': Icons.water_drop_outlined, 'description': 'Waterplant supplies, installation, and repairs.'},
    {'title': 'Dental Chair Supplies', 'icon': Icons.chair_outlined, 'description': 'Installation, maintenance, and consumables for dental chairs.'},
    {'title': 'Physiotherapy Equipment', 'icon': Icons.fitness_center_outlined, 'description': 'Physiotherapy consumables and equipment supplies.'},
  ];

  static const List<Map<String, dynamic>> logisticsSteps = [
    {'icon': Icons.description_outlined, 'title': 'Order Fulfillment', 'desc': 'Digital ordering and verification of required medical goods.'},
    {'icon': Icons.route_outlined, 'title': 'Specialized Transport', 'desc': 'Climate-controlled, secure transit for sensitive equipment.'},
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
    {'title': '5G and Remote X-Ray Servicing', 'tag': 'Technology', 'date': 'Sep 25, 2025'},
    {'title': 'The Cold Chain for Immunoassays', 'tag': 'Consumables', 'date': 'Sep 15, 2025'},
  ];
}