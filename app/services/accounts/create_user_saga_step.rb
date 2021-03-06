# frozen_string_literal: true

module Accounts
  class CreateUserSagaStep < SagaStep
    def step_forward
      response = Users::User.create(owner_params)
      if response[:success]
        outcome_data[:account][:owner] = response[:user]
      end
    end

    private

      def owner_params
        {
          account_id: outcome_data.dig(:account, :id),
          email: params.dig(:account, :owner, :email),
          password: params.dig(:account, :owner, :password)
        }
      end
  end
end
