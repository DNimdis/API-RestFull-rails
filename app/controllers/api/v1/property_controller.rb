class  Api::V1::PropertyController < ApplicationController
before_action :require_idExist!,except: [:index,:create,:new,:edit]
before_action :require_propertyAtribute!,except: [:index,:show,:destroy,:new,:edit]


  def index
    @property = Property.all

     respond_to do |format|
       format.json { render json: {properties: @property}, status: 200 }
     end
  end

  def show
     id = params[:id]
     @property = Property.find(id);
     respond_to do |format|
       format.json { render json: @property, status: 200 }
     end

  end


  def create
     parametros = JSON.parse(params[:data])
     @property = Property.new(parametros)
     respond_to do |format|
       if @property.save
         format.json { render json: @property, status: 200 }
       end
     end
  end


  def update
    @property = Property.find(params[:id])
    parametros = JSON.parse(params[:data])

    respond_to do |format|
      if @property.update(parametros)
          format.json { render json: @property, status: 200 }
      else
         format.json { render json: @property, status: 400}
      end
    end

  end


  def destroy
      @property = Property.find(params[:id])

      respond_to do |format|
        begin
         @property.destroy

          format.json { render json: {message:'La propiedad fue elimina con exito.'} , status: 400 }
        rescue
            format.json { render json: @property.errors, status: :unprocessable_entity }
        end
      end
  end


def require_idExist!
    return true if authenticate_id
    render json: { response:false,message: "La propiedad no fue encontrada en el CMS" }, status: 400
end


def require_propertyAtribute!
    return true if validate_property
    if !@no_exist.empty?
      render json: { response:false,message: "Hace falta la variable #{@no_exist} en el JSON de entrada." }, status: 400
    end
    if !@vacioItem.empty?
      render json: { response:false,message: "La variable #{@vacioItem} se encuentra vacia." }, status: 400
    end
    if !@addresslong.empty?
      render json: { response:false,message: "#{@addresslong}" }, status: 400
    end
end

def edit
   render json: { response:false,message: "Acceso denegado, comuniquese con el Administrador" }, status: 500
end

def new
    render json: { response:false,message: "Acceso denegado, comuniquese con el Administrador" }, status: 500
end


protected
def authenticate_id
    if params[:id]
      id = params[:id]
       Property.find_by(id: id).present?
     else
       return false
    end
end
def validate_property
   @no_exist = ""
   @vacioItem= ""
   @addresslong =""
   parametros = JSON.parse(params[:data])
   parametrosEntrada =['tipo', 'title', 'address', 'zicpcode', 'country', 'notes']
   parametrosEntrada.each do |item|
      if parametros.has_key?(item) == false
        @no_exist= item
        break
      end
   end
   if @no_exist.empty?
      parametros.each do |key,value|
        if key !="notes"
        if value.empty?
           @vacioItem= key
           break
        end
      end
      end
    else
      return false
   end
      if ["house","department"].include?(parametros['tipo'].to_s)
      else
        @addresslong="tipo, Solo puede tener dos valores validos: 'house' o 'department'."
        return false
      end
     if !parametros['title'].size.between?(15,45)
       @addresslong="title, debe tener longitud maxima de 45 caracteres, y minima de 15."
       return false
     end

     if !parametros['address'].size.between?(30,140)
       @addresslong="address, debe tener longitud maxima de 140 caracteres, y minima de 30."
       return false
     end

     if parametros['zicpcode'].size == 5
       numero = parametros['zicpcode']
       evaluacion = numero.match /^\d+$/
       if evaluacion ? true : false;
         if !parametros['zicpcode'].to_i.between?(10000,99999)
           @addresslong="zicpcode, debe tener longitud máxima de 140 caracteres, y mínima de 30."
           return false
         end
       else
         @addresslong="zicpcode, solo aceptan numeros. "
         return false
       end
     else
       @addresslong=" zicpcode, debe tener longitud exacta de 5 caracteres."
       return false
     end

     if parametros['country'].size == 2

       if ["mx", "us", "ca"].include?(parametros['country'].to_s)

       else
         @addresslong="country, puede tener alguno de los valores: 'mx','us','ca' "
         return false

       end
     else
       @addresslong="country, debe tener una longitud exacta de 2 caracteres."
       return false
     end

     if parametros['notes'].size <= 300
     else
       @addresslong="notes, debe tener longitud maxima de 300 caracteres"
       return false
     end


end




end
