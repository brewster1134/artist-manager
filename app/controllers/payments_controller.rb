class PaymentsController < ApplicationController
  include Settings.payment_module.to_s.titleize.delete(" ").constantize
end
