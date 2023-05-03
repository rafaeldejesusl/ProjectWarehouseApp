class SuppliersController < ApplicationController
	def index
		@suppliers = Supplier.all
	end

  def show
		@supplier = Supplier.find(params[:id])
	end

	def new
		@supplier = Supplier.new()
	end

	def create
		supplier_params = params.require(:supplier).permit(:brand_name, :corporate_name, :city,
			:state, :address, :registration_number, :email)
		@supplier = Supplier.new(supplier_params)
		if @supplier.save()
			redirect_to suppliers_path, notice: 'Fornecedor cadastrado com sucesso'
		else
			flash.now[:notice] = 'Fornecedor não cadastrado'
			render 'new'
		end	
	end
end