import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/domain/entities/user/user.dart';
import 'package:flutter_boilerplate/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter_boilerplate/presentation/router/app_routes.dart';
import 'package:flutter_boilerplate/presentation/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
        actions: [
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.authResource.isInitial ||
                  state.authResource.isError ||
                  !state.authResource.isSuccess) {
                const LoginRoute().go(context);
              }
            },
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEvent.logout());
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.authResource.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.authResource.isSuccess) {
            final User? user = state.authResource.data;
            if (user != null) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Welcome Card
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: AppColors.onPrimary,
                                    size: 32,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Halo, ${user.name}!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        user.email,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: AppColors.neutral600,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.success.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: AppColors.success,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Anda berhasil login!',
                                    style: TextStyle(
                                      color: AppColors.success,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Features Section
                    Text(
                      'Fitur Aplikasi',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    const SizedBox(height: 16),

                    // Feature Cards Grid
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.2,
                      children: [
                        _FeatureCard(
                          icon: Icons.account_circle,
                          title: 'Profil',
                          subtitle: 'Kelola profil Anda',
                          color: AppColors.primary,
                          onTap: () {
                            // Navigate to profile
                          },
                        ),
                        _FeatureCard(
                          icon: Icons.settings,
                          title: 'Pengaturan',
                          subtitle: 'Konfigurasi aplikasi',
                          color: AppColors.secondary,
                          onTap: () {
                            // Navigate to settings
                          },
                        ),
                        _FeatureCard(
                          icon: Icons.notifications,
                          title: 'Notifikasi',
                          subtitle: 'Kelola notifikasi',
                          color: AppColors.info,
                          onTap: () {
                            // Navigate to notifications
                          },
                        ),
                        _FeatureCard(
                          icon: Icons.help,
                          title: 'Bantuan',
                          subtitle: 'Pusat bantuan',
                          color: AppColors.warning,
                          onTap: () {
                            // Navigate to help
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          }

          return const Center(
            child: Text('Tidak dapat memuat data'),
          );
        },
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
