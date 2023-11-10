/// The HTTP request methods allowed on the [NetClient]
enum NetRequestMethods {
  /// Retrieves a resource
  get,

  /// Submits new resource
  post,
}

/// The default extension to [NetRequestMethods] to add essential methods
extension DefaultNetRequestMethodsExtension on NetRequestMethods {
  /// Returns the HTTP name of the [NetRequestMethods]
  String get name {
    switch (this) {
      case NetRequestMethods.get:
        return 'GET';

      case NetRequestMethods.post:
        return 'POST';

      default:
        throw UnsupportedError(
          'NetRequestMethods.name unsupported for type $this',
        );
    }
  }
}
