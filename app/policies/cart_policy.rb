class CartPolicy < ApplicationPolicy
  def show?
    user.present? && (record == user || user_has_power?)
  end

  def add_item?
    show?
  end

  def update_item?
    show?
  end

  def remove_item?
    show?
  end

  private

  def user_has_power?
    user.admin?
  end
end
