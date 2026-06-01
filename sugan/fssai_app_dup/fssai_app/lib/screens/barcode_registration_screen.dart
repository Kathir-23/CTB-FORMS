import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/form_fields.dart';

class BarcodeRegistrationScreen extends StatefulWidget {
  const BarcodeRegistrationScreen({super.key});

  @override
  State<BarcodeRegistrationScreen> createState() => _BarcodeRegistrationScreenState();
}

class _BarcodeRegistrationScreenState extends State<BarcodeRegistrationScreen> {
  int _selectedNavIndex = 13;
  final _formKey = GlobalKey<FormState>();
  bool _hoveringSubmit = false;

  final _businessNameController = TextEditingController();
  final _productNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();

  String? _selectedCategory;

  final List<String> _categories = [
    'Food',
    'Apparel',
    'Electronics',
    'Cosmetics',
    'Other',
  ];

  @override
  void dispose() {
    _businessNameController.dispose();
    _productNameController.dispose();
    _quantityController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeNavIndex: _selectedNavIndex,
      onNavChanged: (i) => setState(() => _selectedNavIndex = i),
      showBackButton: true,
      child: _selectedNavIndex == 13 ? _buildForm() : const SizedBox.shrink(),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Business & Regulatory Registration Portal > Barcode Registration',
            style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
          ),
          const SizedBox(height: 4),
          const Text(
            'Barcode Registration Form',
            style: TextStyle(color: Color(0xFF0F172A), fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 24),

          FormCard(
            title: 'Product Details',
            icon: Icons.qr_code_scanner_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'Business Name*',
                        hint: 'Company name',
                        controller: _businessNameController,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Business name is required';
                          if (v.trim().length < 3) return 'Min 3 characters';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildTextField(
                        label: 'Product Name*',
                        hint: 'Product name',
                        controller: _productNameController,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Product name is required';
                          if (v.trim().length < 3) return 'Min 3 characters';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdown(
                        label: 'Product Category*',
                        value: _selectedCategory,
                        items: _categories,
                        onChanged: (v) => setState(() => _selectedCategory = v),
                        validator: (v) => (v == null || v.isEmpty) ? 'Please select' : null,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildTextField(
                        label: 'No. of Barcodes*',
                        hint: 'Quantity required',
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Quantity is required';
                          final n = int.tryParse(v.trim());
                          if (n == null || n <= 0) return 'Integer > 0';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'Contact Email*',
                        hint: 'Email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Email is required';
                          final re = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$');
                          if (!re.hasMatch(v.trim())) return 'Invalid format';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildTextField(
                        label: 'Contact Number*',
                        hint: 'Mobile',
                        controller: _contactController,
                        keyboardType: TextInputType.phone,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Contact number is required';
                          if (v.trim().length != 10 || int.tryParse(v.trim()) == null) return '10 digits';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final hasAsterisk = label.endsWith('*');
    final cleanLabel = hasAsterisk ? label.substring(0, label.length - 1) : label;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: cleanLabel, style: const TextStyle(color: Color(0xFF374151), fontSize: 13, fontWeight: FontWeight.w500)),
              if (hasAsterisk) const TextSpan(text: ' *', style: TextStyle(color: Color(0xFFEF4444))),
            ],
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required String? Function(String?) validator,
  }) {
    final hasAsterisk = label.endsWith('*');
    final cleanLabel = hasAsterisk ? label.substring(0, label.length - 1) : label;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: cleanLabel, style: const TextStyle(color: Color(0xFF374151), fontSize: 13, fontWeight: FontWeight.w500)),
              if (hasAsterisk) const TextSpan(text: ' *', style: TextStyle(color: Color(0xFFEF4444))),
            ],
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          hint: const Text('-- Select --', style: TextStyle(color: Color(0xFF9CA3AF))),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: onChanged,
          validator: validator,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveringSubmit = true),
      onExit: (_) => setState(() => _hoveringSubmit = false),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: () {
            final valid = _formKey.currentState?.validate() ?? false;
            if (valid) {
              _showSuccessDialog();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _hoveringSubmit ? const Color(0xFF4A59D0) : AppColors.brandBlue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text('Submit Application', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            width: 420,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(16)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(width: 56, height: 56, decoration: const BoxDecoration(color: Color(0xFF22C55E), shape: BoxShape.circle), child: const Icon(Icons.check, color: Colors.white, size: 32)),
              const SizedBox(height: 20),
              const Text('Application Submitted!', style: TextStyle(color: Color(0xFF1A1F2E), fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              const Text('We have received your barcode registration request. Our team will process it and get back to you shortly.', style: TextStyle(color: Color(0xFF64748B), fontSize: 14), textAlign: TextAlign.center),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.brandBlue, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0),
                  child: const Text('Back to Services', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
