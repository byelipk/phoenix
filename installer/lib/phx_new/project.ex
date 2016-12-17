defmodule Phx.New.Project do
  alias Phx.New.Project

  defstruct base_path: nil,
            app: nil,
            app_mod: nil,
            app_path: nil,
            root_app: nil,
            root_mod: nil,
            project_path: nil,
            web_app: nil,
            web_namespace: nil,
            web_path: nil,
            opts: :unset,
            in_umbrella?: false,
            binding: []

  def new(project_path, opts) do
    project_path = Path.expand(project_path)
    app = opts[:app] || Path.basename(project_path)
    app_mod = Module.concat([opts[:module] || Macro.camelize(app)])

    %Project{base_path: project_path,
             app: app,
             app_mod: app_mod,
             root_app: app,
             root_mod: app_mod,
             opts: opts}
  end

  def ecto?(%Project{binding: binding}) do
    Keyword.fetch!(binding, :ecto)
  end

  def html?(%Project{binding: binding}) do
    Keyword.fetch!(binding, :html)
  end

  def brunch?(%Project{binding: binding}) do
    Keyword.fetch!(binding, :brunch)
  end

  def join_path(%Project{} = project, location, path)
      when location in [:project, :app, :web] do

    project |> Map.fetch!(:"#{location}_path") |> Path.join(path)
  end
end
