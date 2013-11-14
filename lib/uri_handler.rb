class URIHandler
  def initialize uri
    @uri = uri
  end

  def match? uri
    rui_pattern = tiers @uri
    rui_entity = tiers uri
    rui_pattern.each_with_index do |value, index|
      return false unless value[0] == ':' || value == rui_entity[index]
    end
    return true
  end

  def extract_params uri
    return {} unless match? uri
    params = {}
    rui_pattern = tiers @uri
    rui_entity = tiers uri
    rui_pattern.each_with_index do |value, index|
      params[value[1..-1].to_sym] = rui_entity[index] if value[0] == ':'
    end
    params
  end

  private 

  def tiers uri
    uri.split '/'
  end

end