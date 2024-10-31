defmodule Home.Sidebar do
  use LiveCommerceWeb, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def get_links do
    [
      %{
        name: "Apps",
        items: [
          %{
            label: "Chat",
            path: ~p"/chat",
            icon_class: "fad fa-comments text-xs mr-2",
            text_class: "text-sm"
          }
        ]
      }
    ]
  end
end
