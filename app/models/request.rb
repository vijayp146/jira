class Request
  include ActiveAttr::Attributes

  attribute :host
  attribute :context
  attribute :username
  attribute :password
  attribute :jql
end
