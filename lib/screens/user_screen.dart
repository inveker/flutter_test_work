import 'package:flutter/material.dart';
import 'package:flutter_test_work/api/api_jsonplaceholder.dart';
import 'package:flutter_test_work/models/user_model.dart';
import 'package:flutter_test_work/widgets/albums_preview.dart';
import 'package:flutter_test_work/widgets/email_link.dart';
import 'package:flutter_test_work/widgets/filed_divider.dart';
import 'package:flutter_test_work/widgets/filed_title.dart';
import 'package:flutter_test_work/widgets/multi_field.dart';
import 'package:flutter_test_work/widgets/phone_link.dart';
import 'package:flutter_test_work/widgets/posts_preview.dart';
import 'package:flutter_test_work/widgets/preloader.dart';
import 'package:flutter_test_work/widgets/props_widget.dart';
import 'package:flutter_test_work/widgets/simple_field.dart';
import 'package:flutter_test_work/widgets/website_link.dart';
import 'package:url_launcher/url_launcher.dart';

class UserScreenArgs {
  final int userId;

  UserScreenArgs({
    required this.userId,
  });
}

class UserScreen extends StatelessWidget {
  static const routeName = 'user';

  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserScreenArgs routeArgs = ModalRoute.of(context)!.settings.arguments as UserScreenArgs;

    return SafeArea(
      child: FutureBuilder<UserModel>(
        future: ApiJsonPlaceholder.getUser(routeArgs.userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _ScreenProps(
              user: snapshot.data!,
            );
          } else {
            return const Preloader();
          }
        },
      ),
    );
  }
}

class _ScreenProps extends PropsWidget {
  final UserModel user;

  _ScreenProps({
    required this.user,
  }) : super(child: _Screen());
}

class _Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final props = context.props<_ScreenProps>();
    final user = props.user;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _NameField(),
            const FieldDivider(),
            _EmailField(),
            const FieldDivider(),
            _PhoneField(),
            const FieldDivider(),
            _WebsiteField(),
            const FieldDivider(),
            _WorkingField(),
            const FieldDivider(),
            _AddressField(),
            const FieldDivider(),
            _PostsFiled(),
            const FieldDivider(),
            _AlbumsField(),
          ],
        ),
      ),
    );
  }
}

class _PostsFiled extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final props = context.props<_ScreenProps>();
    final user = props.user;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FieldTitle(
            title: 'Posts',
          ),
          const SizedBox(height: 16,),
          PostsPreview(
            userId: user.id,
            count: 3,
          ),
        ],
      ),
    );
  }
}

class _AlbumsField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final props = context.props<_ScreenProps>();
    final user = props.user;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FieldTitle(
            title: 'Albums',
          ),
          const SizedBox(height: 16,),
          AlbumsPreview(
            userId: user.id,
            count: 3,
          ),
        ],
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final props = context.props<_ScreenProps>();
    final user = props.user;
    return SimpleField(
      title: 'Name',
      value: Text(user.name),
    );
  }
}

class _EmailField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final props = context.props<_ScreenProps>();
    final user = props.user;
    return SimpleField(
      title: 'Email',
      value: EmailLink(
        email: user.email,
      ),
    );
  }
}

class _PhoneField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final props = context.props<_ScreenProps>();
    final user = props.user;
    return SimpleField(
      title: 'Phone',
      value: PhoneLink(
        phone: user.phone,
      ),
    );
  }
}

class _WebsiteField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final props = context.props<_ScreenProps>();
    final user = props.user;
    return SimpleField(
      title: 'Website',
      value: WebsiteLink(
        url: user.website,
      ),
    );
  }
}

class _WorkingField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final props = context.props<_ScreenProps>();
    final user = props.user;
    return MultiField(
      title: 'Working',
      children: [
        SimpleField(
          title: 'Name',
          value: Text(user.company.name),
        ),
        SimpleField(
          title: 'BS',
          value: Text(user.company.bs),
        ),
        SimpleField(
          title: 'Catch Phrase',
          value: Text(
            user.company.catchPhrase,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}

class _AddressField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final props = context.props<_ScreenProps>();
    final user = props.user;
    return MultiField(
      title: 'Address',
      children: [
        SimpleField(
          title: 'City',
          value: Text(user.address.city),
        ),
        SimpleField(
          title: 'Street',
          value: Text(user.address.street),
        ),
        SimpleField(
          title: 'Suite',
          value: Text(user.address.suite),
        ),
        SimpleField(
          title: 'Zipcode',
          value: Text(user.address.zipcode),
        ),
        MultiField(
          title: 'Geo',
          children: [
            SimpleField(
              title: 'Latitude',
              value: Text('${user.address.geo.lat}'),
            ),
            SimpleField(
              title: 'Longitude',
              value: Text('${user.address.geo.lng}'),
            ),
          ],
        ),
      ],
    );
  }
}

