# frozen_string_literal: true

# class for searching users
class UsersSearch
  FILTER_SIZE = 1000

  attr_reader :query

  def initialize(args = {})
    @query = args[:query]
  end

  def search
    chewy_index
      .query(query_condition)
      .aggs(aggregation_condition)
      .limit(FILTER_SIZE)
  end

  private

  def chewy_index
    UsersIndex
  end

  def aggregation_condition
    {
      languages: {
        terms: { field: 'programing_language' }
      },
      cities: {
        terms: { field: 'city_id' }
      }
    }
  end

  def query_condition
    return { match_all: {} } if query.blank?

    {
      query_string: {
        fields: %i[first_name last_name email],
        query: query
      }
    }
  end
end
