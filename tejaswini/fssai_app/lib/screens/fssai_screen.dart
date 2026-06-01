import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/financial_form_widgets.dart';
import 'fssai_basic_registration_screen.dart';
import 'fssai_state_license_screen.dart';
import 'fssai_central_license_screen.dart';
import 'placeholder_screen.dart';
import 'gst_advisory_screen.dart';
import 'gst_revocation_screen.dart';
import 'gst_returns_filing_screen.dart';
import 'gst_annual_return_screen.dart';
import 'gst_notice_reply_screen.dart';
import 'gst_amendment_screen.dart';
import 'gstr10_screen.dart';
import 'tds_returns_form_page.dart';
import 'virtual_cfo_form_page.dart';
import 'accounting_bookkeeping_form_page.dart';
import 'legal_nda_form_screen.dart';
import 'legal_agreement_form_screen.dart';
import 'legal_franchise_form_screen.dart';

class FssaiScreen extends StatefulWidget {
  const FssaiScreen({super.key});

  @override
  State<FssaiScreen> createState() => _FssaiScreenState();
}

class _FssaiScreenState extends State<FssaiScreen> {
  int _selectedRadio = 0;
  int _selectedNavIndex = 10;
  int _hoveredCard = -1;
  int _pressedCard = -1;
  int? _selectedService;
  bool _hoveringContinue = false;

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeNavIndex: _selectedNavIndex,
      onNavChanged: (i) {
        if (i != _selectedNavIndex) {
          setState(() {
            _selectedNavIndex = i;
            _selectedRadio = 0;
            _selectedService = null;
            _hoveringContinue = false;
          });
        }
      },
      child:
          (_selectedNavIndex == 10 ||
              _selectedNavIndex == 11 ||
              _selectedNavIndex == 12 ||
              _selectedNavIndex == 13)
          ? _buildMainContent()
          : const Center(
              child: Text(
                'Not built yet',
                style: TextStyle(fontSize: 18, color: AppColors.textMuted),
              ),
            ),
    );
  }

  Widget _buildMainContent() {
    final isFinancial = _selectedNavIndex == 12;
    final isLegal = _selectedNavIndex == 13;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderCard(),
        const SizedBox(height: 36),
        Text(
          _selectedNavIndex == 11
              ? 'Select a GST Service'
              : (isFinancial
                    ? 'Choose Financial Service'
                    : (isLegal ? 'Choose Legal Service' : 'Choose your business type')),
          style: const TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        _buildRadioSection(),
        if (isFinancial) ...[
          if (_selectedService != null) ...[
            const SizedBox(height: 28),
            _buildDocumentsCard(),
            const SizedBox(height: 32),
            _buildFinancialContinueButton(),
          ],
        ] else if (isLegal) ...[
          if (_selectedService != null) ...[
            const SizedBox(height: 28),
            _buildDocumentsCard(),
            const SizedBox(height: 36),
            _buildLegalContinueButton(),
          ],
        ] else ...[
          const SizedBox(height: 28),
          _buildDocumentsCard(),
          const SizedBox(height: 36),
          _buildContinueButton(),
        ],
      ],
    );
  }

  Widget _buildHeaderCard() {
    final isFinancial = _selectedNavIndex == 12;
    final isLegal = _selectedNavIndex == 13;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              isFinancial
                  ? Icons.account_balance_wallet_outlined
                  : (isLegal ? Icons.gavel : Icons.assignment_outlined),
              color: const Color(0xFF3B82F6),
              size: 40,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: _selectedNavIndex == 11
                              ? 'GST '
                              : (isFinancial
                                    ? 'TDS & Financial '
                                    : (isLegal ? 'Legal ' : 'FSSAI ')),
                          style: const TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: isFinancial || isLegal ? 'Services' : 'Registration',
                          style: const TextStyle(
                            color: Color(0xFF3B82F6),
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _selectedNavIndex == 11
                        ? 'Expert guidance for your GST registration and compliance'
                        : (isFinancial
                              ? 'Professional accounting, TDS filing, and CFO advisory solutions'
                              : (isLegal
                                    ? 'Legal agreements, NDA workflows, franchise documentation and compliance services.'
                                    : 'Expert guidance for your food business licensing and compliance')),
                    style: const TextStyle(
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
              left: BorderSide(color: Color(0xFF3B82F6), width: 4),
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
                    Text(
                      _selectedNavIndex == 11
                          ? 'GST compliance can be complex and overwhelming for many business owners. The intricate rules and frequent updates make it difficult to stay current and avoid penalties.'
                          : (isFinancial
                                ? 'Financial management and tax compliance can be complex and time-consuming for growing businesses. Maintaining accurate books and filing timely tax returns are critical to avoid legal notices and heavy penalties.'
                                : (isLegal
                                      ? 'Protect business agreements, confidential information, contracts and legal documentation with enterprise legal workflow management.'
                                      : 'GST compliance can be complex and overwhelming for many business owners. The intricate rules and frequent updates make it difficult to stay current and avoid penalties.')),
                      style: const TextStyle(
                        color: Color(0xFF475569),
                        fontSize: 14,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 14,
                          height: 1.45,
                          fontFamily: 'Roboto',
                        ),
                        children: [
                          const TextSpan(text: 'Our service provides '),
                          const TextSpan(
                            text:
                                'expert guidance to simplify the entire process.',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const TextSpan(
                            text:
                                ' We handle the heavy lifting so you can focus on ',
                          ),
                          TextSpan(
                            text: isFinancial
                                ? 'financial growth and key strategic decisions.'
                                : (isLegal
                                      ? 'business growth with confidence.'
                                      : 'growing your business with peace of mind.'),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                        ],
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

  Widget _buildRadioSection() {
    if (_selectedNavIndex == 11) {
      return SizedBox(
        height: 180,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 240,
                child: _buildSelectorCard(
                  0,
                  'GST Advisory Service',
                  'Expert guidance & support',
                  Icons.support_agent,
                  const Color(0xFF0EA5E9),
                  showRecommended: true,
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 240,
                child: _buildSelectorCard(
                  1,
                  'GST Revocation',
                  'Revoke cancelled GSTIN',
                  Icons.cancel_outlined,
                  const Color(0xFF10B981),
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 240,
                child: _buildSelectorCard(
                  2,
                  'GST Returns Filing',
                  'File regular GST returns',
                  Icons.file_upload_outlined,
                  const Color(0xFFF97316),
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 240,
                child: _buildSelectorCard(
                  3,
                  'GST Annual Return',
                  'File GSTR-9 / 9C',
                  Icons.calendar_month_outlined,
                  const Color(0xFF8B5CF6),
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 240,
                child: _buildSelectorCard(
                  4,
                  'GST Notice Reply',
                  'Reply to dept notices',
                  Icons.message_outlined,
                  const Color(0xFFEC4899),
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 240,
                child: _buildSelectorCard(
                  5,
                  'GST Amendment',
                  'Modify GST details',
                  Icons.edit_document,
                  const Color(0xFF14B8A6),
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 240,
                child: _buildSelectorCard(
                  6,
                  'GSTR-10 (Final)',
                  'File upon cancellation',
                  Icons.assignment_turned_in_outlined,
                  const Color(0xFFF59E0B),
                ),
              ),
            ],
          ),
        ),
      );
    }
    if (_selectedNavIndex == 12) {
      return SizedBox(
        height: 180,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _buildSelectorCard(
                0,
                'TDS Returns Filing',
                'Quarterly tax filing compliance',
                Icons.receipt_long_outlined,
                const Color(0xFF0EA5E9),
                showRecommended: true,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildSelectorCard(
                1,
                'Virtual CFO Services',
                'Financial planning and advisory',
                Icons.query_stats_outlined,
                const Color(0xFF10B981),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildSelectorCard(
                2,
                'Accounting & Bookkeeping',
                'Business financial management',
                Icons.calculate_outlined,
                const Color(0xFFF97316),
              ),
            ),
          ],
        ),
      );
    }
    if (_selectedNavIndex == 13) {
      return SizedBox(
        height: 170,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildLegalSelectorCard(
                0,
                'NDA Agreement',
                'Protect confidential business information.',
                Icons.lock_outline,
                const Color(0xFF0EA5E9),
              ),
              const SizedBox(width: 24),
              _buildLegalSelectorCard(
                1,
                'Legal Agreement Drafting',
                'Business agreements and contract drafting.',
                Icons.description_outlined,
                const Color(0xFF10B981),
              ),
              const SizedBox(width: 24),
              _buildLegalSelectorCard(
                2,
                'Franchise Agreement',
                'Franchise legal documentation.',
                Icons.business_outlined,
                const Color(0xFFF97316),
              ),
            ],
          ),
        ),
      );
    }
    return SizedBox(
      height: 180,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _buildSelectorCard(
              0,
              'Basic Registration',
              'Small businesses & startups',
              Icons.storefront_outlined,
              const Color(0xFF0EA5E9),
              showRecommended: true,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSelectorCard(
              1,
              'State License',
              'Mid-size operations',
              Icons.store_outlined,
              const Color(0xFF10B981),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSelectorCard(
              2,
              'Central License',
              'Large-scale enterprises',
              Icons.grid_view_outlined,
              const Color(0xFFF97316),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectorCard(
    int index,
    String title,
    String subtitle,
    IconData icon,
    Color iconColor, {
    bool showRecommended = false,
  }) {
    final isSelected = _selectedNavIndex == 12
        ? _selectedService == index
        : _selectedRadio == index;
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
    final effectiveIconColor = (isSelected && index == 0)
        ? Colors.white
        : iconColor;

    Matrix4 getTransform() {
      if (isPressed) return Matrix4.diagonal3Values(0.97, 0.97, 1.0);
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
            if (_selectedNavIndex == 12 || _selectedNavIndex == 13) {
              _selectedService = index;
              _hoveringContinue = false;
            } else {
              _selectedRadio = index;
            }
          });
        },
        onTapCancel: () => setState(() => _pressedCard = -1),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: getTransform(),
          transformAlignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
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
              if (showRecommended)
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      'Recommended',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              // Icon (no background box)
              Icon(icon, color: effectiveIconColor, size: 22),
              const SizedBox(height: 12),
              // Title
              Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              // Subtitle
              Text(
                subtitle,
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

  Widget _buildLegalSelectorCard(
    int index,
    String title,
    String subtitle,
    IconData icon,
    Color iconColor,
  ) {
    final isSelected = _selectedService == index;
    final isHovered = _hoveredCard == index;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveredCard = index),
      onExit: (_) => setState(() => _hoveredCard = -1),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedService = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 320,
          transform: isHovered && !isSelected
              ? Matrix4.diagonal3Values(1.03, 1.03, 1.0)
              : Matrix4.identity(),
          transformAlignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF2D3A6B) : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF2D3A6B)
                  : (isHovered
                        ? const Color(0xFFCBD5E1)
                        : const Color(0xFFE2E8F0)),
              width: 1,
            ),
            boxShadow: isHovered && !isSelected
                ? const [
                    BoxShadow(
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
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withAlpha(30)
                      : const Color(0xFFF0F9FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: isSelected ? Colors.white : iconColor,
                  size: 22,
                ),
              ),
              const Spacer(),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF1E293B),
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white.withAlpha(166)
                      : const Color(0xFF94A3B8),
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
    final licenseName = _getLicenseLabel();

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
          // Header row
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
                _selectedNavIndex == 12 || _selectedNavIndex == 13
                    ? 'Required documents - $licenseName'
                    : (_selectedNavIndex == 11
                          ? 'Required documents - $licenseName'
                          : 'Required documents - $licenseName License'),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
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
          // 2-column document grid
          _buildDocumentGrid(),
        ],
      ),
    );
  }

  Widget _buildDocumentGrid() {
    final leftDocs = _getLeftDocs();
    final rightDocs = _getRightDocs();
    final maxRows = leftDocs.length > rightDocs.length
        ? leftDocs.length
        : rightDocs.length;

    return Column(
      children: List.generate(maxRows, (i) {
        final leftDoc = i < leftDocs.length ? leftDocs[i] : null;
        final rightDoc = i < rightDocs.length ? rightDocs[i] : null;
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              if (leftDoc != null)
                Expanded(child: _buildDocumentTile(leftDoc))
              else
                const Expanded(child: SizedBox()),
              const SizedBox(width: 10),
              if (rightDoc != null)
                Expanded(child: _buildDocumentTile(rightDoc))
              else
                const Expanded(child: SizedBox()),
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
            child: const Icon(Icons.check, color: Color(0xFF3B82F6), size: 14),
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

  String _getLicenseLabel() {
    if (_selectedNavIndex == 11) {
      switch (_selectedRadio) {
        case 0:
          return 'Advisory Service';
        case 1:
          return 'Revocation';
        case 2:
          return 'Returns Filing';
        case 3:
          return 'Annual Return';
        case 4:
          return 'Notice Reply';
        case 5:
          return 'Amendment';
        case 6:
          return 'GSTR-10';
        default:
          return '';
      }
    }
    if (_selectedNavIndex == 12) {
      switch (_selectedService) {
        case 0:
          return 'TDS Returns Filing';
        case 1:
          return 'Virtual CFO Services';
        case 2:
          return 'Accounting & Bookkeeping';
        default:
          return '';
      }
    }
    if (_selectedNavIndex == 13) {
      switch (_selectedService) {
        case 0:
          return 'NDA Agreement';
        case 1:
          return 'Legal Agreement Drafting';
        case 2:
          return 'Franchise Agreement';
        default:
          return '';
      }
    }
    switch (_selectedRadio) {
      case 0:
        return 'Basic';
      case 1:
        return 'State';
      case 2:
        return 'Central';
      default:
        return '';
    }
  }

  List<String> _getLeftDocs() {
    if (_selectedNavIndex == 11) {
      switch (_selectedRadio) {
        case 0:
          return [
            'Past GST returns (GSTR-1, GSTR-3B) – PDF/Excel',
            'Purchase invoices – PDF/Excel',
            'Sales invoices – PDF/Excel',
          ];
        case 1:
          return [
            'GST Revocation Notice – PDF',
            'Copy of GST Registration Certificate – PDF',
            'Financial statements – PDF/Excel',
          ];
        case 2:
          return [
            'Sales invoices (B2B & B2C) – Excel/PDF',
            'Purchase invoices – Excel/PDF',
            'Debit/Credit notes – Excel/PDF',
          ];
        case 3:
          return [
            'Monthly/quarterly GST returns – PDF/Excel',
            'Reconciliation of ITC – Excel/PDF',
            'Audited financial statements – PDF/Excel',
          ];
        case 4:
          return [
            'GST Notice – PDF',
            'Related invoices or bills – PDF/Excel',
            'Previous GST returns – PDF/Excel',
          ];
        case 5:
          return [
            'Proof of new address (Electricity bill, rent agreement) – PDF/JPG',
            'PAN card if changing PAN – PDF',
            'Bank statement/cancelled cheque for bank change – PDF',
          ];
        case 6:
          return [
            'Cancellation / Surrender application copy – PDF',
            'Last filed GST returns – PDF/Excel',
            'Final sales & purchase summary – Excel/PDF',
          ];
        default:
          return [];
      }
    }
    if (_selectedNavIndex == 12) {
      switch (_selectedService) {
        case 0:
          return [
            'TAN Registration Certificate',
            'Business PAN',
            'Deductee Details Sheet',
          ];
        case 1:
          return [
            'PAN Business',
            'Registration Certificate',
            'Audited Statements',
          ];
        case 2:
          return [
            'PAN Business',
            'GST Registration',
            'Sales Invoices',
            'Purchase Invoices',
          ];
        default:
          return [];
      }
    }
    if (_selectedNavIndex == 13) {
      switch (_selectedService) {
        case 0:
          return ['PAN Card', 'Business Registration Certificate', 'Partnership Deed', 'Signatory ID'];
        case 1:
          return ['PAN Card', 'Business Proof', 'Incorporation Certificate'];
        case 2:
          return ['PAN Franchisor', 'Trademark Certificate', 'Address Proof'];
        default:
          return [];
      }
    }
    switch (_selectedRadio) {
      case 0:
        return [
          'Aadhaar Card',
          'PAN Card',
          'Photograph of Proprietor',
          'Company register certificate',
        ];
      case 1:
        return [
          'Partner-Specific Document',
          'Business information',
          'Aadhar Card',
          'Company register certificate',
          'PAN Card',
        ];
      case 2:
        return [
          'Company information',
          'Director information',
          'Contact details',
          'Business details',
        ];
      default:
        return [];
    }
  }

  List<String> _getRightDocs() {
    if (_selectedNavIndex == 11) {
      switch (_selectedRadio) {
        case 0:
          return [
            'Financial statements (Profit & Loss, Balance Sheet) – PDF/Excel',
            'Any correspondence with GST authorities – PDF',
          ];
        case 1:
          return [
            'Any correspondence with GST authorities – PDF',
            'Identity proof of authorized signatory – PDF',
          ];
        case 2:
          return [
            'Payment challans for tax deposited – PDF',
            'Any adjustments/prior period entries – PDF/Excel',
          ];
        case 3:
          return [
            'Bank statements if required – PDF',
            'Audit reports (for GSTR-9C) – PDF',
          ];
        case 4:
          return [
            'Bank statements if payment issues – PDF',
            'Correspondence with GST department – PDF',
          ];
        case 5:
          return [
            'Identity proof of signatory – PDF',
            'Board resolution/authorization letter (if applicable) – PDF',
          ];
        case 6:
          return [
            'Payment challans – PDF',
            'Adjustments/prior period corrections – PDF/Excel',
          ];
        default:
          return [];
      }
    }
    if (_selectedNavIndex == 12) {
      switch (_selectedService) {
        case 0:
          return ['Payment Challans', 'Previous TDS Returns'];
        case 1:
          return ['Books Of Accounts', 'GST Returns', 'Loans Investments'];
        case 2:
          return [
            'Bank Statements',
            'Expense Receipts',
            'Payroll Details',
            'Previous Financial Records',
          ];
        default:
          return [];
      }
    }
    if (_selectedNavIndex == 13) {
      switch (_selectedService) {
        case 0:
          return ['Address Proof', 'Passport', 'Rental Agreement'];
        case 1:
          return ['Business Terms', 'Agreement Draft'];
        case 2:
          return ['ID Proof', 'Franchise Model Documentation'];
        default:
          return [];
      }
    }
    switch (_selectedRadio) {
      case 0:
        return [
          'Property document',
          'Electricity bill',
          'Property tax receipt',
        ];
      case 1:
        return [
          'Company PAN Card',
          'Photograph',
          'Company Seal',
          'Property document',
        ];
      case 2:
        return [
          'Property document',
          'Electricity bill',
          'Property tax receipt',
          'MOA / AOA',
        ];
      default:
        return [];
    }
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
              onTap: () {
                Widget nextScreen;
                if (_selectedNavIndex == 11) {
                  if (_selectedRadio == 0) {
                    nextScreen = const GstAdvisoryScreen();
                  } else if (_selectedRadio == 1) {
                    nextScreen = const GstRevocationScreen();
                  } else if (_selectedRadio == 2) {
                    nextScreen = const GstReturnsFilingScreen();
                  } else if (_selectedRadio == 3) {
                    nextScreen = const GstAnnualReturnScreen();
                  } else if (_selectedRadio == 4) {
                    nextScreen = const GstNoticeReplyScreen();
                  } else if (_selectedRadio == 5) {
                    nextScreen = const GstAmendmentScreen();
                  } else if (_selectedRadio == 6) {
                    nextScreen = const Gstr10Screen();
                  } else {
                    nextScreen = const PlaceholderScreen();
                  }
                } else {
                  switch (_selectedRadio) {
                    case 1:
                      nextScreen = FssaiStateLicenseScreen();
                      break;
                    case 2:
                      nextScreen = FssaiCentralLicenseScreen();
                      break;
                    default:
                      nextScreen = FssaiBasicRegistrationScreen();
                  }
                }
                _showUserDetailsDialog(context, (context) => nextScreen);
              },
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

  Widget _buildFinancialContinueButton() {
    return Center(
      child: FinancialGradientButton(
        width: 280,
        height: 58,
        label: 'Continue',
        onPressed: _handleFinancialContinue,
      ),
    );
  }

  Widget _buildLegalContinueButton() {
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
              onTap: _handleLegalContinue,
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

  void _handleLegalContinue() {
    if (_selectedService == null) return;
    Widget page;
    switch (_selectedService) {
      case 0:
        page = const LegalNdaFormScreen();
        break;
      case 1:
        page = const LegalAgreementFormScreen();
        break;
      case 2:
        page = const LegalFranchiseFormScreen();
        break;
      default:
        return;
    }
    _showUserDetailsPopup(context, page);
  }

  void _handleFinancialContinue() {
    if (_selectedService == null) return;
    Widget page;
    switch (_selectedService) {
      case 0:
        page = const TDSReturnsFormPage();
        break;
      case 1:
        page = const VirtualCFOFormPage();
        break;
      case 2:
        page = const AccountingBookkeepingFormPage();
        break;
      default:
        return;
    }
    _showUserDetailsPopup(context, page);
  }

  void _showUserDetailsPopup(BuildContext context, Widget nextPage) {
    final nameController = TextEditingController();
    final mobileController = TextEditingController();
    final emailController = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          elevation: 24,
          shadowColor: const Color(0x1A000000),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'User Details',
                    style: TextStyle(
                      color: Color(0xFF1A1F2E),
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(height: 1, color: const Color(0xFFE5E7EB)),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildPopupField('User Name', 'Enter your name', nameController),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildPopupField('Mobile Number', 'Enter Mobile Number', mobileController),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildPopupField('Mail Address', 'Enter Mail Address', emailController),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: _buildPopupSubmitButton(() {
                      Navigator.of(ctx).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => nextPage),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPopupField(
    String label,
    String hint,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF374151),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 56,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 15,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: AppColors.brandBlue,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            style: const TextStyle(fontSize: 15, color: Color(0xFF1E293B)),
          ),
        ),
      ],
    );
  }

  Widget _buildPopupSubmitButton(VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF60A5FA), Color(0xFF3B82F6), Color(0xFF3B4FE0)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color(0x523B82F6),
              blurRadius: 22,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Submit',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _showUserDetailsDialog(
    BuildContext context,
    WidgetBuilder nextScreenBuilder,
  ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          backgroundColor: AppColors.bgCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          shadowColor: const Color(0x1F000000),
          child: SizedBox(
            width: 520,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'User Details',
                      style: TextStyle(
                        color: Color(0xFF1A1F2E),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Divider(height: 24, color: AppColors.border),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildDialogField(
                          'User Name',
                          'Enter your name',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildDialogField(
                          'Mobile Number',
                          'Enter Mobile Number',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildDialogField(
                    'Mail Address',
                    'Enter Mail Address',
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        Navigator.of(
                          context,
                        ).push(MaterialPageRoute(builder: nextScreenBuilder));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brandBlue,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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

  Widget _buildDialogField(String label, String hint) {
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
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 15,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
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
                borderSide: const BorderSide(
                  color: AppColors.brandBlue,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: AppColors.white,
            ),
            style: const TextStyle(fontSize: 15, color: Color(0xFF1E293B)),
          ),
        ),
        const SizedBox(height: 6),
      ],
    );
  }

}


