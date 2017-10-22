class Property < ApplicationRecord
  enum tipo: { house: 0, department: 1}

end
