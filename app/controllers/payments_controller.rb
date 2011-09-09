class PaymentsController < ApplicationController
  skip_before_filter :check_for_user
  include Settings.payment_module.to_s.titleize.delete(" ").constantize
end
