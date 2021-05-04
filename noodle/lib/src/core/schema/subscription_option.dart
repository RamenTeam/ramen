import 'package:graphql_flutter/graphql_flutter.dart';

SubscriptionOptions getQueryOptions({required String schema}) {
  return SubscriptionOptions(document: gql(schema));
}
