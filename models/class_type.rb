class ClassType

  TYPES_BY_ROLE = {
    'Creation'  => ['Builder', 'Factory', 'Pool', 'Prototype'],
    'Interface' => ['Adapter', 'Interface']
  }

  def self.roles
    TYPES_BY_ROLE.keys
  end

  def self.for_role(role)
    TYPES_BY_ROLE[role] || []
  end
end