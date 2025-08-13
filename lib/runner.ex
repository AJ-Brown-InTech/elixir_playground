
defmodule ElixirPlayground.Runner do


  def run() do
    
  end

  defp create_tmp_file(code) do
    # Create a unique temp dir file
    tmp_path = "tmp/#{System.unique_integer([:positive])}.exs"
    case File.write(tmp_path, code) do
      :ok -> {:ok, tmp_path}
      :err -> {:err}
    end
  end

  defp run_in_docker(tmp_path) do
    docker_cmd = [
      "docker", "run", "--rm",
      "--memory=#{@memory_limit}",
      "--cpus=#{@cpu_limit}",
      "--network", "none",
      "-v", "#{tmp_path}:/app/snippet.exs:ro",
      @docker_image,
      "elixir", "/app/code.exs"
    ]

    case System.cmd(Enum.at(docker_cmd, 0), Enum.drop(docker_cmd, 1), stderr_to_stdout: true,timeout: @timeout) do
      {output, 0} -> {output, 0}
      {output, _} -> {output, 1}
    end
  end
end
