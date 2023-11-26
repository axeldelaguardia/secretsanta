class UserBlueprint < Blueprinter::Base
  identifier :id

  view :default do
    fields :first_name, :last_name, :email
  end
  
  view :extended do
    include_view :default
    field(:secret_santa) do |user| 
      "#{User.find(user.secret_santa_id).first_name} #{User.find(user.secret_santa_id).last_name}" if user.secret_santa_id
    end
  end

  view :bea do
    include_view :default
    include_view :extended
    field(:steven_ss) do |user|
      stevens_ss = User.find_by(first_name: "Steven").secret_santa_id
      User.find(stevens_ss).first_name if user.id == stevens_ss
      "#{User.find(stevens_ss).first_name} #{User.find(stevens_ss).last_name}"
    end
  end
end