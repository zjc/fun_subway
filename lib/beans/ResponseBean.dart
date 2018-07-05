
class ResponseBean<T> {
  final String code;
  final T data;
  final String error_code;
  final String error_reason;

  const ResponseBean(
      this.code, this.data, this.error_code, this.error_reason);
}
