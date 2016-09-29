class ApplicationPolicy
    attr_reader :user, :record

    def initialize(user, record)
      @user = user
      @record = record
    end

    def scope
      Pundit.policy_scope!(user, record.class)
    end

    def dashboard?
      user.present? && user_has_power?
    end

    def rails_admin?
      dashboard?
    end

    def index?
      dashboard?
    end

    def new?
      dashboard?
    end

    def export?
      dashboard?
    end

    def bulk_delete?
      dashboard?
    end

    def show?
      dashboard?
    end

    def edit?
      dashboard?
    end

    def destroy?
      dashboard?
    end

    def show_in_app?
      dashboard?
    end

    private

    def user_has_power?
      user.admin?
    end
  end
