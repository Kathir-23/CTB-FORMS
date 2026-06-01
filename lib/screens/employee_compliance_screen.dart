import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/gst_form_fields.dart';

class EmployeeComplianceScreen extends StatefulWidget {
  const EmployeeComplianceScreen({super.key});

  @override
  State<EmployeeComplianceScreen> createState() => _EmployeeComplianceScreenState();
}

class _EmployeeComplianceScreenState extends State<EmployeeComplianceScreen> {
  int _selectedService = 0;
  int _hoveredCard = -1;
  int _pressedCard = -1;
  bool _showForm = false;
  bool _hoveringContinue = false;

  final ScrollController _scrollController = ScrollController();

  final _formKey = GlobalKey<FormState>();

  final _clientNameCtrl = TextEditingController();
  final _businessNameCtrl = TextEditingController();
  final _businessAddressCtrl = TextEditingController();
  final _pincodeCtrl = TextEditingController();
  final _businessPanCtrl = TextEditingController();
  final _employerNameCtrl = TextEditingController();
  final _contactEmailCtrl = TextEditingController();
  final _contactNumberCtrl = TextEditingController();
  final _ownerNameCtrl = TextEditingController();
  final _gstNumberCtrl = TextEditingController();
  final _noOfEmployeesCtrl = TextEditingController();
  final _workingHoursCtrl = TextEditingController();
  final _tanPanCtrl = TextEditingController();
  final _responsiblePersonCtrl = TextEditingController();
  final _fatherNameCtrl = TextEditingController();
  final _designationCtrl = TextEditingController();

  String _selectedBusinessType = '';
  String? _pfEmployeeListFile;
  String? _pfSupportingDocsFile;
  String? _esiEmployeeSheetFile;
  String? _esiSupportingDocsFile;
  String? _tanSupportingDocsFile;
  String? _shopSupportingDocsFile;

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

  static const _documentsByService = [
    ['PAN Card Business/Employer', 'Incorporation Certificate', 'Address Proof', 'Cancelled Cheque', 'Employee Excel Sheet'],
    ['PAN Card', 'Business Registration Proof', 'Address Proof', 'Bank Statement', 'Passport Photo Employer'],
    ['PAN Card Business', 'Proof of Business', 'Address Proof'],
    ['PAN Card', 'Business Proof', 'Address Proof', 'Identity Proof', 'Employee List'],
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    _clientNameCtrl.dispose();
    _businessNameCtrl.dispose();
    _businessAddressCtrl.dispose();
    _pincodeCtrl.dispose();
    _businessPanCtrl.dispose();
    _employerNameCtrl.dispose();
    _contactEmailCtrl.dispose();
    _contactNumberCtrl.dispose();
    _ownerNameCtrl.dispose();
    _gstNumberCtrl.dispose();
    _noOfEmployeesCtrl.dispose();
    _workingHoursCtrl.dispose();
    _tanPanCtrl.dispose();
    _responsiblePersonCtrl.dispose();
    _fatherNameCtrl.dispose();
    _designationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _showForm ? _buildFormView() : _buildLandingView(),
    );
  }

  Widget _buildLandingView() {
    return SingleChildScrollView(
      key: const ValueKey('landing'),
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 36),
          const Text(
            'Select a compliance service',
            style: TextStyle(color: Color(0xFF1E293B), fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          _buildServiceCards(),
          if (_selectedService >= 0) ...[
            const SizedBox(height: 28),
            _buildDocumentsCard(),
            const SizedBox(height: 36),
            _buildContinueButton(),
          ],
          const SizedBox(height: 36),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.business_center, color: Color(0xFF3B82F6), size: 40),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(text: 'Employee ', style: TextStyle(color: Color(0xFF000000), fontSize: 28, fontWeight: FontWeight.w800)),
                        TextSpan(text: 'Compliance', style: TextStyle(color: Color(0xFF3B82F6), fontSize: 28, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Expert compliance guidance for employee welfare & business regulations.',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
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
            borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
            border: const Border(left: BorderSide(color: Color(0xFF3B82F6), width: 4)),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 2), child: Icon(Icons.check_box_outlined, color: Color(0xFF3B82F6), size: 22)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Employee compliance is essential for every business. Our experts handle PF, ESI, Professional Tax, and Shop & Establishment registrations seamlessly.',
                      style: TextStyle(color: Color(0xFF475569), fontSize: 14, height: 1.45),
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

  Widget _buildServiceCards() {
    return SizedBox(
      height: 180,
      child: Row(
        children: [
          _buildArrowButton(Icons.chevron_left, () {
            final offset = _scrollController.offset;
            _scrollController.animateTo(
              (offset - 280).clamp(0.0, _scrollController.position.maxScrollExtent),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }),
          const SizedBox(width: 8),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
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
          ),
          const SizedBox(width: 8),
          _buildArrowButton(Icons.chevron_right, () {
            final offset = _scrollController.offset;
            _scrollController.animateTo(
              (offset + 280).clamp(0.0, _scrollController.position.maxScrollExtent),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildArrowButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2))],
          ),
          child: Icon(icon, color: const Color(0xFF475569), size: 22),
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
    final borderColor = isSelected ? const Color(0xFF2D3A6B) : (isHovered ? const Color(0xFFCBD5E1) : const Color(0xFFE2E8F0));
    final titleColor = isSelected ? Colors.white : const Color(0xFF1E293B);
    final subtitleColor = isSelected ? Colors.white.withAlpha(166) : const Color(0xFF94A3B8);
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
          setState(() { _pressedCard = -1; _selectedService = index; _showForm = false; });
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
                ? const [BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 4))]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(service.icon, color: effectiveIconColor, size: 24),
              const SizedBox(height: 12),
              Text(service.title, style: TextStyle(color: titleColor, fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(service.subtitle, style: TextStyle(color: subtitleColor, fontSize: 13, fontWeight: FontWeight.w400)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentsCard() {
    final docs = _documentsByService[_selectedService];
    final leftDocs = docs.length > 2 ? docs.sublist(0, (docs.length + 1) ~/ 2) : (docs.isNotEmpty ? [docs[0]] : <String>[]);
    final rightDocs = docs.length > 2 ? docs.sublist((docs.length + 1) ~/ 2) : (docs.length > 1 ? [docs[1]] : <String>[]);
    final serviceName = _services[_selectedService].title;

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
                width: 32, height: 32,
                decoration: const BoxDecoration(color: Color(0xFFEFF6FF), shape: BoxShape.circle),
                child: const Icon(Icons.verified_outlined, color: Color(0xFF3B82F6), size: 18),
              ),
              const SizedBox(width: 12),
              Text('Required documents — $serviceName', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: const BoxDecoration(color: Color(0xFFEFF6FF), borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text('${docs.length} documents', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF3B82F6))),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDocGrid(leftDocs, rightDocs),
        ],
      ),
    );
  }

  Widget _buildDocGrid(List<String> leftDocs, List<String> rightDocs) {
    final maxRows = leftDocs.length > rightDocs.length ? leftDocs.length : rightDocs.length;
    return Column(
      children: List.generate(maxRows, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              if (i < leftDocs.length) Expanded(child: _buildDocTile(leftDocs[i]))
              else const Expanded(child: SizedBox()),
              const SizedBox(width: 10),
              if (i < rightDocs.length) Expanded(child: _buildDocTile(rightDocs[i]))
              else const Expanded(child: SizedBox()),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDocTile(String docName) {
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
            width: 26, height: 26,
            decoration: const BoxDecoration(color: Color(0xFFEFF6FF), shape: BoxShape.circle),
            child: const Icon(Icons.check, color: Color(0xFF3B82F6), size: 14),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(docName, style: const TextStyle(color: Color(0xFF475569), fontSize: 13.5, fontWeight: FontWeight.w400))),
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
        child: GestureDetector(
          onTap: () => _showUserDetailsDialog(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 280,
            height: 54,
            decoration: BoxDecoration(
              color: _hoveringContinue ? const Color(0xFF3D4F72) : const Color(0xFF2E3A59),
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(color: const Color(0xFF2E3A59).withAlpha(80), blurRadius: 20, offset: const Offset(0, 6)),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(32),
                onTap: () => _showUserDetailsDialog(),
                child: const Center(child: Text('Continue', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.3))),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showUserDetailsDialog() {
    final nameCtrl = TextEditingController();
    final mobileCtrl = TextEditingController();
    final emailCtrl = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          backgroundColor: AppColors.bgCard,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          child: SizedBox(
            width: 520,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Text('User Details', style: TextStyle(color: Color(0xFF1A1F2E), fontSize: 20, fontWeight: FontWeight.w700))),
                  const Divider(height: 24, color: AppColors.border),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildDialogField('User Name', 'Enter your name', nameCtrl)),
                      const SizedBox(width: 20),
                      Expanded(child: _buildDialogField('Mobile Number', 'Enter Mobile Number', mobileCtrl)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildDialogField('Mail Address', 'Enter Mail Address', emailCtrl),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (nameCtrl.text.trim().isEmpty || mobileCtrl.text.trim().isEmpty || emailCtrl.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
                          return;
                        }
                        Navigator.of(ctx).pop();
                        setState(() => _showForm = true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brandBlue,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                      child: const Text('Submit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        SizedBox(
          height: 48,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.brandBlue, width: 2)),
              filled: true,
              fillColor: AppColors.white,
            ),
            style: const TextStyle(fontSize: 15, color: Color(0xFF1E293B)),
          ),
        ),
      ],
    );
  }

  Widget _buildFormView() {
    final service = _services[_selectedService >= 0 ? _selectedService : 0];
    return SingleChildScrollView(
      key: const ValueKey('form'),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GstBreadcrumb(path: 'PF & ESI Services > Employee Compliance'),
            const SizedBox(height: 4),
            const GstFormTitle(title: 'Employee Compliance'),
            const SizedBox(height: 24),
            GstFormCard(title: 'Business Information', icon: Icons.business, child: _buildBusinessInfo()),
            const SizedBox(height: 24),
            if (_selectedService == 0) _buildPFForm(),
            if (_selectedService == 1) _buildESIForm(),
            if (_selectedService == 2) _buildTANForm(),
            if (_selectedService == 3) _buildShopForm(),
            const SizedBox(height: 36),
            GstSubmitButton(onPressed: _submit, label: 'Submit'),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessInfo() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildValidatedField('Client Name*', 'Enter client name', _clientNameCtrl)),
            const SizedBox(width: 20),
            Expanded(child: _buildValidatedField('Business Name*', 'Enter business name', _businessNameCtrl)),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstDropdownField(
              label: 'Business Type',
              icon: Icons.business,
              items: _businessTypes,
              value: _selectedBusinessType.isEmpty ? null : _selectedBusinessType,
              onChanged: (v) {
                setState(() => _selectedBusinessType = v ?? '');
              },
              required: true,
              placeholder: '-- Select --',
            )),
            const SizedBox(width: 20),
            Expanded(child: _buildValidatedField('Business Address*', 'Enter business address', _businessAddressCtrl)),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildValidatedField('Pincode*', 'Enter 6-digit pincode', _pincodeCtrl, validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Required';
              if (!RegExp(r'^\d{6}$').hasMatch(v)) return 'Enter valid 6-digit pincode';
              return null;
            })),
            const SizedBox(width: 20),
            Expanded(child: _buildValidatedField('Business PAN*', 'Enter PAN (AAAAA0000A)', _businessPanCtrl, validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Required';
              if (!RegExp(r'^[A-Za-z0-9]{10}$').hasMatch(v)) return 'Exactly 10 alphanumeric';
              return null;
            })),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildValidatedField('Employer / Owner Name*', 'Enter employer name', _employerNameCtrl)),
            const SizedBox(width: 20),
            Expanded(child: _buildValidatedField('Contact Email*', 'Enter email address', _contactEmailCtrl, validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Required';
              if (!RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(v)) return 'Invalid email';
              return null;
            })),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildValidatedField('Contact Number*', 'Enter 10-digit number', _contactNumberCtrl, validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Required';
              if (!RegExp(r'^\d{10}$').hasMatch(v)) return 'Exactly 10 digits';
              return null;
            })),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _buildPFForm() {
    return Column(
      children: [
        GstFormCard(title: 'Employee List Upload', icon: Icons.upload_file, child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GstFileField(label: 'Upload Employee List (CSV / XLSX, Max 5MB)*', icon: Icons.description, onFilePicked: (n) => _pfEmployeeListFile = n, fileName: _pfEmployeeListFile),
          ],
        )),
        const SizedBox(height: 24),
        GstFormCard(title: 'Supporting Documents Upload', icon: Icons.folder_open, child: Column(
          children: [
            GstFileField(label: 'Upload Supporting Documents (PDF / PNG / JPG, Max 10MB)*', icon: Icons.folder, onFilePicked: (n) => _pfSupportingDocsFile = n, fileName: _pfSupportingDocsFile),
          ],
        )),
      ],
    );
  }

  Widget _buildESIForm() {
    return Column(
      children: [
        GstFormCard(title: 'Employee Details Sheet Upload', icon: Icons.upload_file, child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GstFileField(label: 'Upload Employee Details Sheet (CSV / XLSX)*', icon: Icons.description, onFilePicked: (n) => _esiEmployeeSheetFile = n, fileName: _esiEmployeeSheetFile),
          ],
        )),
        const SizedBox(height: 24),
        GstFormCard(title: 'Supporting Documents Upload', icon: Icons.folder_open, child: Column(
          children: [
            GstFileField(label: 'Upload Supporting Documents*', icon: Icons.folder, onFilePicked: (n) => _esiSupportingDocsFile = n, fileName: _esiSupportingDocsFile),
          ],
        )),
      ],
    );
  }

  Widget _buildTANForm() {
    return Column(
      children: [
        GstFormCard(title: 'Additional Information', icon: Icons.person_outline, child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildValidatedField('PAN*', 'Enter PAN number', _tanPanCtrl, validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Required';
                  if (!RegExp(r'^[A-Za-z0-9]{10}$').hasMatch(v)) return 'Exactly 10 alphanumeric';
                  return null;
                })),
                const SizedBox(width: 20),
                Expanded(child: _buildValidatedField('Responsible Person Name*', 'Enter name', _responsiblePersonCtrl)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildValidatedField('Father Name*', 'Enter father name', _fatherNameCtrl)),
                const SizedBox(width: 20),
                Expanded(child: _buildValidatedField('Designation*', 'Enter designation', _designationCtrl)),
              ],
            ),
          ],
        )),
        const SizedBox(height: 24),
        GstFormCard(title: 'Supporting Documents Upload', icon: Icons.folder_open, child: Column(
          children: [
            GstFileField(label: 'Upload Supporting Documents*', icon: Icons.folder, onFilePicked: (n) => _tanSupportingDocsFile = n, fileName: _tanSupportingDocsFile),
          ],
        )),
      ],
    );
  }

  Widget _buildShopForm() {
    return Column(
      children: [
        GstFormCard(title: 'Additional Information', icon: Icons.storefront, child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildValidatedField('GST Number (Optional)', 'Enter GSTIN', _gstNumberCtrl)),
                const SizedBox(width: 20),
                Expanded(child: _buildValidatedField('No. of Employees*', 'Enter number', _noOfEmployeesCtrl)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildValidatedField('Working Hours*', 'e.g. 9:00 AM - 6:00 PM', _workingHoursCtrl)),
                const SizedBox(width: 20),
                Expanded(child: _buildValidatedField('Owner Name*', 'Enter owner name', _ownerNameCtrl)),
              ],
            ),
          ],
        )),
        const SizedBox(height: 24),
        GstFormCard(title: 'Supporting Documents Upload', icon: Icons.folder_open, child: Column(
          children: [
            GstFileField(label: 'Upload Supporting Documents*', icon: Icons.folder, onFilePicked: (n) => _shopSupportingDocsFile = n, fileName: _shopSupportingDocsFile),
          ],
        )),
      ],
    );
  }

  Widget _buildValidatedField(String label, String hint, TextEditingController controller, {String? Function(String?)? validator}) {
    final hasAsterisk = label.endsWith('*');
    final cleanLabel = hasAsterisk ? label.substring(0, label.length - 1) : label;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(cleanLabel, hasAsterisk),
        const SizedBox(height: 6),
        SizedBox(
          height: 44,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint.isEmpty ? null : hint,
              hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFF94A3B8))),
              filled: true,
              fillColor: Colors.white,
            ),
            style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
            validator: validator ?? (v) => v == null || v.trim().isEmpty ? 'Required' : null,
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text, bool hasAsterisk) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: text, style: const TextStyle(color: Color(0xFF374151), fontSize: 13, fontWeight: FontWeight.w500)),
          if (hasAsterisk) const TextSpan(text: ' *', style: TextStyle(color: Color(0xFFEF4444), fontSize: 13)),
        ],
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedBusinessType.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select Business Type')));
      return;
    }
    String? missingFile;
    if (_selectedService == 0) {
      if (_pfEmployeeListFile == null) missingFile = 'Employee List';
      else if (_pfSupportingDocsFile == null) missingFile = 'Supporting Documents';
    } else if (_selectedService == 1) {
      if (_esiEmployeeSheetFile == null) missingFile = 'Employee Details Sheet';
      else if (_esiSupportingDocsFile == null) missingFile = 'Supporting Documents';
    } else if (_selectedService == 2) {
      if (_tanSupportingDocsFile == null) missingFile = 'Supporting Documents';
    } else if (_selectedService == 3) {
      if (_shopSupportingDocsFile == null) missingFile = 'Supporting Documents';
    }
    if (missingFile != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$missingFile upload is required')));
      return;
    }
    _showSuccessDialog();
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56, height: 56,
                  decoration: const BoxDecoration(color: Color(0xFF22C55E), shape: BoxShape.circle),
                  child: const Icon(Icons.check, color: Colors.white, size: 32),
                ),
                const SizedBox(height: 20),
                const Text('Application Submitted Successfully', style: TextStyle(color: Color(0xFF1A1F2E), fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                const Text('We have received your request. Our team will review and respond shortly.', style: TextStyle(color: Color(0xFF64748B), fontSize: 14), textAlign: TextAlign.center),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      setState(() { _showForm = false; _selectedService = -1; });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brandBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: const Text('Back to Services', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
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

class _EmpService {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  const _EmpService(this.title, this.subtitle, this.icon, this.color);
}
