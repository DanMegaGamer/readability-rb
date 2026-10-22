# frozen_string_literal: true

require "test_helper"

class TestMetadata < Minitest::Test
  BODY = "<p>#{"Lorem ipsum dolor sit amet, consectetur adipiscing elit. " * 20}</p>"

  def page(head: "", body_prefix: "")
    "<html><head><title>Title</title>#{head}</head>" \
      "<body><article>#{body_prefix}#{BODY}#{BODY}</article></body></html>"
  end

  def json_ld(json)
    %(<script type="application/ld+json">#{json}</script>)
  end

  def parse(**kwargs)
    Readability.parse(page(**kwargs))
  end

  def test_json_ld_with_unexpected_shapes_is_skipped
    baseline = parse

    ["null", "5", "[null]", "[5]", '[{"@type":[{}]}]'].each do |json|
      result = parse(head: json_ld(json))

      assert_equal baseline.title, result.title, "title for #{json}"
      assert_nil result.byline, "byline for #{json}"
    end
  end
end
