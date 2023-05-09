class SuppliersController < ApplicationController
	before_action :authenticate_user!
	
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
			:state, :full_address, :registration_number, :email)
		@supplier = Supplier.new(supplier_params)
		if @supplier.save()
			redirect_to suppliers_path, notice: 'Fornecedor cadastrado com sucesso'
		else
			flash.now[:notice] = 'Fornecedor não cadastrado'
			render 'new'
		end	
	end

	def edit
		id = params[:id]
		@supplier = Supplier.find(id)
	end

	def update
		id = params[:id]
		@supplier = Supplier.find(id)
	
		supplier_params = params.require(:supplier).permit(:brand_name, :corporate_name, :city,
			:state, :full_address, :registration_number, :email)
		if @supplier.update(supplier_params)
			redirect_to supplier_path(@supplier.id), notice: 'Fornecedor atualizado com sucesso'
		else
			flash.now[:notice] = 'Não foi possível atualizar o fornecedor'
			render 'edit'
		end
	end
end