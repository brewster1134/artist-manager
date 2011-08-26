class PaymentsController < ApplicationController
  include Settings.payment_module.titleize.delete(" ").constantize
end
