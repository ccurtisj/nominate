class ClassType

  TYPES_BY_ROLE = {
    'Business Object' => [''],
    'Adaptor'         => ['Adapter', 'Interface'],
    'Creation'        => ['Builder', 'Director', 'Factory', 'Pool', 'Prototype'],
    'Events'          => ['Observer', 'Monitor', 'Reporter', 'Spectator'],
    'Decoration'      => ['able', 'Decorator'],
    'Delegation'      => ['Agent', 'Delegate', 'Strategy'],
    'Interface'       => ['Adapter', 'Interface'],
    'Implementation'  => ['Command', 'Strategy'],
    'Job Queue'       => ['Job', 'Task', 'Worker'],
    'Mixin'           => ['able'],
    'Messaging'       => ['Dispatch', 'Reporter', 'Queue'],
    'Proxy'           => ['Agent', 'Proxy'],
    'Structure'       => ['Composite', 'Iterator']
  }

  def self.roles
    TYPES_BY_ROLE.keys
  end

  def self.for_role(role)
    TYPES_BY_ROLE[role] || []
  end
end