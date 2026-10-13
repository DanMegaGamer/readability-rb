# frozen_string_literal: true

module Readability
  Result = Struct.new(
    :title,
    :byline,
    :dir,
    :lang,
    :content,
    :text_content,
    :length,
    :excerpt,
    :site_name,
    :published_time,
    keyword_init: true
  ) do
    # The author name from the byline, without a leading "By" and without
    # trailing lines such as a date or a publication name.
    def author
      return nil if byline.nil?

      name = byline.sub(/\A\s*(?:written\s+)?by\b\s*:?\s*/i, "").lines.first.to_s.squeeze(" ").strip
      name.empty? ? nil : name
    end
  end
end
