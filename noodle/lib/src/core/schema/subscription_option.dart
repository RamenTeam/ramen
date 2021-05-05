import 'package:graphql_flutter/graphql_flutter.dart';

SubscriptionOptions getSubscriptionOptions({required String schema}) {
  return SubscriptionOptions(document: gql(schema));
}
