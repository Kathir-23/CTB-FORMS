import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NavItem {
  final IconData icon;
  final String label;
  final int? index;
  const NavItem(this.icon, this.label, {this.index});
}

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double? width;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(32),
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: padding,
      child: child,
    );
  }
}

class AppLayout extends StatefulWidget {
  final int activeNavIndex;
  final ValueChanged<int> onNavChanged;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Widget child;
  final bool formLayout;
  final Widget? rightPanel;

  const AppLayout({
    super.key,
    this.activeNavIndex = 12,
    required this.onNavChanged,
    this.showBackButton = false,
    this.onBackPressed,
    required this.child,
    this.formLayout = false,
    this.rightPanel,
  });

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  bool _pagesExpanded = true;
  bool _auditingExpanded = true;

  static const _pagesItems = [
    NavItem(Icons.dashboard, 'Dashboard'),
    NavItem(Icons.person, 'Profile'),
    NavItem(Icons.people, 'Customers'),
    NavItem(Icons.inventory_2, 'Products'),
    NavItem(Icons.add_shopping_cart, 'Add Sales'),
    NavItem(Icons.money_off, 'Add Expense'),
    NavItem(Icons.description, 'Invoice'),
    NavItem(Icons.format_quote, 'Quotation'),
    NavItem(Icons.receipt_long, 'Receipt'),
    NavItem(Icons.bar_chart, 'Report'),
  ];

  static const _auditingItems = [
    NavItem(Icons.assignment, 'GST Registration', index: 10),
    NavItem(Icons.business, 'Business & Regulatory Registration Portal', index: 13),
    NavItem(Icons.restaurant, 'Fssai Services', index: 11),
    NavItem(Icons.work, 'PF & ESI Services', index: 12),
    NavItem(Icons.scale, 'Legal Services', index: 14),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(decoration: TextDecoration.none),
      child: Row(
        children: [
          _buildSidebar(),
          Expanded(child: _buildRightPanel()),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 240,
      color: AppColors.bgSidebar,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildBrand(),
          const SizedBox(height: 36),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildSectionHeader('Pages', _pagesExpanded, () {
                  setState(() => _pagesExpanded = !_pagesExpanded);
                }),
                if (_pagesExpanded) ..._buildNavItems(_pagesItems, 0),
                _buildSectionHeader('Auditing Services', _auditingExpanded, () {
                  setState(() => _auditingExpanded = !_auditingExpanded);
                }),
                if (_auditingExpanded) ..._buildNavItems(_auditingItems, 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrand() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Icon(Icons.circle, color: AppColors.brandAccent, size: 10),
          SizedBox(width: 10),
          Text(
            'asdgfgkh',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool expanded, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 6),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.textSidebarSection,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: AppColors.textSidebarSection,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildNavItems(List<NavItem> items, int startIndex) {
    return List.generate(items.length, (i) {
      final idx = items[i].index ?? (startIndex + i);
      final isActive = idx == widget.activeNavIndex;
      return GestureDetector(
        onTap: () => widget.onNavChanged(idx),
        child: Container(
          color: isActive ? AppColors.bgNavActive : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              Icon(
                items[i].icon,
                size: 20,
                color: isActive ? AppColors.brandPrimary : AppColors.textSidebar,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  items[i].label,
                  style: TextStyle(
                    color: isActive ? Colors.white : AppColors.textSidebar,
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildRightPanel() {
    return Column(
      children: [
        _buildTopBar(),
        Expanded(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              color: AppColors.bgPage,
              child: widget.formLayout && widget.rightPanel != null
                  ? _buildFormContent()
                  : _buildScrollContent(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScrollContent() {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1100),
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.child,
              const SizedBox(height: 36),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;
        if (isMobile) {
          return SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1100),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.child,
                    const SizedBox(height: 24),
                    widget.rightPanel!,
                    const SizedBox(height: 36),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          );
        }
        return Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1100),
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 65,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.child,
                        const SizedBox(height: 36),
                        _buildFooter(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                SizedBox(
                  width: 385,
                  child: SingleChildScrollView(
                    child: widget.rightPanel!,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopBar() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          if (widget.showBackButton)
            Material(
              color: Colors.transparent,
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: widget.onBackPressed ?? () => Navigator.of(context).pop(),
                  child: const Icon(Icons.arrow_back, color: AppColors.textSecondary, size: 28),
                ),
              ),
            )
          else
            const Icon(Icons.menu, color: AppColors.textSecondary, size: 28),
          const Spacer(),
          _buildIconBadge(Icons.notifications, '3'),
          const SizedBox(width: 16),
          _buildIconBadge(Icons.chat_bubble_outline, '0'),
          const SizedBox(width: 16),
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.border,
                child: const Icon(Icons.person, color: AppColors.textSecondary, size: 20),
              ),
              const SizedBox(width: 8),
              const Text(
                'asdgfgkh',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.arrow_drop_down, color: AppColors.textSecondary, size: 22),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconBadge(IconData icon, String badgeText) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, color: AppColors.textSecondary, size: 28),
        if (badgeText != '0')
          Positioned(
            top: -5,
            right: -7,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.brandAccent,
                shape: BoxShape.circle,
              ),
              child: Text(
                badgeText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Pentagon Innovations - Product \u00a9',
          style: TextStyle(
            color: AppColors.textMuted.withAlpha(180),
            fontSize: 13,
          ),
        ),
        Row(
          children: [
            _footerLink('Support'),
            const SizedBox(width: 20),
            _footerLink('Help Center'),
            const SizedBox(width: 20),
            _footerLink('Privacy'),
            const SizedBox(width: 20),
            _footerLink('Terms'),
          ],
        ),
      ],
    );
  }

  Widget _footerLink(String text) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.textMuted.withAlpha(180),
          fontSize: 13,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
