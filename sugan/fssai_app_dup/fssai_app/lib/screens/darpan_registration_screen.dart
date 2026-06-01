import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/form_fields.dart';

class DarpanRegistrationScreen extends StatefulWidget {
  const DarpanRegistrationScreen({super.key});

  @override
  State<DarpanRegistrationScreen> createState() => _DarpanRegistrationScreenState();
}

class _DarpanRegistrationScreenState extends State<DarpanRegistrationScreen> {
  int _selectedNavIndex = 13;
  final _formKey = GlobalKey<FormState>();
  bool _hoveringSubmit = false;

  final _ngoNameController = TextEditingController();
  final _regNoController = TextEditingController();
  final _dateController = TextEditingController();
  final _panController = TextEditingController();
  final _bankDetailsController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();

  String? _selectedType;
  DateTime? _selectedDate;

  final List<String> _types = ['Trust', 'Society', 'Section 8', 'Other'];

  @override
  void dispose() {
    _ngoNameController.dispose();
    _regNoController.dispose();
    _dateController.dispose();
    _panController.dispose();
    _bankDetailsController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      });
    }
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
          const Text('Business & Regulatory Registration Portal > Darpan Registration', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
          const SizedBox(height: 4),
          const Text('Darpan (NGO) Registration Form', style: TextStyle(color: Color(0xFF0F172A), fontSize: 22, fontWeight: FontWeight.w600)),
          const SizedBox(height: 24),

          FormCard(
            title: 'NGO Details',
            icon: Icons.account_balance_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'NGO Name*',
                        hint: 'Registered NGO name',
                        controller: _ngoNameController,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'NGO name is required';
                          if (v.trim().length < 3) return 'Min 3 characters';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildDropdown(
                        label: 'NGO Type*',
                        value: _selectedType,
                        items: _types,
                        onChanged: (v) => setState(() => _selectedType = v),
                        validator: (v) => (v == null || v.isEmpty) ? 'Must select' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'Registration No.*',
                        hint: 'NGO registration no.',
                        controller: _regNoController,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Registration no. is required';
                          final re = RegExp(r'^[a-zA-Z0-9\-\/ ]+\$');
                          if (!re.hasMatch(v.trim())) return 'Alphanumeric';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildTextField(
                        label: 'Date of Registration*',
                        hint: 'DD/MM/YYYY',
                        controller: _dateController,
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Date is required';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  label: 'NGO PAN*',
                  hint: 'PAN',
                  controller: _panController,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'PAN is required';
                    final panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}\$');
                    if (!panRegex.hasMatch(v.trim().toUpperCase())) return 'PAN regex';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                _buildTextArea(
                  label: 'Bank Details*',
                  hint: 'Bank name, IFSC, account no.',
                  controller: _bankDetailsController,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Bank details required';
                    return null;
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          FormCard(
            title: 'Contact & Communication',
            icon: Icons.contact_mail_outlined,
            child: Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    label: 'Contact Email*',
                    hint: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Email required';
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
                      if (v == null || v.trim().isEmpty) return 'Contact number required';
                      if (v.trim().length != 10 || int.tryParse(v.trim()) == null) return '10 digits';
                      return null;
                    },
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
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    VoidCallback? onTap,
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
          readOnly: readOnly,
          onTap: onTap,
          maxLines: 1,
          decoration: InputDecoration(hintText: hint, contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)), filled: true, fillColor: Colors.white),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildTextArea({
    required String label,
    required String hint,
    required TextEditingController controller,
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
        TextFormField(
          controller: controller,
          validator: validator,
          maxLines: 3,
          decoration: InputDecoration(hintText: hint, contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)), filled: true, fillColor: Colors.white),
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
          decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)), filled: true, fillColor: Colors.white),
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
            if (valid) _showSuccessDialog();
          },
          style: ElevatedButton.styleFrom(backgroundColor: _hoveringSubmit ? const Color(0xFF4A59D0) : AppColors.brandBlue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
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
              const Text('We have received your Darpan registration request. Our team will verify and respond shortly.', style: TextStyle(color: Color(0xFF64748B), fontSize: 14), textAlign: TextAlign.center),
              const SizedBox(height: 28),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () { Navigator.of(ctx).pop(); Navigator.of(context).pop(); }, style: ElevatedButton.styleFrom(backgroundColor: AppColors.brandBlue, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0), child: const Text('Back to Services', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)))),
            ]),
          ),
        );
      },
    );
  }
}
