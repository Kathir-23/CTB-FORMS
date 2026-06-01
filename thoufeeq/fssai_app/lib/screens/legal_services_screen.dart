import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../theme/app_theme.dart';
import '../widgets/popups.dart';

class LegalServicesScreen extends StatefulWidget {
  const LegalServicesScreen({super.key});

  @override
  State<LegalServicesScreen> createState() => _LegalServicesScreenState();
}

class _LegalServicesScreenState extends State<LegalServicesScreen> {
  int _selectedService = -1;
  int _hoveredCard = -1;
  int _pressedCard = -1;
  bool _showForm = false;
  bool _hoveringContinue = false;


  final _clientNameController = TextEditingController();
  final _businessTypeController = TextEditingController();
  final _businessPanController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _ndaConfidentialityDurationController = TextEditingController();
  final _ndaPartiesInvolvedController = TextEditingController();
  final _ndaBusinessAddressController = TextEditingController();

  final _legalKeyClausesController = TextEditingController();
  final _legalClauseLibraryController = TextEditingController();
  final _legalEffectiveDateController = TextEditingController();
  final _legalContactPersonController = TextEditingController();

  final _franchiseFranchisorNameController = TextEditingController();
  final _franchiseFranchiseeNameController = TextEditingController();
  final _franchiseBusinessTypeController = TextEditingController();
  final _franchiseBusinessPanController = TextEditingController();
  final _franchiseGstinController = TextEditingController();
  final _franchiseTrademarkNumberController = TextEditingController();
  final _franchiseBusinessAddressController = TextEditingController();
  final _franchiseTerritoryController = TextEditingController();
  final _franchiseAgreementDurationController = TextEditingController();
  final _franchiseFeeController = TextEditingController();
  final _franchiseRoyaltyPercentageController = TextEditingController();
  final _franchiseIpClausesController = TextEditingController();
  final _franchiseEmailController = TextEditingController();
  final _franchisePhoneController = TextEditingController();

  String? _ndaAgreementType;
  String? _ndaDataClassification;
  String? _ndaPriority;
  String? _legalAgreementType;
  String? _legalPriority;

  static const _ndaAgreementTypes = [
    'One Way NDA',
    'Mutual NDA',
    'Multi Party NDA',
    'Employee NDA',
    'Vendor NDA',
    'Investor NDA',
  ];

  static const _dataClassifications = [
    'No Personal Data',
    'Customer Data',
    'Employee Data',
    'Financial Data',
  ];

  static const _priorities = ['Standard', 'Urgent', 'Critical'];

  static const _legalAgreementTypes = [
    'Partnership',
    'Service',
    'Vendor',
    'Client',
    'Employment',
    'Freelancer',
    'Consultancy',
    'SaaS',
    'Software Development',
    'Digital Marketing',
    'Influencer',
  ];

  @override
  void dispose() {
    _clientNameController.dispose();
    _businessTypeController.dispose();
    _businessPanController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _ndaConfidentialityDurationController.dispose();
    _ndaPartiesInvolvedController.dispose();
    _ndaBusinessAddressController.dispose();
    _legalKeyClausesController.dispose();
    _legalClauseLibraryController.dispose();
    _legalEffectiveDateController.dispose();
    _legalContactPersonController.dispose();
    _franchiseFranchisorNameController.dispose();
    _franchiseFranchiseeNameController.dispose();
    _franchiseBusinessTypeController.dispose();
    _franchiseBusinessPanController.dispose();
    _franchiseGstinController.dispose();
    _franchiseTrademarkNumberController.dispose();
    _franchiseBusinessAddressController.dispose();
    _franchiseTerritoryController.dispose();
    _franchiseAgreementDurationController.dispose();
    _franchiseFeeController.dispose();
    _franchiseRoyaltyPercentageController.dispose();
    _franchiseIpClausesController.dispose();
    _franchiseEmailController.dispose();
    _franchisePhoneController.dispose();
    super.dispose();
  }

  static const _services = [
    _LegalService('NDA Service', 'Protect confidential business information', Icons.shield, Color(0xFF3B82F6)),
    _LegalService('Legal Agreement Drafting', 'Business agreement drafting', Icons.description, Color(0xFF8B5CF6)),
    _LegalService('Franchise Agreement Drafting', 'Franchise legal contracts', Icons.business_center, Color(0xFFF97316)),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _showForm ? _buildFormContent() : _buildDashboardContent(),
    );
  }

  Widget _buildDashboardContent() {
    return Column(
      key: const ValueKey('dashboard'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderCard(),
        const SizedBox(height: 36),
        const Text(
          'Select a Legal service',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        _buildServiceCardsSection(),
        if (_selectedService != -1) ...[
          const SizedBox(height: 28),
          _buildDocumentsCard(),
          const SizedBox(height: 36),
          _buildContinueButton(),
        ],
      ],
    );
  }

  Widget _buildHeaderCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.assignment_outlined,
              color: Color(0xFF3B82F6),
              size: 40,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Legal ',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: 'Services',
                          style: TextStyle(
                            color: Color(0xFF3B82F6),
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Expert legal documentation and compliance services.',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F9FF),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            border: const Border(
              left: BorderSide(
                color: Color(0xFF3B82F6),
                width: 4,
              ),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.check_box_outlined,
                  color: Color(0xFF3B82F6),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Legal compliance can be complex and overwhelming for many businesses. Our experts simplify NDA, agreement drafting, and franchise legal processes.',
                      style: TextStyle(
                        color: Color(0xFF475569),
                        fontSize: 14,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCardsSection() {
    return SizedBox(
      height: 180,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicHeight(
          child: Row(
            children: List.generate(_services.length, (i) {
              return Padding(
                padding: EdgeInsets.only(right: i < _services.length - 1 ? 24 : 0),
                child: _buildServiceCard(i),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(int index) {
    final service = _services[index];
    final isSelected = _selectedService == index;
    final isHovered = _hoveredCard == index;
    final isPressed = _pressedCard == index;

    final bgColor = isSelected ? const Color(0xFF2D3A6B) : Colors.white;
    final borderColor = isSelected
        ? const Color(0xFF2D3A6B)
        : (isHovered ? const Color(0xFFCBD5E1) : const Color(0xFFE2E8F0));
    final titleColor = isSelected ? Colors.white : const Color(0xFF1E293B);
    final subtitleColor = isSelected
        ? Colors.white.withAlpha(166)
        : const Color(0xFF94A3B8);
    final effectiveIconColor = isSelected ? Colors.white : service.color;

    Matrix4 getTransform() {
      if (isPressed) return Matrix4.diagonal3Values(0.97, 0.97, 1.0);
      if (isHovered) return Matrix4.diagonal3Values(1.03, 1.03, 1.0);
      return Matrix4.identity();
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveredCard = index),
      onExit: (_) => setState(() => _hoveredCard = -1),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressedCard = index),
        onTapUp: (_) {
          setState(() {
            _pressedCard = -1;
            _selectedService = index;
            _showForm = false;
          });
        },
        onTapCancel: () => setState(() => _pressedCard = -1),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: getTransform(),
          transformAlignment: Alignment.center,
          width: 280,
          height: 180,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: borderColor, width: 1),
            boxShadow: isHovered && !isSelected
                ? [
                    const BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(service.icon, color: effectiveIconColor, size: 24),
              const SizedBox(height: 12),
              Text(
                service.title,
                style: TextStyle(
                  color: titleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                service.subtitle,
                style: TextStyle(
                  color: subtitleColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentsCard() {
    final allDocs = [..._getLeftDocs(), ..._getRightDocs()];
    final docCount = allDocs.length;
    final serviceName = _getServiceLabel();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified_outlined,
                  color: Color(0xFF3B82F6),
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Required documents \u2014 $serviceName',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$docCount documents',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3B82F6),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDocumentGrid(),
        ],
      ),
    );
  }

  Widget _buildDocumentGrid() {
    final leftDocs = _getLeftDocs();
    final rightDocs = _getRightDocs();
    final maxRows = leftDocs.length > rightDocs.length ? leftDocs.length : rightDocs.length;

    return Column(
      children: List.generate(maxRows, (i) {
        final leftDoc = i < leftDocs.length ? leftDocs[i] : null;
        final rightDoc = i < rightDocs.length ? rightDocs[i] : null;
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              if (leftDoc != null) Expanded(child: _buildDocumentTile(leftDoc))
              else const Expanded(child: SizedBox()),
              const SizedBox(width: 10),
              if (rightDoc != null) Expanded(child: _buildDocumentTile(rightDoc))
              else const Expanded(child: SizedBox()),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDocumentTile(String docName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(
              color: Color(0xFFEFF6FF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Color(0xFF3B82F6),
              size: 14,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              docName,
              style: const TextStyle(
                color: Color(0xFF475569),
                fontSize: 13.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hoveringContinue = true),
        onExit: (_) => setState(() => _hoveringContinue = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 280,
          height: 54,
          decoration: BoxDecoration(
            color: _hoveringContinue
                ? const Color(0xFF3D4F72)
                : const Color(0xFF2E3A59),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2E3A59).withAlpha(80),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(32),
              onTap: () => _showUserDetailsDialog(),
              child: const Center(
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormContent() {
    final service = _services[_selectedService >= 0 ? _selectedService : 0];
    return SingleChildScrollView(
      key: const ValueKey('form'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => setState(() => _showForm = false),
            child: const Text(
              'Legal Services',
              style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${service.title} Form',
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 28),
          _buildFormContentForService(),
          const SizedBox(height: 36),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildFormContentForService() {
    switch (_selectedService) {
      case 0:
        return _buildNdaForm();
      case 1:
        return _buildLegalAgreementForm();
      case 2:
        return _buildFranchiseForm();
      default:
        return const SizedBox();
    }
  }

  Widget _buildNdaForm() {
    return Column(
      children: [
        _buildFormCard(
          'Business Information',
          Icons.business,
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('Client Name', 'Enter client name', _clientNameController)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildTextField('Business Type', 'Enter business type', _businessTypeController)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('Business PAN', 'Enter PAN', _businessPanController)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildDropdownField('Agreement Type', _ndaAgreementType, _ndaAgreementTypes, (v) {
                    setState(() => _ndaAgreementType = v);
                  })),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('Confidentiality Duration', 'e.g. 2 years', _ndaConfidentialityDurationController)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildDropdownField('Data Classification', _ndaDataClassification, _dataClassifications, (v) {
                    setState(() => _ndaDataClassification = v);
                  })),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('Parties Involved', 'Enter parties involved', _ndaPartiesInvolvedController)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildTextField('Business Address', 'Enter business address', _ndaBusinessAddressController)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('Contact Email', 'Enter email address', _emailController)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildTextField('Contact Number', 'Enter contact number', _phoneController)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildDropdownField('Priority', _ndaPriority, _priorities, (v) {
                    setState(() => _ndaPriority = v);
                  })),
                  const SizedBox(width: 20),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildFormCard(
          'Document Upload',
          Icons.upload_file,
          Column(
            children: [
              _buildUploadField('Upload Legal Related Documents', Icons.description),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegalAgreementForm() {
    return Column(
      children: [
        _buildFormCard(
          'Business Information',
          Icons.business,
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('Client Name', 'Enter client name', _clientNameController)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildTextField('Business Type', 'Enter business type', _businessTypeController)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('Business PAN', 'Enter PAN', _businessPanController)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildDropdownField('Agreement Type', _legalAgreementType, _legalAgreementTypes, (v) {
                    setState(() => _legalAgreementType = v);
                  })),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('Key Clauses', 'Enter key clauses', _legalKeyClausesController)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildTextField('Clause Library', 'Enter clause references', _legalClauseLibraryController)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('Effective Date', 'Select effective date', _legalEffectiveDateController)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildTextField('Contact Person', 'Enter contact person', _legalContactPersonController)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('Email', 'Enter email address', _emailController)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildTextField('Phone', 'Enter phone number', _phoneController)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildDropdownField('Priority', _legalPriority, _priorities, (v) {
                    setState(() => _legalPriority = v);
                  })),
                  const SizedBox(width: 20),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildFormCard(
          'Document Upload',
          Icons.upload_file,
          Column(
            children: [
              _buildUploadField('Upload Legal Related Documents', Icons.description),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFranchiseForm() {
    return Column(
      children: [
        _buildFormCard(
          'Business Information',
          Icons.business,
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('Franchisor Name', 'Enter franchisor name', _franchiseFranchisorNameController)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildTextField('Franchisee Name', 'Enter franchisee name', _franchiseFranchiseeNameController)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('Business Type', 'Enter business type', _franchiseBusinessTypeController)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildTextField('Business PAN', 'Enter PAN', _franchiseBusinessPanController)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('GSTIN', 'Enter GSTIN', _franchiseGstinController)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildTextField('Trademark Number', 'Enter trademark number', _franchiseTrademarkNumberController)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('Business Address', 'Enter business address', _franchiseBusinessAddressController)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildTextField('Franchise Territory', 'Enter territory', _franchiseTerritoryController)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('Agreement Duration', 'e.g. 5 years', _franchiseAgreementDurationController)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildTextField('Franchise Fee', 'Enter fee amount', _franchiseFeeController)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('Royalty Percentage', 'e.g. 5%', _franchiseRoyaltyPercentageController)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildTextField('IP Protection Clauses', 'Enter IP clauses', _franchiseIpClausesController)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('Email', 'Enter email address', _franchiseEmailController)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildTextField('Phone', 'Enter phone number', _franchisePhoneController)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildFormCard(
          'Document Upload',
          Icons.upload_file,
          Column(
            children: [
              _buildUploadField('Upload Legal Related Documents', Icons.description),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFormCard(String title, IconData icon, Widget child) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: const Color(0xFF64748B)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1E293B),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(height: 1, color: const Color(0xFFF1F5F9)),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 48,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.brandBlue, width: 2),
              ),
              filled: true,
              fillColor: AppColors.white,
            ),
            style: const TextStyle(fontSize: 15, color: Color(0xFF1E293B)),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, String? value, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 48,
            child: DropdownButtonFormField<String>(
            initialValue: value,
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 15, color: Color(0xFF1E293B)),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: '-- Select --',
              hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.brandBlue, width: 2),
              ),
              filled: true,
              fillColor: AppColors.white,
            ),
            style: const TextStyle(fontSize: 15, color: Color(0xFF1E293B)),
            icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF94A3B8)),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadField(String label, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () async {
              await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf', 'png', 'jpg', 'docx'],
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD1D5DB),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        bottomLeft: Radius.circular(7),
                      ),
                      border: Border(
                        right: BorderSide(color: Color(0xFFCBD5E1)),
                      ),
                    ),
                    child: Icon(icon, size: 18, color: const Color(0xFF6B7280)),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Choose files',
                    style: TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 280,
          height: 54,
          decoration: BoxDecoration(
            color: const Color(0xFF2E3A59),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2E3A59).withAlpha(80),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(32),
              onTap: () => _showSuccessDialog(),
              child: const Center(
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showUserDetailsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => UserDetailsPopup(
        onSubmitted: () {
          setState(() => _showForm = true);
        },
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => SuccessPopup(
        onBackToServices: () {
          setState(() {
            _showForm = false;
            _selectedService = -1;
          });
        },
      ),
    );
  }

  String _getServiceLabel() {
    switch (_selectedService) {
      case 0: return 'NDA Service';
      case 1: return 'Legal Agreement Drafting';
      case 2: return 'Franchise Agreement Drafting';
      default: return '';
    }
  }

  List<String> _getLeftDocs() {
    switch (_selectedService) {
      case 0:
        return ['PAN Card', 'Business Registration Certificate', 'Identity Proof'];
      case 1:
        return ['PAN Card', 'Business Registration', 'Identity Proof', 'Address Proof'];
      case 2:
        return ['PAN Card', 'Trademark Certificate', 'Business Registration', 'Identity Proof'];
      default:
        return [];
    }
  }

  List<String> _getRightDocs() {
    switch (_selectedService) {
      case 0:
        return ['Address Proof', 'Privacy Policy', 'Data Handling SOP'];
      case 1:
        return ['Memorandum of Understanding', 'Draft Agreement', 'Fee Structure'];
      case 2:
        return ['Franchise Disclosure Document', 'Financial Statements', 'GST Registration'];
      default:
        return [];
    }
  }
}

class _LegalService {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _LegalService(this.title, this.subtitle, this.icon, this.color);
}
