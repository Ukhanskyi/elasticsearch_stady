# frozen_string_literal: true

# class for aggregations
class ElasticAggregationsSerializer
  attr_reader :aggs

  def initialize(aggs)
    @aggs = aggs
  end

  def to_hash
    result = {}
    aggs.each do |agg_name, agg_data|
      bucket_rows = buckets(agg_data)

      agg_data = bucket_rows.map do |bucket_row|
        serialize_row(agg_name, bucket_row)
      end

      agg_data = as_hash_with_keys(agg_data)

      result[agg_name] = agg_data
    end
    result
  end

  private

  def buckets(agg_data)
    agg_data['buckets']
  end

  def row_key(backet_row)
    backet_row['key']
  end

  def row_size(backet_row)
    backet_row['doc_count']
  end

  def serialize_row(_agg_name, backet_row)
    {
      key: row_key(backet_row),
      size: row_size(backet_row)
    }
  end

  def as_hash_with_keys(array, key = :key)
    array.index_by { |i| i[key] }
  end
end
