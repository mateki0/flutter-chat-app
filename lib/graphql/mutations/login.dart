String login = """
  mutation(\$email: String!, \$password: String!) {
    loginUser(email: \$email, password: \$password) {
      token
      user {
        id
        firstName
      }
    }
  }
""";
