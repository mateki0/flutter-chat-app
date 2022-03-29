String sendMessage = """
  mutation(\$body: String!, \$roomId: String!) {
    sendMessage(body: \$body, roomId: \$roomId) {
      id
      body
    }
  }
""";
