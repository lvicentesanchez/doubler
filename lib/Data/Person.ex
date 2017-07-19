defmodule Data.Person do
    @derive [Poison.Encoder]
    defstruct [:name, :age]

    use Vex.Struct

    validates :name, presence: true

    validates :age, &is_integer/1
end
