import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class ApedaScreen extends StatefulWidget {
  const ApedaScreen({super.key});

  @override
  State<ApedaScreen> createState() => _ApedaScreenState();
}

class _ApedaScreenState extends State<ApedaScreen> {
  int _selectedNavIndex = 16;
  final _formKey = GlobalKey<FormState>();
  final _clientNameCtrl = TextEditingController();
  final _businessNameCtrl = TextEditingController();
  final _panCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  final _exportProducts = <String>[];
  String? _uploadedFile;

  static const _productOptions = [
    'Fruits', 'Vegetables', 'Meat Products', 'Dairy Products',
    'Poultry Products', 'Floriculture Products', 'Confectionery', 'Other Agrifoods',
  ];

  @override
  void dispose() {
    _clientNameCtrl.dispose();
    _businessNameCtrl.dispose();
    _panCtrl.dispose();
    _gstinCtrl.dispose();
    _addressCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  bool _validateEmail(String v) => RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(v);
  bool _validatePhone(String v) => RegExp(r'^\d{10}$').hasMatch(v);

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_exportProducts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one export product')),
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
                  const GstBreadcrumb(path: 'Business & Regulatory Registration > APEDA Registration'),
                  const SizedBox(height: 4),
                  const GstFormTitle(title: 'APEDA Registration'),
                  const SizedBox(height: 24),
                  GstFormCard(title: 'Business Information', icon: Icons.business, child: _buildBusinessInfo()),
                  const SizedBox(height: 16),
                  GstFormCard(title: 'Export Products', icon: Icons.agriculture, child: _buildExportProducts()),
                  const SizedBox(height: 16),
                  GstFormCard(title: 'Contact & Address', icon: Icons.location_on_outlined, child: _buildContactAddress()),
                  const SizedBox(height: 16),
                  GstFormCard(title: 'Documents', icon: Icons.upload_file, child: _buildDocuments()),
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

  Widget _buildBusinessInfo() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildTextField('Client Name', 'Enter client name', Icons.person, _clientNameCtrl, required: true)),
            const SizedBox(width: 20),
            Expanded(child: _buildTextField('Business Name', 'Enter business name', Icons.business, _businessNameCtrl, required: true)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildTextField('PAN', 'Enter PAN number', Icons.credit_card_outlined, _panCtrl, required: true)),
            const SizedBox(width: 20),
            Expanded(child: _buildTextField('GSTIN', 'Enter GSTIN (optional)', Icons.receipt_outlined, _gstinCtrl)),
          ],
        ),
      ],
    );
  }

  Widget _buildExportProducts() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _productOptions.map((product) {
        final selected = _exportProducts.contains(product);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (selected) {
                _exportProducts.remove(product);
              } else {
                _exportProducts.add(product);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? AppColors.brandPrimary : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selected ? AppColors.brandPrimary : const Color(0xFFE2E8F0),
              ),
            ),
            child: Text(
              product,
              style: TextStyle(
                color: selected ? Colors.white : const Color(0xFF475569),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildContactAddress() {
    return Column(
      children: [
        _buildTextField('Business Address', 'Enter full address', Icons.location_on_outlined, _addressCtrl, required: true),
        const SizedBox(height: 16),
        Row(
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
        ),
      ],
    );
  }

  Widget _buildDocuments() {
    return GstFileField(
      label: 'Upload Documents',
      icon: Icons.upload_file,
      onFilePicked: (name) => _uploadedFile = name,
      fileName: _uploadedFile,
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
                  'We have received your APEDA registration request. Our team will review and get back to you shortly.',
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
