import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/application_model.dart';
import '../../viewmodels/admin_viewmodel.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../utils/app_routes.dart';

/**
 * Student Numbers : 223048044, 222049725, 223022994,223014209,224131946
 * Student Names : Shadrack Bila, Lerato Gladys Molefe,Marcus Mhlambi,Lisa Sandi,Lahluma Maselana
 * Question :   Admin Dashboard (Read / Update / Delete Operations)
 */

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  // Track the currently selected filter. 'all' means no filter.
  String _selectedFilter = 'all';

  // Filter options shown in the filter bar
  final List<Map<String, dynamic>> _filters = [
    {'label': 'All', 'value': 'all', 'color': Color(0xFF1565C0)},
    {'label': 'Pending', 'value': 'pending', 'color': Colors.orange},
    {'label': 'Approved', 'value': 'approved', 'color': Colors.green},
    {'label': 'Rejected', 'value': 'rejected', 'color': Colors.red},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminViewModel>().loadAllApplications();
    });
  }

  /// Returns only the applications that match the selected filter.
  List<ApplicationModel> _filteredApplications(
      List<ApplicationModel> applications) {
    if (_selectedFilter == 'all') return applications;
    return applications.where((app) => app.status == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        title: const Text('Admin Dashboard'),
        actions: [
          // REFRESH
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<AdminViewModel>().loadAllApplications();
            },
          ),

          // LOGOUT
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await context.read<AuthViewModel>().signOut();
              if (mounted) {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              }
            },
          ),
        ],
      ),
      body: Consumer<AdminViewModel>(
        builder: (context, vm, _) {
          // LOADING
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // EMPTY (no applications at all)
          if (vm.applications.isEmpty) {
            return const Center(
              child: Text(
                'No Applications Found',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final filtered = _filteredApplications(vm.applications);

          return Column(
            children: [
              // ── FILTER BAR ──────────────────────────────────────────
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: _filters.map((filter) {
                    final isSelected = _selectedFilter == filter['value'];
                    final color = filter['color'] as Color;

                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedFilter = filter['value'] as String;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? color.withOpacity(0.15)
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected ? color : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  filter['label'] as String,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? color
                                        : Colors.grey.shade600,
                                  ),
                                ),
                                // Show count badge
                                const SizedBox(height: 2),
                                Text(
                                  filter['value'] == 'all'
                                      ? '${vm.applications.length}'
                                      : '${vm.applications.where((a) => a.status == filter['value']).length}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isSelected
                                        ? color
                                        : Colors.grey.shade400,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              // ── APPLICATION LIST ────────────────────────────────────
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inbox_outlined,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No ${_selectedFilter == 'all' ? '' : _selectedFilter} applications',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          await vm.loadAllApplications();
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final ApplicationModel app = filtered[index];
                            return _ApplicationCard(app: app, vm: vm);
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ApplicationCard extends StatelessWidget {
  final ApplicationModel app;
  final AdminViewModel vm;

  const _ApplicationCard({
    required this.app,
    required this.vm,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color(0xFF1565C0),
                  child: Text(
                    app.studentName[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        app.studentName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        app.studentEmail,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                _StatusChip(status: app.status),
              ],
            ),

            const SizedBox(height: 20),

            // DETAILS
            _InfoRow(title: 'Year Of Study', value: app.yearOfStudy),
            _InfoRow(
              title: 'Module 1',
              value: '${app.module1Name} (${app.module1Level})',
            ),
            if (app.module2Name != null)
              _InfoRow(
                title: 'Module 2',
                value: '${app.module2Name} (${app.module2Level})',
              ),
            _InfoRow(
              title: 'Eligibility',
              value: app.eligibilityConfirmed ? 'Confirmed' : 'Not Confirmed',
            ),

            const SizedBox(height: 16),

            // DOCUMENT PREVIEW
            if (app.documentUrl != null)
              _buildDocumentPreview(app.documentUrl!),

            const SizedBox(height: 20),

            // BUTTONS
            Row(
              children: [
                // APPROVE
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.check),
                    label: const Text('Approve'),
                    onPressed: () {
                      _confirmAction(
                        context,
                        title: 'Approve Application',
                        message: 'Approve ${app.studentName} application?',
                        confirmColor: Colors.green,
                        onConfirm: () => vm.approveApplication(app.id!),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 10),

                // REJECT
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.close),
                    label: const Text('Reject'),
                    onPressed: () {
                      _confirmAction(
                        context,
                        title: 'Reject Application',
                        message: 'Reject ${app.studentName} application?',
                        confirmColor: Colors.orange,
                        onConfirm: () => vm.rejectApplication(app.id!),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 10),

                // DELETE
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                    onPressed: () {
                      _confirmAction(
                        context,
                        title: 'Delete Application',
                        message:
                            'Delete ${app.studentName} application permanently?',
                        confirmColor: Colors.red,
                        onConfirm: () => vm.deleteApplication(app.id!),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentPreview(String url) {
    final lowerUrl = url.toLowerCase();
    final isImage = lowerUrl.contains('.jpg') ||
        lowerUrl.contains('.jpeg') ||
        lowerUrl.contains('.png');
    final isPdf = lowerUrl.contains('.pdf');

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1565C0).withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Row(
              children: const [
                Icon(Icons.attach_file, color: Color(0xFF1565C0), size: 18),
                SizedBox(width: 6),
                Text(
                  'Supporting Document',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1565C0),
                  ),
                ),
              ],
            ),
          ),
          if (isImage)
            ClipRRect(
              child: Image.network(
                url,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, progress) => progress == null
                    ? child
                    : const SizedBox(
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                errorBuilder: (_, __, ___) => const SizedBox(
                  height: 100,
                  child: Center(
                    child: Icon(Icons.broken_image_outlined,
                        size: 40, color: Colors.grey),
                  ),
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(
                      isPdf
                          ? Icons.picture_as_pdf_rounded
                          : Icons.insert_drive_file_rounded,
                      size: 48,
                      color: isPdf
                          ? const Color(0xFFD32F2F)
                          : const Color(0xFF1565C0),
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        Uri.parse(url).pathSegments.last,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A2E),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF1565C0),
                  side: const BorderSide(color: Color(0xFF1565C0)),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.download_rounded, size: 18),
                label: const Text(
                  'Download Document',
                  style: TextStyle(fontSize: 13),
                ),
                onPressed: () async {
                  final uri = Uri.parse(url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmAction(
    BuildContext context, {
    required String title,
    required String message,
    required Color confirmColor,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.download_rounded, color: Color(0xFF1565C0)),
            label: const Text(
              'Download',
              style: TextStyle(color: Color(0xFF1565C0)),
            ),
            onPressed: () async {
              final url = app.documentUrl;
              if (url != null) {
                final uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              }
              Navigator.pop(context);
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: confirmColor),
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case 'approved':
        color = Colors.green;
        break;
      case 'rejected':
        color = Colors.red;
        break;
      default:
        color = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
