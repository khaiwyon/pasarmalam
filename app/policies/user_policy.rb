class UserPolicy < ApplicationPolicy

  def new?
  end

  def edit?
    user.present? && (record == user || user_has_power?)
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  private

  def user_has_power?
    user.admin?
  end
end
