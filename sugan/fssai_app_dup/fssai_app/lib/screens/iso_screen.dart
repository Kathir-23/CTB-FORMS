import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/form_fields.dart';

class IsoScreen extends StatefulWidget {
  const IsoScreen({super.key});

  @override
  State<IsoScreen> createState() => _IsoScreenState();
}

class _IsoScreenState extends State<IsoScreen> {
  int _selectedNavIndex = 13;
  bool _hoveringSubmit = false;
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final _clientNameController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _employeeStrengthController = TextEditingController();
  final _businessActivityController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactNumberController = TextEditingController();

  String? _selectedIsoStandard;
  String? _fileName;
  bool _showFileError = false;

  final List<String> _isoStandards = [
    'ISO 9001 (Quality Management)',
    'ISO 14001 (Environmental)',
    'ISO 45001 (Occupational Health & Safety)',
    'ISO 27001 (Information Security)',
    'ISO 22000 (Food Safety)',
    'ISO 13485 (Medical Devices)',
    'Other Standard',
  ];

  @override
  void dispose() {
    _clientNameController.dispose();
    _businessNameController.dispose();
    _employeeStrengthController.dispose();
    _businessActivityController.dispose();
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
            'Business & Regulatory Registration Portal > ISO Registration',
            style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
          ),
          const SizedBox(height: 4),
          const Text(
            'ISO Quality Certification Form',
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
                        hint: 'Enter Contact person name',
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
                        hint: 'Enter Registered entity name',
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
                        label: 'ISO Standard*',
                        hint: 'Select target certification standard',
                        icon: Icons.verified_outlined,
                        value: _selectedIsoStandard,
                        items: _isoStandards,
                        onChanged: (v) => setState(() => _selectedIsoStandard = v),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Please select an ISO Standard';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildTextField(
                        label: 'Employee Strength*',
                        hint: 'Enter total number of employees',
                        icon: Icons.groups_outlined,
                        controller: _employeeStrengthController,
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Employee strength is required';
                          final val = int.tryParse(v.trim());
                          if (val == null || val <= 0) return 'Must be a positive integer';
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
            title: 'Business Activity / Operations',
            icon: Icons.assignment_outlined,
            child: _buildTextField(
              label: 'Business Activity*',
              hint: 'Describe primary business operations and scope of work',
              icon: Icons.edit_note_outlined,
              controller: _businessActivityController,
              maxLines: 3,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Business activity details are required';
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
                  helperText: 'Upload proof docs (Incorporation certificate, quality policies/manuals) – PDF/JPG/PNG, max 10MB',
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
                  'We have received your ISO Registration request. Our team will verify the documents and get back to you shortly.',
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
