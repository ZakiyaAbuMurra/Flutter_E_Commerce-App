import 'package:ecommrac_app/view_models/profile_cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  final String userId;

  ProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Trigger loading the user profile

    return BlocProvider(
      create: (context) {
        final cubit = ProfileCubit();
        cubit.userService;
        return cubit;
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            // Now we have a single UserModel instance
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 24),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: state.user.imageUrl != null
                      ? NetworkImage(state.user.imageUrl!)
                      : const AssetImage('assets/images/default_avatar.png')
                          as ImageProvider,
                ),
                const SizedBox(height: 24),
                Text(
                  state.user.fullName,
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                if (state.user.email.isNotEmpty)
                  _buildDetailItem(context, 'Email', state.user.email),
                if (state.user.phoneNumber != null &&
                    state.user.phoneNumber!.isNotEmpty)
                  _buildDetailItem(
                      context, 'Phone Number', state.user.phoneNumber!),
                // if (state.user.birthDate != null)
                //   _buildDetailItem(context, 'Birthday', DateFormat('yyyy-MM-dd').format(state.user.birthDate!)),
                if (state.user.address != null &&
                    state.user.address!.isNotEmpty)
                  _buildDetailItem(context, 'Address', state.user.address!),
                // Add more fields as needed
              ],
            );
          } else if (state is ProfileError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          // Initial state or any other unhandled state
          return const Center(child: Text('Unable to load profile'));
        },
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(color: Colors.black54),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
