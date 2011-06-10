module RailsJavaScriptHelpers

  JS_ESCAPE_MAP = {"\""=>"\\\"", "\r"=>"\\n", "\\"=>"\\\\", "'"=>"\\'", "\r\n"=>"\\n", "</"=>"<\\/", "\n"=>"\\n"}

  # arg:: Object
  # Does a simple transition on types from Ruby to Javascript.
  def format_type_to_js(arg)
    case arg
      when Array
        "[#{arg.map{|value| format_type_to_js(value)}.join(',')}]"
      when Hash
        "{#{arg.map{ |key, value|
          k = key.is_a?(Symbol) ? key.to_s.camelize.sub(/^./, key.to_s[0,1].downcase) : key.to_s
          "#{k}:#{format_type_to_js(value)}"
        }.join(',')}}"
      when Fixnum
        arg.to_s
      when TrueClass
        arg.to_s
      when FalseClass
        arg.to_s
      when NilClass
        'null'
      else
        arg.to_s =~ %r{^\s*function\s*\(} ? arg.to_s : "'#{custom_escape_javascript(arg.to_s)}'"
    end
  end

  # id:: DOM ID of element
  # Ensure that the DOM ID starts with a '#'
  # if the provided values is a string starting
  # with a letter
  # (Basically compat mode with prototype style)
  def format_id(id)
    id.to_s[0,1] =~ /[A-Za-z0-9]/ ? "##{id}" : id
  end

  private

  # Pulled from rails to keep consistency
  def custom_escape_javascript(javascript)
    if javascript
      javascript.gsub(/(\\|<\/|\r\n|[\n\r"'])/) {|part| JS_ESCAPE_MAP[part]}
    else
      ''
    end
  end
end
