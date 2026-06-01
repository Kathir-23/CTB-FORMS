import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class LegalFranchiseScreen extends StatefulWidget {
  const LegalFranchiseScreen({super.key});

  @override
  State<LegalFranchiseScreen> createState() => _LegalFranchiseScreenState();
}

class _LegalFranchiseScreenState extends State<LegalFranchiseScreen> {
  int _selectedNavIndex = 13;
  final _formKey = GlobalKey<FormState>();

  final _franchisorNameCtrl = TextEditingController();
  final _franchiseeNameCtrl = TextEditingController();
  final _businessPanCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _territoryCtrl = TextEditingController();
  final _durationCtrl = TextEditingController();
  final _feeCtrl = TextEditingController();
  final _royaltyCtrl = TextEditingController();
  final _ipClausesCtrl = TextEditingController();

  String? _businessType;
  String? _errBusinessType;

  String? _panFranchisorFile;
  String? _incorporationFile;
  String? _trademarkFile;
  String? _idAddressProofFile;
  String? _franchiseModelFile;

  @override
  void dispose() {
    _franchisorNameCtrl.dispose();
    _franchiseeNameCtrl.dispose();
    _businessPanCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _territoryCtrl.dispose();
    _durationCtrl.dispose();
    _feeCtrl.dispose();
    _royaltyCtrl.dispose();
    _ipClausesCtrl.dispose();
    super.dispose();
  }

  bool validateEmail(String? v) => v != null && RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(v);
  bool validatePhone(String? v) => v != null && RegExp(r'^\d{10}$').hasMatch(v);
  bool validatePan(String? v) => v != null && RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(v);

  void _submit() {
    setState(() {
      _errBusinessType = _businessType == null ? 'Please select a business type' : null;
    });
    if (!_formKey.currentState!.validate()) return;
    if (_errBusinessType != null) return;
    if (_panFranchisorFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PAN of Franchisor is required')),
      );
      return;
    }
    if (_incorporationFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Business Incorporation Certificate is required')),
      );
      return;
    }
    if (_trademarkFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Trademark / Brand Registration is required')),
      );
      return;
    }
    if (_idAddressProofFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ID & Address Proof is required')),
      );
      return;
    }
    if (_franchiseModelFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Franchise Model Document is required')),
      );
      return;
    }
    showLegalSuccessDialog(context, 'Franchise Agreement Drafting');
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeNavIndex: _selectedNavIndex,
      onNavChanged: (i) => setState(() => _selectedNavIndex = i),
      showBackButton: true,
      child: _selectedNavIndex == 13 ? _buildForm() : const Center(
        child: Text('Not built yet', style: TextStyle(fontSize: 18, color: AppColors.textMuted)),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GstBreadcrumb(path: 'Legal Services > Franchise Agreement'),
          const SizedBox(height: 4),
          const GstFormTitle(title: 'Franchise Agreement Drafting'),
          const SizedBox(height: 24),
          GstFormCard(title: 'Franchisor & Franchisee Information', icon: Icons.people, child: _buildPartyInfo()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Franchise Agreement Details', icon: Icons.description_outlined, child: _buildAgreementDetails()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Supporting Documents', icon: Icons.folder, child: _buildDocuments()),
          const SizedBox(height: 24),
          GstSubmitButton(onPressed: _submit),
        ],
      ),
    );
  }

  Widget _buildPartyInfo() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(
              label: 'Franchisor Name', hint: 'Full name of the franchisor', icon: Icons.person, required: true,
              controller: _franchisorNameCtrl,
              validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null,
            )),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(
              label: 'Franchisee Name', hint: 'Full name of the franchisee', icon: Icons.person_outline, required: true,
              controller: _franchiseeNameCtrl,
              validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null,
            )),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstDropdownField(
              label: 'Business Type', icon: Icons.business, required: true,
              value: _businessType,
              items: ['Retail', 'Food & Beverage', 'Education', 'Service', 'Other'],
              onChanged: (v) => setState(() { _businessType = v; _errBusinessType = null; }),
              errorText: _errBusinessType,
            )),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(
              label: 'Business PAN', hint: 'PAN of the franchisor entity', icon: Icons.badge, required: true,
              controller: _businessPanCtrl,
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validatePan(v) ? 'PAN format: 5 letters, 4 digits, 1 letter' : null),
            )),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(
              label: 'Contact Email', hint: 'Email address', icon: Icons.email, required: true,
              controller: _emailCtrl,
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validateEmail(v) ? 'Invalid email format' : null),
            )),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(
              label: 'Contact Number', hint: '10-digit mobile number', icon: Icons.phone, required: true,
              controller: _phoneCtrl, keyboardType: TextInputType.phone,
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validatePhone(v) ? 'Exactly 10 digits required' : null),
            )),
          ],
        ),
      ],
    );
  }

  Widget _buildAgreementDetails() {
    return Column(
      children: [
        GstTextareaField(
          label: 'Business Address', hint: 'Registered office address of franchisor (min 10 characters)', icon: Icons.location_on, required: true,
          controller: _addressCtrl, maxChars: 500,
          validator: (v) => v == null || v.trim().length < 10 ? 'Minimum 10 characters' : null,
        ),
        const SizedBox(height: 16),
        GstTextareaField(
          label: 'Franchise Territory', hint: 'Location or territory being granted to franchisee (min 10 characters)', icon: Icons.map, required: true,
          controller: _territoryCtrl, maxChars: 500,
          validator: (v) => v == null || v.trim().length < 10 ? 'Minimum 10 characters' : null,
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(
              label: 'Agreement Duration', hint: 'Number of years', icon: Icons.timer, required: true,
              controller: _durationCtrl, keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                final n = int.tryParse(v);
                if (n == null || n <= 0) return 'Must be a positive integer';
                return null;
              },
            )),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(
              label: 'Franchise Fee (INR)', hint: 'Initial one-time franchise fee amount', icon: Icons.money, required: true,
              controller: _feeCtrl, keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                final n = int.tryParse(v);
                if (n == null || n <= 0) return 'Must be a positive number';
                return null;
              },
            )),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(
              label: 'Royalty Percentage', hint: 'Percentage of sales payable as royalty', icon: Icons.percent, required: true,
              controller: _royaltyCtrl, keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                final n = int.tryParse(v);
                if (n == null || n < 1 || n > 100) return 'Must be 1 to 100 only';
                return null;
              },
            )),
            const SizedBox(width: 20),
            Expanded(child: SizedBox()),
          ],
        ),
        const SizedBox(height: 16),
        GstTextareaField(
          label: 'IP Protection Clauses', hint: 'IP and trademark protection details to be included (min 10 characters)', icon: Icons.copyright, required: true,
          controller: _ipClausesCtrl, maxChars: 500,
          validator: (v) => v == null || v.trim().length < 10 ? 'Minimum 10 characters' : null,
        ),
      ],
    );
  }

  Widget _buildDocuments() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(
              label: 'PAN of Franchisor', icon: Icons.badge, required: true,
              fileName: _panFranchisorFile, onFilePicked: (n) => _panFranchisorFile = n,
              acceptText: 'PDF only, max 10MB',
            )),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(
              label: 'Business Incorporation Certificate', icon: Icons.description, required: true,
              fileName: _incorporationFile, onFilePicked: (n) => _incorporationFile = n,
              acceptText: 'PDF only, max 10MB',
            )),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(
              label: 'Trademark / Brand Registration',               icon: Icons.verified, required: true,
              fileName: _trademarkFile, onFilePicked: (n) => _trademarkFile = n,
              acceptText: 'PDF only, max 10MB',
            )),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(
              label: 'ID & Address Proof', icon: Icons.credit_card, required: true,
              fileName: _idAddressProofFile, onFilePicked: (n) => _idAddressProofFile = n,
              acceptText: 'PDF/JPG/PNG, max 10MB',
            )),
          ],
        ),
        const SizedBox(height: 16),
        GstFileField(
          label: 'Franchise Model Document', icon: Icons.menu_book, required: true,
          fileName: _franchiseModelFile, onFilePicked: (n) => _franchiseModelFile = n,
          acceptText: 'PDF only, max 10MB',
        ),
      ],
    );
  }
}
