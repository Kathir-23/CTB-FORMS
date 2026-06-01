import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../theme/app_theme.dart';
import '../widgets/popups.dart';

class EmployeeComplianceScreen extends StatefulWidget {
  final int initialModule;

  const EmployeeComplianceScreen({super.key, this.initialModule = -1});

  @override
  State<EmployeeComplianceScreen> createState() => _EmployeeComplianceScreenState();
}

class _EmployeeComplianceScreenState extends State<EmployeeComplianceScreen> {
  int _selectedService = -1;
  int _hoveredCard = -1;
  int _pressedCard = -1;
  bool _showForm = false;
  bool _hoveringContinue = false;

  final _clientNameController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _businessAddressController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _businessPanController = TextEditingController();
  final _employerNameController = TextEditingController();
  final _contactEmailController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _gstNumberController = TextEditingController();
  final _noOfEmployeesController = TextEditingController();
  final _workingHoursController = TextEditingController();
  final _responsiblePersonController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _designationController = TextEditingController();
  final _tanPanController = TextEditingController();

  String _selectedBusinessType = '';

  @override
  void initState() {
    super.initState();
    if (widget.initialModule >= 0 && widget.initialModule < 4) {
      _selectedService = widget.initialModule;
    }
  }

  @override
  void dispose() {
    _clientNameController.dispose();
    _businessNameController.dispose();
    _businessAddressController.dispose();
    _pincodeController.dispose();
    _businessPanController.dispose();
    _employerNameController.dispose();
    _contactEmailController.dispose();
    _contactNumberController.dispose();
    _ownerNameController.dispose();
    _gstNumberController.dispose();
    _noOfEmployeesController.dispose();
    _workingHoursController.dispose();
    _responsiblePersonController.dispose();
    _fatherNameController.dispose();
    _designationController.dispose();
    _tanPanController.dispose();
    super.dispose();
  }

  static const _services = [
    _EmpService('PF Registration', 'Employee retirement & social security.', Icons.work, Color(0xFF3B82F6)),
    _EmpService('ESI Registration', 'Medical & employee welfare.', Icons.health_and_safety, Color(0xFF10B981)),
    _EmpService('Professional TAN', 'Tax deduction compliance.', Icons.receipt, Color(0xFFF97316)),
    _EmpService('Shop & Establishment', 'Business labor compliance.', Icons.storefront, Color(0xFF8B5CF6)),
  ];

  static const _businessTypes = [
    'Proprietorship', 'Partnership', 'Private Limited', 'LLP', 'NGO',
    'Retail', 'Wholesale', 'IT Office', 'Services',
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
          'Select a compliance service',
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
              Icons.business_center,
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
                          text: 'Employee ',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: 'Compliance',
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
                    'Expert compliance guidance for employee welfare & business regulations.',
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
                      'Employee compliance is essential for every business. Our experts handle PF, ESI, Professional Tax, and Shop & Establishment registrations seamlessly.',
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
                'Required documents — $serviceName',
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
              'Employee Compliance',
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
          _buildBusinessInfoCard(),
          const SizedBox(height: 24),
          if (_selectedService == 0) _buildPFForm(),
          if (_selectedService == 1) _buildESIForm(),
          if (_selectedService == 2) _buildTANForm(),
          if (_selectedService == 3) _buildShopForm(),
          const SizedBox(height: 36),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildBusinessInfoCard() {
    return _buildFormCard(
      'Business Information',
      Icons.business,
      Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildTextField('Client Name', 'Enter client name', _clientNameController)),
              const SizedBox(width: 20),
              Expanded(child: _buildTextField('Business Name', 'Enter business name', _businessNameController)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildDropdownField('Business Type')),
              const SizedBox(width: 20),
              Expanded(child: _buildTextField('Business Address', 'Enter business address', _businessAddressController)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildTextField('Pincode', 'Enter 6-digit pincode', _pincodeController)),
              const SizedBox(width: 20),
              Expanded(child: _buildTextField('Business PAN', 'Enter PAN (AAAAA0000A)', _businessPanController)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildTextField('Employer / Owner Name', 'Enter employer name', _employerNameController)),
              const SizedBox(width: 20),
              Expanded(child: _buildTextField('Contact Email', 'Enter email address', _contactEmailController)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildTextField('Contact Number', 'Enter 10-digit number', _contactNumberController)),
              const SizedBox(width: 20),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPFForm() {
    return Column(
      children: [
        _buildFormCard(
          'Employee List Upload',
          Icons.upload_file,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUploadField('Upload Employee List (CSV / XLSX, Max 5MB)', Icons.description),
              const SizedBox(height: 4),
              const Padding(
                padding: EdgeInsets.only(left: 2),
                child: Text(
                  'Allowed: CSV, XLSX | Max: 5MB',
                  style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildFormCard(
          'Supporting Documents Upload',
          Icons.folder_open,
          Column(
            children: [
              _buildUploadField('Upload Supporting Documents (PDF / PNG / JPG, Max 10MB)', Icons.folder),
              const SizedBox(height: 4),
              const Padding(
                padding: EdgeInsets.only(left: 2),
                child: Text(
                  'Allowed: PDF, PNG, JPG | Max: 10MB',
                  style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildESIForm() {
    return Column(
      children: [
        _buildFormCard(
          'Employee Details Sheet Upload',
          Icons.upload_file,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUploadField('Upload Employee Details Sheet (CSV / XLSX)', Icons.description),
              const SizedBox(height: 4),
              const Padding(
                padding: EdgeInsets.only(left: 2),
                child: Text(
                  'Allowed: CSV, XLSX',
                  style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildFormCard(
          'Supporting Documents Upload',
          Icons.folder_open,
          Column(
            children: [
              _buildUploadField('Upload Supporting Documents', Icons.folder),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTANForm() {
    return Column(
      children: [
        _buildFormCard(
          'Additional Information',
          Icons.person_outline,
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('PAN', 'Enter PAN number', _tanPanController)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildTextField('Responsible Person Name', 'Enter name', _responsiblePersonController)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('Father Name', 'Enter father name', _fatherNameController)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildTextField('Designation', 'Enter designation', _designationController)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildFormCard(
          'Supporting Documents Upload',
          Icons.folder_open,
          Column(
            children: [
              _buildUploadField('Upload Supporting Documents', Icons.folder),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildShopForm() {
    return Column(
      children: [
        _buildFormCard(
          'Additional Information',
          Icons.storefront,
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('GST Number (Optional)', 'Enter GSTIN', _gstNumberController)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildTextField('No. of Employees', 'Enter number', _noOfEmployeesController)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildTextField('Working Hours', 'e.g. 9:00 AM - 6:00 PM', _workingHoursController)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildTextField('Owner Name', 'Enter owner name', _ownerNameController)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildFormCard(
          'Supporting Documents Upload',
          Icons.folder_open,
          Column(
            children: [
              _buildUploadField('Upload Supporting Documents', Icons.folder),
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

  Widget _buildDropdownField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Business Type',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 48,
          child: GestureDetector(
            onTap: () => _showBusinessTypeDropdown(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedBusinessType.isEmpty ? '-- Select --' : _selectedBusinessType,
                      style: TextStyle(
                        color: _selectedBusinessType.isEmpty
                            ? const Color(0xFF94A3B8)
                            : const Color(0xFF1E293B),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Color(0xFF94A3B8), size: 22),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showBusinessTypeDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Select Business Type',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ),
              const Divider(height: 1, color: Color(0xFFE2E8F0)),
              ..._businessTypes.map((type) => ListTile(
                title: Text(type, style: const TextStyle(fontSize: 15)),
                trailing: _selectedBusinessType == type
                    ? const Icon(Icons.check, color: Color(0xFF3B82F6), size: 20)
                    : null,
                onTap: () {
                  setState(() => _selectedBusinessType = type);
                  Navigator.of(ctx).pop();
                },
              )),
            ],
          ),
        );
      },
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
              await FilePicker.platform.pickFiles();
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
        child: GestureDetector(
          onTap: () => _showSuccessDialog(),
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
      case 0: return 'PF Registration';
      case 1: return 'ESI Registration';
      case 2: return 'Professional TAN';
      case 3: return 'Shop & Establishment';
      default: return '';
    }
  }

  List<String> _getLeftDocs() {
    switch (_selectedService) {
      case 0:
        return ['PAN Card Business/Employer', 'Incorporation Certificate / Partnership Deed / Shop Act License', 'Address Proof'];
      case 1:
        return ['PAN Card', 'Business Registration Proof', 'Address Proof'];
      case 2:
        return ['PAN Card Business', 'Proof of Business'];
      case 3:
        return ['PAN Card', 'Business Proof', 'Address Proof'];
      default:
        return [];
    }
  }

  List<String> _getRightDocs() {
    switch (_selectedService) {
      case 0:
        return ['Cancelled Cheque', 'Employee Excel Sheet', 'DSC Upload (Optional)'];
      case 1:
        return ['Bank Statement', 'Passport Photo Employer'];
      case 2:
        return ['Address Proof'];
      case 3:
        return ['Identity Proof', 'Employee List'];
      default:
        return [];
    }
  }
}

class _EmpService {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _EmpService(this.title, this.subtitle, this.icon, this.color);
}
