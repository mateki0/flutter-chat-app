String typingUser = """
  subscription typingUser(\$roomId: String!){
    typingUser(roomId: \$roomId){
      id
      firstName
    }
  }
""";
