class ENVied::Variable
  attr_reader :name, :type, :group, :default, :custom_coercer

  def initialize(name, type, default: nil, coercer: nil, required: true, group: :default)
    @name = name.to_sym
    @type = type.to_sym
    @group = group.to_sym
    @default = default
    @custom_coercer = coercer
    @required = !!required
  end

  def default_value(*args)
    default.respond_to?(:call) ? default.call(*args) : default
  end

  def required?
    @required
  end

  def ==(other)
    self.class == other.class && self.hash == other.hash
  end

  protected

  def hash
    [name, type, group, default, custom_coercer, required?].hash
  end
end
