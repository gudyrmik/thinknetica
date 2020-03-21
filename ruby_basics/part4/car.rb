# API объекта вагона :)
# хотя к его типу и нету обращения и можно было бы его поместить в private,
# делать эту инфу скрытой как-то не логично
class Car
  attr_reader :type

  def initialize(type)
    @type = type
  end
end