class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :first_name, :last_name, :email, :uid, :image
end