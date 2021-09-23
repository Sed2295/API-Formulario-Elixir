defmodule Forms.ProcessDelete do
  use Task
  #Task para eliminar los archivos cada 10 segundos
  def start_link(_arg) do
    Task.start_link(&poll/0)
  end
  def poll() do
    receive do
      after
        15000 ->
          delete_users()
          poll()
    end
  end
  defp delete_users() do
    files = File.ls!("./bd")
    Enum.each(files, fn(file) ->
      File.rm!("./bd/#{file}")
    end)
  end
end
#CODIGO PARA BORRAR LLAMANDO MANUALMENTE
#def process() do
  #  receive do
  #    after
  #      10000 ->
  #  IO.puts("Pasaron 10 segundos")
  #  files = File.ls!("./bd")
  #  #No tengo permisos de super usuario
  #        Enum.each(files, fn(file) ->
  #          File.rm!("./bd/#{file}")
  #        end)
  #        process()
  #    end
  #  end
