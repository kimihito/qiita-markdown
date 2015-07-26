module Qiita
  module Markdown
    module Filters
      class Emoji < HTML::Pipeline::EmojiFilter
        def emoji_url(name)
          url = custom_emoji_url_generator.call(name) if custom_emoji_url_generator
          url || super
        end

        def custom_emoji_url_generator
          context[:emoji_url]
        end

        def emoji_pattern
          @emoji_pattern ||= /:(#{emoji_names.map { |name| Regexp.escape(name) }.join('|')}):/
        end

        def emoji_names
          (self.class.emoji_names + Array(context[:additional_emoji_names])).sort
        end
      end
    end
  end
end
