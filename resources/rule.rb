actions :add, :delete
default_action :add

attribute :group, :kind_of => [String, Symbol], :default => 'default'
attribute :ript, :kind_of => Proc, :required => true

def ript(&block)
  if block_given? and ript
    @ript = ript
  else
    @ript
  end
end
