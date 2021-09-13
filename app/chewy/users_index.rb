# frozen_string_literal: true

# class for creating Users index
class UsersIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      email: {
        tokenizer: 'keyword',
        filter: ['lowercase']
      }
    }
  }

  index_scope User
  field :first_name, type: 'keyword'
  field :last_name
  field :email, analyzer: 'email'
end
