class Property < ApplicationRecord
  enum tipo: { house: 0, department: 1}
  validates :title, presence:{message:" no puede estar vacio"}
  validates :address, presence:{ message:" no puede estar vacio"}
  validates :zipcode,presence:{ message:" no puede estar vacio"}
  validates :country, presence:{ message:" no puede estar vacio"}

  validates :title, length: {
            minimum: 15,
            maximum:45,
            too_long:"Debe tener longitud máxima de 45 caracteres",
            too_short:"Debe tener longitud minima de 15 caracteres"
             }
  validates :address, length: {
            minimum:30,
            maximum:140,
            too_long:"Debe tener longitud máxima de 140 caracteres",
            too_short:"Debe tener longitud minima de 30 caracteres"
                        }
validates :zipcode,format:{
          with: /\A[+-]?\d+\Z/,
          message:"Sólo se aceptan números"
          }
validates :zipcode, length: {
            is:5,
            message:"Debe tener longitud exacta de 6 caracteres"
          }
validates :zipcode, numericality: {
          only_integer: true,
          greater_than_or_equal_to: 10000,
          less_than_or_equal_to: 99999,
          message:"Debe ser un número válido entre 10000 y 99999."
        }
validates :country,length:{
          is:2,
          message:"Debe tener una longitud exacta de 2 caracteres"
}

validates :country,inclusion:{
          in: %w(mx us ca),
          message:"puede tener alguno de los valores mx,us,ca "
}







end
