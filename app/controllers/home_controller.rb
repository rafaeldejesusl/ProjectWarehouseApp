class HomeController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@warehouses = Warehouse.all
	end
end