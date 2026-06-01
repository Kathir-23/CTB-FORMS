import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class BarcodeRegistrationScreen extends StatefulWidget {
  const BarcodeRegistrationScreen({super.key});

  @override
  State<BarcodeRegistrationScreen> createState() => _BarcodeRegistrationScreenState();
}

class _BarcodeRegistrationScreenState extends State<BarcodeRegistrationScreen> {
  int _selectedNavIndex = 16;
  final _formKey = GlobalKey<FormState>();
  final _businessNameCtrl = TextEditingController();
  final _productNameCtrl = TextEditingController();
  final _barcodeCountCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  String? _productCategory;

  static const _categories = ['Food', 'Apparel', 'Electronics', 'Cosmetics', 'Other'];

  @override
  void dispose() {
    _businessNameCtrl.dispose();
    _productNameCtrl.dispose();
    _barcodeCountCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  bool _validateEmail(String v) => RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(v);
  bool _validatePhone(String v) => RegExp(r'^\d{10}$').hasMatch(v);

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_productCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a product category')),
      );
      return;
    }
    _showSuccessDialog();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeNavIndex: _selectedNavIndex,
      onNavChanged: (i) => setState(() => _selectedNavIndex = i),
      showBackButton: true,
      child: _selectedNavIndex == 16
          ? Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GstBreadcrumb(path: 'Business & Regulatory Registration > Barcode Registration'),
                  const SizedBox(height: 4),
                  const GstFormTitle(title: 'Barcode Registration'),
                  const SizedBox(height: 24),
                  GstFormCard(title: 'Business Details', icon: Icons.business, child: _buildBusinessDetails()),
                  const SizedBox(height: 16),
                  GstFormCard(title: 'Product Information', icon: Icons.inventory_2, child: _buildProductInfo()),
                  const SizedBox(height: 16),
                  GstFormCard(title: 'Contact Information', icon: Icons.contact_mail, child: _buildContactInfo()),
                  const SizedBox(height: 24),
                  GstSubmitButton(onPressed: _submit, label: 'Submit'),
                ],
              ),
            )
          : const Center(
              child: Text('Not built yet', style: TextStyle(fontSize: 18, color: AppColors.textMuted)),
            ),
    );
  }

  Widget _buildBusinessDetails() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildTextField('Business Name', 'Enter business name', Icons.business, _businessNameCtrl, required: true)),
            const SizedBox(width: 20),
            Expanded(child: _buildTextField('Product Name', 'Enter product name', Icons.shopping_bag_outlined, _productNameCtrl, required: true)),
          ],
        ),
      ],
    );
  }

  Widget _buildProductInfo() {
    return Column(
      children: [
        GstDropdownField(
          label: 'Product Category',
          icon: Icons.category_outlined,
          items: _categories,
          value: _productCategory,
          onChanged: (v) {
            setState(() => _productCategory = v);
          },
          required: true,
          placeholder: '-- Select --',
        ),
        const SizedBox(height: 16),
        _buildTextField('No. of Barcodes', 'Enter number of barcodes', Icons.numbers, _barcodeCountCtrl,
          required: true,
          keyboardType: TextInputType.number,
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'No. of Barcodes is required';
            if (int.tryParse(v.trim()) == null || int.parse(v.trim()) <= 0) return 'Must be a positive number';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildTextField('Contact Email', 'Enter email address', Icons.email_outlined, _emailCtrl, required: true,
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'Contact Email is required';
            if (!_validateEmail(v.trim())) return 'Invalid email format';
            return null;
          },
        )),
        const SizedBox(width: 20),
        Expanded(child: _buildTextField('Contact Number', 'Enter 10-digit number', Icons.phone_outlined, _phoneCtrl, required: true,
          keyboardType: TextInputType.phone,
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'Contact Number is required';
            if (!_validatePhone(v.trim())) return 'Exactly 10 digits required';
            return null;
          },
        )),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    IconData icon,
    TextEditingController controller, {
    bool required = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label, required: required),
        const SizedBox(height: 6),
        SizedBox(
          height: 44,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, size: 16, color: const Color(0xFF94A3B8)),
              hintText: hint.isEmpty ? null : hint,
              hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFF94A3B8)),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFFEF4444)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFFEF4444)),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
            validator: validator ?? (required ? (v) => v == null || v.trim().isEmpty ? '$label is required' : null : null),
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text, {bool required = false}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
              color: Color(0xFF374151),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (required)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Color(0xFFEF4444), fontSize: 13),
            ),
        ],
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
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Color(0xFF22C55E),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 32),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Application Submitted!',
                  style: TextStyle(
                    color: Color(0xFF1A1F2E),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'We have received your barcode registration request. Our team will review and get back to you shortly.',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brandBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
