defmodule Forms.ProcessDelete do
  def process() do
    receive do
      after
        10000 ->
          IO.puts("Pasaron 10 segundos")
          files = File.ls!("./bd")
          #No tengo permisos de super usuario
          Enum.each(files, fn(file) ->
            File.rm!("./bd/#{file}")
          end)
          process()
      end
    end
end
