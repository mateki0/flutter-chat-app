String singleRoom = """
  query room(\$id: ID!){
      room(id:\$id){
        id
        name
        messages{
          body
          id
          insertedAt
        }
        user{
          firstName
          id
          lastName
          email
        }
      }
    }
""";
