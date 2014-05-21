# Javascript helper methods
module RailsJavaScriptHelpers

  if(defined?(ActionView::Helpers::JavaScriptHelper))
    include ActionView::Helpers::JavaScriptHelper
  end

  # Format object into JS compatible type
  #
  # @param arg [Object]
  # @return [String]
  def format_type_to_js(arg)
    case arg
    when Array
      "[#{arg.map{|value| format_type_to_js(value)}.join(',')}]"
    when Hash
      content = arg.map do |k,v|
        k = k.is_a?(Symbol) ? key.to_s.camelize.sub(/^./, key.to_s[0,1].downcase) : format_type_to_js(k)
        "#{k}: #{format_type_to_js(v)}"
      end.join(',')
      "{#{content}}"
    when Numeric, TrueClass, FalseClass, RawJS
      arg.to_s
    when NilClass
      'null'
    else
      arg.to_s.gsub(/\s+/, ' ') =~ %r{^\s*function\s*\(} ? arg.to_s : "'#{escape_javascript(arg.to_s)}'"
    end
  end

  # Ensure DOM ID starts with '#' character. This is provided
  # as a compat method for old prototype style.
  #
  # @param id [String]
  # @return [String]
  def format_id(id)
    id.to_s[0,1] =~ /[A-Za-z0-9]/ ? "##{id}" : id
  end

end

# Wrapper to allow unaltered pass through
class RawJS
  def initialize(s)
    @s = s
  end
  def to_s
    @s
  end
end
