defmodule TestMacro do
  def unquote(:"end")(a) do
    IO.puts a
  end
end
