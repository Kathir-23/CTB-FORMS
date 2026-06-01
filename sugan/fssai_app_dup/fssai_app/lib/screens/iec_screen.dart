import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/form_fields.dart';

class IecScreen extends StatefulWidget {
  const IecScreen({super.key});

  @override
  State<IecScreen> createState() => _IecScreenState();
}

class _IecScreenState extends State<IecScreen> {
  int _selectedNavIndex = 13;
  bool _hoveringSubmit = false;
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final _clientNameController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _panController = TextEditingController();
  final _bankAccountController = TextEditingController();
  final _ifscController = TextEditingController();
  final _businessAddressController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactNumberController = TextEditingController();

  String? _selectedBusinessType;
  String? _fileName;
  bool _showFileError = false;

  final List<String> _businessTypes = [
    'Proprietorship',
    'Partnership',
    'Pvt Ltd',
    'LLP',
    'Public Ltd',
    'Co-operative',
    'Other',
  ];

  @override
  void dispose() {
    _clientNameController.dispose();
    _businessNameController.dispose();
    _panController.dispose();
    _bankAccountController.dispose();
    _ifscController.dispose();
    _businessAddressController.dispose();
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
            'Business & Regulatory Registration Portal > Import Export Code',
            style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
          ),
          const SizedBox(height: 4),
          const Text(
            'Import Export Code (IEC) Registration Form',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                        hint: 'Enter Business entity name',
                        icon: Icons.storefront_outlined,
                        controller: _businessNameController,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Business name is required';
                          if (v.trim().length < 3) return 'Must be at least 3 characters';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildDropdownField(
                        label: 'Business Type*',
                        hint: 'Select business entity type',
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
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildTextField(
                        label: 'Business PAN*',
                        hint: 'Enter 10-digit PAN (e.g. ABCDE1234F)',
                        icon: Icons.badge_outlined,
                        controller: _panController,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Business PAN is required';
                          final panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
                          if (!panRegex.hasMatch(v.trim().toUpperCase())) {
                            return 'Invalid PAN format (e.g. ABCDE1234F)';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          FormCard(
            title: 'Bank Account Details',
            icon: Icons.account_balance_outlined,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildTextField(
                    label: 'Bank Account No.*',
                    hint: 'Enter bank account number',
                    icon: Icons.numbers_outlined,
                    controller: _bankAccountController,
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Bank account number is required';
                      if (int.tryParse(v.trim()) == null) return 'Must be numeric digits';
                      if (v.trim().length < 8 || v.trim().length > 18) {
                        return 'Invalid bank account number length';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildTextField(
                    label: 'IFSC Code*',
                    hint: 'Enter 11-digit bank IFSC (e.g. SBIN0001234)',
                    icon: Icons.qr_code_outlined,
                    controller: _ifscController,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'IFSC code is required';
                      final ifscRegex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');
                      if (!ifscRegex.hasMatch(v.trim().toUpperCase())) {
                        return 'Invalid IFSC format (e.g. SBIN0001234)';
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
            title: 'Business Address & Location',
            icon: Icons.location_on_outlined,
            child: _buildTextField(
              label: 'Business Address*',
              hint: 'Enter complete office address',
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
                  helperText: 'Upload proof docs (PAN, Bank proof, Address proof) – PDF/JPG, max 10MB',
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
                  'We have received your Import Export Code request. Our team will verify the documents and get back to you shortly.',
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
