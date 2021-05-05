import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:noodle/src/core/config/graphql_client.dart';
import 'package:noodle/src/core/models/ramen_api_response.dart';
import 'package:noodle/src/core/schema/mutation_option.dart';
import 'package:noodle/src/core/schema/mutations/accept_connection_request.mutation.dart';
import 'package:noodle/src/core/schema/mutations/reject_connection_request.mutation.dart';

class ConnectionRepository {
  Future<ErrorMessage?> acceptConnectionRequest({required String id}) async {
    GraphQLClient client = await getClient();

    final QueryResult res = await client.mutate(
        getMutationOptions(schema: acceptConnectionRequestMutation, variables: {
      "data": {
        "connectionId": id,
      }
    }));

    if (res.hasException) {
      print(res.exception.toString());
      return ErrorMessage(
        path: 'flutter',
        message: 'Accept connection request error',
      );
    }

    dynamic errJson = res.data['acceptConnectionRequest'];
    if (errJson == null) return null;
    ErrorMessage err = ErrorMessage(
      message: errJson['message'],
      path: errJson['path'],
    );
    return err;
  }

  Future<ErrorMessage?> rejectConnectionRequest({required String id}) async {
    GraphQLClient client = await getClient();

    final QueryResult res = await client.mutate(
        getMutationOptions(schema: rejectConnectionRequestMutation, variables: {
      "data": {
        "connectionId": id,
      }
    }));

    if (res.hasException) {
      print(res.exception.toString());
      return ErrorMessage(
        path: 'flutter',
        message: 'Reject connection request error',
      );
    }

    dynamic errJson = res.data['rejectConnectionRequest'];
    if (errJson == null) return null;
    ErrorMessage err = ErrorMessage(
      message: errJson['message'],
      path: errJson['path'],
    );
    return err;
  }
}
