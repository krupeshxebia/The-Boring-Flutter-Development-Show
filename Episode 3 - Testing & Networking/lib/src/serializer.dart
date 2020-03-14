library serializers;

import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'article.dart';
part 'serializer.g.dart';

@SerializersFor([
  Article,
])

/// Collection of generated serializers for the built_json chat example.
Serializers serializers = _$serializers;

Serializers standardSerializers = (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
