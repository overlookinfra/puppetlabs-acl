require 'puppet/parameter/value_collection'

class Puppet::Type::Acl::Ace

  attr_accessor :identity
  attr_accessor :rights
  attr_accessor :type
  attr_accessor :child_types
  attr_accessor :affects

  def initialize(permission_hash)
    @identity = permission_hash["identity"]
    @rights = permission_hash["rights"]
    #newvalues(:full, :modify, :write, :list, :read, :execute)
    @type = validate_and_return(permission_hash["type"] || "allow",:allow,:deny)
    @child_types = validate_and_return(permission_hash["child_types"] || "all",:all, :objects, :containers)
    @affects = validate_and_return(permission_hash["affects"] || "all",:all, :self_only, :children_only, :self_and_direct_children, :direct_children_only)
  end

  def validate_and_return(value,*allowed_values)
    validator = Puppet::Parameter::ValueCollection.new
    validator.newvalues(*allowed_values)
    validator.validate(value)

    return value
  end

end


# Puppet::Type.newtype(:ace) do
#   @doc = <<-'EOT'
#     Manages access control lists.  The `acl` type is typically
#     used in when you need more complex management of permissions
#     e.g. windows.

#     Sample usage:

#       ADD HERE LATER
#   EOT

#   feature :ace_order_required, "The provider determines if the order of access control entries (ACE) is required."

#   newparam(:name) do
#     desc "The name of the acl resource.  Used for uniqueness."
#     isnamevar
#   end

#   newparam(:identity) do
#     desc "Identity is also known as a trustee or principal - what gets
#       assigned a particular set of permissions (or access rights).
#       This can be in the form of: 1. User - e.g. 'Bob' or 'TheNet\Bob',
#       2. Group e.g. 'Administrators' or 'BUILTIN\Administrators', 3.
#       SID (Security ID) e.g. 'S-1-5-18'."
#     defaultto ''
#   end

#   newparam(:rights) do
#     desc "[Empty for now]"
#     #newvalues(:full, :modify, :write, :list, :read, :execute)

#     # binary hex flags
#     defaultto []
#   end

#   newparam(:type) do
#     desc "[Empty for now]"
#     newvalues(:allow, :deny)
#     defaultto :allow
#   end

#   newparam(:child_types) do
#     desc "[Empty for now]"
#     newvalues(:all, :objects, :containers)
#     defaultto :all
#   end

#   newparam(:affects) do
#     desc "[Empty for now]"
#     newvalues(:all, :self_only, :children_only, :self_and_direct_children, :direct_children_only)
#     defaultto :all
#   end
# end
