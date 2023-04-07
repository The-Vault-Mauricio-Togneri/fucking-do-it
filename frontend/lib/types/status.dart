enum Status {
  sent,
  accepted,
  done;

  static Status parse(String name) {
    for (final value in Status.values) {
      if (value.name == name) {
        return value;
      }
    }

    throw Error();
  }
}
