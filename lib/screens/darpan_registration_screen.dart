import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class DarpanRegistrationScreen extends StatefulWidget {
  const DarpanRegistrationScreen({super.key});

  @override
  State<DarpanRegistrationScreen> createState() => _DarpanRegistrationScreenState();
}

class _DarpanRegistrationScreenState extends State<DarpanRegistrationScreen> {
  int _selectedNavIndex = 16;
  final _formKey = GlobalKey<FormState>();
  final _ngoNameCtrl = TextEditingController();
  final _registrationNoCtrl = TextEditingController();
  final _ngoPanCtrl = TextEditingController();
  final _bankDetailsCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  String? _ngoType;
  DateTime? _dateOfRegistration;

  static const _ngoTypes = ['Trust', 'Society', 'Section 8', 'Other'];

  @override
  void dispose() {
    _ngoNameCtrl.dispose();
    _registrationNoCtrl.dispose();
    _ngoPanCtrl.dispose();
    _bankDetailsCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  bool _validateEmail(String v) => RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(v);
  bool _validatePhone(String v) => RegExp(r'^\d{10}$').hasMatch(v);

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateOfRegistration ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _dateOfRegistration = picked);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_ngoType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select NGO type')),
      );
      return;
    }
    if (_dateOfRegistration == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select date of registration')),
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
                  const GstBreadcrumb(path: 'Business & Regulatory Registration > Darpan Registration'),
                  const SizedBox(height: 4),
                  const GstFormTitle(title: 'Darpan (NGO) Registration'),
                  const SizedBox(height: 24),
                  GstFormCard(title: 'NGO Information', icon: Icons.volunteer_activism, child: _buildNgoInfo()),
                  const SizedBox(height: 16),
                  GstFormCard(title: 'Registration Details', icon: Icons.description_outlined, child: _buildRegistrationDetails()),
                  const SizedBox(height: 16),
                  GstFormCard(title: 'Bank & Contact', icon: Icons.contact_mail, child: _buildBankContact()),
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

  Widget _buildNgoInfo() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildTextField('NGO Name', 'Enter NGO name', Icons.volunteer_activism, _ngoNameCtrl, required: true)),
            const SizedBox(width: 20),
            Expanded(child: GstDropdownField(
              label: 'NGO Type',
              icon: Icons.category_outlined,
              items: _ngoTypes,
              value: _ngoType,
              onChanged: (v) {
                setState(() => _ngoType = v);
              },
              required: true,
              placeholder: '-- Select --',
            )),
          ],
        ),
      ],
    );
  }

  Widget _buildRegistrationDetails() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildTextField('Registration No.', 'Enter registration number', Icons.numbers, _registrationNoCtrl, required: true)),
            const SizedBox(width: 20),
            Expanded(child: _buildDatePickerField('Date of Registration', Icons.calendar_today, _dateOfRegistration, _pickDate, required: true)),
          ],
        ),
        const SizedBox(height: 16),
        _buildTextField('NGO PAN', 'Enter NGO PAN number', Icons.credit_card_outlined, _ngoPanCtrl, required: true),
      ],
    );
  }

  Widget _buildBankContact() {
    return Column(
      children: [
        _buildTextField('Bank Details', 'Enter bank account details', Icons.account_balance, _bankDetailsCtrl, required: true),
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

  Widget _buildDatePickerField(
    String label,
    IconData icon,
    DateTime? date,
    VoidCallback onTap, {
    bool required = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label, required: required),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Icon(icon, size: 16, color: const Color(0xFF94A3B8)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    date != null
                        ? '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}'
                        : 'Select date',
                    style: TextStyle(
                      color: date != null ? const Color(0xFF374151) : const Color(0xFF9CA3AF),
                      fontSize: 14,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Color(0xFF94A3B8), size: 22),
              ],
            ),
          ),
        ),
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
                  'We have received your Darpan registration request. Our team will review and get back to you shortly.',
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
