defmodule AppBundler.WxSubscriber do
  use GenServer

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg)
  end

  @impl true
  def init(_) do
    :wx.subscribe_events()
    {:ok, nil}
  end

  @impl true
  def handle_info({:new_file, []}, state) do
    AppBundler.__dispatch__(:open_app)
    {:noreply, state}
  end

  @impl true
  def handle_info({:reopen_app, []}, state) do
    AppBundler.__dispatch__(:reopen_app)
    {:noreply, state}
  end

  @impl true
  def handle_info({:open_url, url}, state) do
    AppBundler.__dispatch__({:open_url, List.to_string(url)})
    {:noreply, state}
  end

  @impl true
  def handle_info({:open_file, path}, state) do
    AppBundler.__dispatch__({:open_url, List.to_string(path)})
    {:noreply, state}
  end
end
