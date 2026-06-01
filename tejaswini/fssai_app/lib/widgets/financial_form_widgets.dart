import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../theme/app_theme.dart';

class FinancialServicesFormCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const FinancialServicesFormCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x120F172A),
            blurRadius: 28,
            offset: Offset(0, 12),
          ),
        ],
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 22, color: const Color(0xFF3B82F6)),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1E293B),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: const Color(0xFFF1F5F9)),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }
}

class FinancialGradientButton extends StatefulWidget {
  final String label;
  final String? loadingLabel;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double height;
  final bool expand;

  const FinancialGradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loadingLabel,
    this.isLoading = false,
    this.width,
    this.height = 58,
    this.expand = false,
  });

  @override
  State<FinancialGradientButton> createState() =>
      _FinancialGradientButtonState();
}

class _FinancialGradientButtonState extends State<FinancialGradientButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null && !widget.isLoading;
    final buttonChild = widget.isLoading
        ? Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                widget.loadingLabel ?? widget.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          )
        : Text(
            widget.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          );

    final button = MouseRegion(
      cursor: isEnabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: isEnabled && _isHovered ? 1.02 : 1,
        duration: const Duration(milliseconds: 180),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: widget.expand ? double.infinity : widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.isLoading
                  ? [const Color(0xFF60A5FA), const Color(0xFF3B82F6)]
                  : [
                      const Color(0xFF60A5FA),
                      AppColors.brandBlue,
                      AppColors.brandPrimary,
                    ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3B82F6).withAlpha(isEnabled ? 82 : 52),
                blurRadius: _isHovered && isEnabled ? 28 : 22,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(28),
              onTap: widget.onPressed,
              child: Center(child: buttonChild),
            ),
          ),
        ),
      ),
    );

    if (widget.expand) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}

class FinancialServicesTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final String? helperText;
  final int maxLines;

  const FinancialServicesTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.helperText,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final hasAsterisk = label.endsWith('*');
    final cleanLabel = hasAsterisk
        ? label.substring(0, label.length - 1)
        : label;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(cleanLabel, hasAsterisk),
        const SizedBox(height: 8),
        SizedBox(
          height: maxLines > 1 ? null : 54,
          child: TextField(
            maxLines: maxLines,
            decoration: InputDecoration(
              prefixIcon: maxLines > 1
                  ? null
                  : Icon(icon, size: 18, color: const Color(0xFF94A3B8)),
              hintText: hint.isEmpty ? null : hint,
              hintStyle: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 14,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: maxLines > 1 ? 16 : 0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.brandBlue,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            style: const TextStyle(fontSize: 15, color: Color(0xFF374151)),
          ),
        ),
        if (helperText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              helperText!,
              style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
            ),
          ),
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
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (hasAsterisk)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Color(0xFFEF4444), fontSize: 14),
            ),
        ],
      ),
    );
  }
}

class FinancialServicesFileField extends StatefulWidget {
  final String label;
  final IconData icon;
  final ValueChanged<String> onFilePicked;
  final String? helperText;

  const FinancialServicesFileField({
    super.key,
    required this.label,
    required this.icon,
    required this.onFilePicked,
    this.helperText,
  });

  @override
  State<FinancialServicesFileField> createState() =>
      _FinancialServicesFileFieldState();
}

class _FinancialServicesFileFieldState
    extends State<FinancialServicesFileField> {
  String? _fileName;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final hasAsterisk = widget.label.endsWith('*');
    final cleanLabel = hasAsterisk
        ? widget.label.substring(0, widget.label.length - 1)
        : widget.label;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(cleanLabel, hasAsterisk),
        const SizedBox(height: 8),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: _pickFile,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              height: 54,
              decoration: BoxDecoration(
                color: _isHovered ? const Color(0xFFF8FAFC) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: _isHovered
                          ? const Color(0xFFE2E8F0)
                          : const Color(0xFFF1F5F9),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(11),
                        bottomLeft: Radius.circular(11),
                      ),
                      border: const Border(
                        right: BorderSide(color: Color(0xFFCBD5E1)),
                      ),
                    ),
                    child: Icon(
                      widget.icon,
                      size: 20,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      _fileName ?? 'No file chosen',
                      style: TextStyle(
                        color: _fileName != null
                            ? const Color(0xFF1E293B)
                            : const Color(0xFF94A3B8),
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (widget.helperText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              widget.helperText!,
              style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
            ),
          ),
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
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (hasAsterisk)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Color(0xFFEF4444), fontSize: 14),
            ),
        ],
      ),
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      final name = result.files.single.name;
      setState(() => _fileName = name);
      widget.onFilePicked(name);
    }
  }
}
