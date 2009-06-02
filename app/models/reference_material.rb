class ReferenceMaterial < Attachment
  acts_as_commentable
  #has_and_belongs_to_many :roles
  has_and_belongs_to_many :categories
end
