module Entities
  class Base < Grape::Entity
    format_with(:iso_timestamp) { |dt| dt.iso8601 if dt }
    format_with(:money) {|price| price.format}
  end
end
