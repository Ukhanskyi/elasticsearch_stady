# frozen_string_literal: true

class User < ApplicationRecord
  update_index('users') { self }
end
