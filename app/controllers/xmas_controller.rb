require 'json'

class XmasController < ApplicationController
  layout "xmas"

  def index
    if DateTime.now > DateTime.new(2023, 11, 26) && current_user
      if current_user.first_name == "Beatriz"
        @user = UserBlueprint.render(current_user, view: :bea)
      else
        @user = UserBlueprint.render(current_user, view: :extended)
      end
    else
      @user = UserBlueprint.render(current_user) if current_user
    end
  end

  def assign
    user_ids = User.pluck(:id)
    shuffled_ids = user_ids.shuffle

    shuffled_ids.each_with_index do |secret_santa_id, index|
      if secret_santa_id == user_ids[index]
        swap_index = (index + 1) % shuffled_ids.length
        shuffled_ids[index], shuffled_ids[swap_index] = shuffled_ids[swap_index], shuffled_ids[index]
      end
    end

    User.transaction do
      user_ids.zip(shuffled_ids).each do |user_id, secret_santa_id|
        User.find(user_id).update!(secret_santa_id: secret_santa_id)
      end
    end

    render :index
  end
end