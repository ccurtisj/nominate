require 'classify'
require 'dinosaurus'
require File.join(File.dirname(__FILE__), 'class_type')

class SuggestionRequest

  # Encapsulates the data around a request for a suggestion

  attr_accessor :keyword, :role

  def initialize(keyword, role=nil)
    self.keyword = keyword
    self.role = role
  end

  def suggestions
    # byebug
    synonyms = Dinosaurus.lookup(keyword)[:noun]['syn'].uniq.sort

    terms = [keyword] + synonyms

    class_names = terms.uniq.compact.collect{|keyword|
      Classify.new.camelize(sanitize(keyword)).to_s
    }

    class_types = ClassType.for_role(self.role)

    class_types.collect do |type|
      class_names.collect do |class_name|
        class_name + type
      end
    end.reject(&:blank?)
  end


  private

  def sanitize(keyword)
    keyword.gsub(/[\s-]/, '_')
      .gsub("'", '')
  end
end