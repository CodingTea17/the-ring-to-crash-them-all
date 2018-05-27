defmodule Ring do

  def create_p(n) do
    1..n |> Enum.map(fn _ -> spawn(fn -> loop() end) end)
  end

  def loop do
    receive do
      {:link, link_to} when is_pid(link_to) ->
        Process.link(link_to)
        loop()

      :trap_exit ->
        Process.flag(:trap_exit, true)
        loop()

      :crash ->
        1/0

      {:EXIT, pid, reason} ->
        IO.puts("#{inspect self()} received (:EXIT, #{inspect pid}, #{reason})")
        loop()
    end
  end

  def link_p(ps) do
    link_p(ps, [])
  end

  def link_p([p1, p2|rest], linked_ps) do
    send(p1, {:link, p2})
    link_p([p2|rest], [p1|linked_ps])
  end

  def link_p([p|[]], linked_ps) do
    first_p = linked_ps |> List.last()
    send(p, {:link, first_p})
    :ok
  end

end
