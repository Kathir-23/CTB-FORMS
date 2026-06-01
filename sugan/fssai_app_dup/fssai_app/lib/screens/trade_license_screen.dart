import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/form_fields.dart';

class TradeLicenseScreen extends StatefulWidget {
  const TradeLicenseScreen({super.key});

  @override
  State<TradeLicenseScreen> createState() => _TradeLicenseScreenState();
}

class _TradeLicenseScreenState extends State<TradeLicenseScreen> {
  int _selectedNavIndex = 13;
  bool _hoveringSubmit = false;
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final _clientNameController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _businessAddressController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _panController = TextEditingController();
  final _aadhaarController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactNumberController = TextEditingController();

  String? _selectedBusinessType;
  String? _fileName;
  bool _showFileError = false;

  final List<String> _businessTypes = [
    'Retail',
    'Manufacturing',
    'Service',
    'Other',
  ];

  @override
  void dispose() {
    _clientNameController.dispose();
    _businessNameController.dispose();
    _businessAddressController.dispose();
    _pincodeController.dispose();
    _panController.dispose();
    _aadhaarController.dispose();
    _emailController.dispose();
    _contactNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeNavIndex: _selectedNavIndex,
      onNavChanged: (i) => setState(() => _selectedNavIndex = i),
      showBackButton: true,
      child: _selectedNavIndex == 13
          ? _buildFormContent()
          : const Center(
              child: Text(
                'Not built yet',
                style: TextStyle(fontSize: 18, color: AppColors.textMuted),
              ),
            ),
    );
  }

  Widget _buildFormContent() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Business & Regulatory Registration Portal > Trade License',
            style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
          ),
          const SizedBox(height: 4),
          const Text(
            'Trade License Registration Form',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          FormCard(
            title: 'Client & Business Details',
            icon: Icons.business,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildTextField(
                    label: 'Client Name*',
                    hint: 'Enter Applicant\'s full name',
                    icon: Icons.person_outline,
                    controller: _clientNameController,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Client name is required';
                      if (v.trim().length < 3) return 'Must be at least 3 characters';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildTextField(
                    label: 'Business Name*',
                    hint: 'Enter Registered business name',
                    icon: Icons.storefront_outlined,
                    controller: _businessNameController,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Business name is required';
                      if (v.trim().length < 3) return 'Must be at least 3 characters';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildDropdownField(
                    label: 'Business Type*',
                    hint: 'Select business type',
                    icon: Icons.category_outlined,
                    value: _selectedBusinessType,
                    items: _businessTypes,
                    onChanged: (v) => setState(() => _selectedBusinessType = v),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Please select a business type';
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FormCard(
            title: 'Business Address & Location',
            icon: Icons.location_on_outlined,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildTextField(
                    label: 'Business Address*',
                    hint: 'Enter complete business address',
                    icon: Icons.map_outlined,
                    controller: _businessAddressController,
                    maxLines: 2,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Business address is required';
                      if (v.trim().length < 10) return 'Must be at least 10 characters';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: _buildTextField(
                    label: 'Pincode*',
                    hint: 'Enter 6-digit area postal code',
                    icon: Icons.pin_drop_outlined,
                    controller: _pincodeController,
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Pincode is required';
                      if (v.trim().length != 6 || int.tryParse(v.trim()) == null) {
                        return 'Must be a 6-digit numeric code';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FormCard(
            title: 'Owner Verification',
            icon: Icons.person_outline,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildTextField(
                    label: 'Owner PAN*',
                    hint: 'Enter Permanent Account Number (e.g. ABCDE1234F)',
                    icon: Icons.badge_outlined,
                    controller: _panController,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Owner PAN is required';
                      final panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
                      if (!panRegex.hasMatch(v.trim().toUpperCase())) {
                        return 'Invalid PAN format (e.g. ABCDE1234F)';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildTextField(
                    label: 'Owner Aadhaar',
                    hint: 'Enter 12-digit Aadhaar number (Optional)',
                    icon: Icons.fingerprint_outlined,
                    controller: _aadhaarController,
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return null;
                      if (v.trim().length != 12 || int.tryParse(v.trim()) == null) {
                        return 'Must be a 12-digit numeric Aadhaar';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FormCard(
            title: 'Contact & Communication',
            icon: Icons.contact_mail_outlined,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildTextField(
                    label: 'Contact Email*',
                    hint: 'Enter Email ID',
                    icon: Icons.email_outlined,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Contact email is required';
                      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(v.trim())) return 'Invalid email format';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildTextField(
                    label: 'Contact Number*',
                    hint: 'Enter 10-digit mobile number',
                    icon: Icons.phone_outlined,
                    controller: _contactNumberController,
                    keyboardType: TextInputType.phone,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Contact number is required';
                      if (v.trim().length != 10 || int.tryParse(v.trim()) == null) {
                        return 'Must be a 10-digit mobile number';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FormCard(
            title: 'Document Upload',
            icon: Icons.folder_open_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormFileField(
                  label: 'Supporting Documents*',
                  icon: Icons.description_outlined,
                  helperText: 'Upload proof docs (Identity, Address, Business) – PDF/JPG/PNG, max 10MB',
                  onFilePicked: (name) {
                    setState(() {
                      _fileName = name;
                      _showFileError = false;
                    });
                  },
                ),
                if (_showFileError)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Please upload supporting documents to proceed',
                      style: TextStyle(color: Color(0xFFEF4444), fontSize: 12),
                    ),
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
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    final hasAsterisk = label.endsWith('*');
    final cleanLabel = hasAsterisk ? label.substring(0, label.length - 1) : label;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(cleanLabel, hasAsterisk),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          validator: validator,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: maxLines > 1 ? null : Icon(icon, size: 16, color: const Color(0xFF94A3B8)),
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: maxLines > 1 ? 12 : 12),
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
              borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.5),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required IconData icon,
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
        _buildLabel(cleanLabel, hasAsterisk),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          initialValue: value,
          hint: Text(hint, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14)),
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF94A3B8)),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 16, color: const Color(0xFF94A3B8)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
              borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.5),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
          validator: validator,
          onChanged: onChanged,
          items: items.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildLabel(String text, bool hasAsterisk) {
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
          if (hasAsterisk)
            const TextSpan(
              text: ' *',
              style: TextStyle(
                color: Color(0xFFEF4444),
                fontSize: 13,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hoveringSubmit = true),
        onExit: (_) => setState(() => _hoveringSubmit = false),
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              bool isFormValid = _formKey.currentState!.validate();
              bool isFileUploaded = _fileName != null;
              if (!isFileUploaded) {
                setState(() => _showFileError = true);
              }
              if (isFormValid && isFileUploaded) {
                _showSuccessDialog();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _hoveringSubmit ? const Color(0xFF4A59D0) : AppColors.brandBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Submit Application',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
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
                  'We have received your Trade License request. Our team will verify the documents and get back to you shortly.',
                  style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brandBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Back to Services',
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
