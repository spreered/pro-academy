module Entities
  class Base < Grape::Entity
    format_with(:iso_timestamp) { |dt| dt.iso8601 }
    format_with(:money) {|price| price.format}
  end
end
