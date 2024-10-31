defmodule LiveCommerceWeb.Router do
  use LiveCommerceWeb, :router

  import LiveCommerceWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LiveCommerceWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveCommerceWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/branches", BranchLive.Index, :index
    live "/branches/new", BranchLive.Index, :new
    live "/branches/:id/edit", BranchLive.Index, :edit

    live "/branches/:id", BranchLive.Show, :show
    live "/branches/:id/show/edit", BranchLive.Show, :edit

    live "/categories", CategoryLive.Index, :index
    live "/categories/new", CategoryLive.Index, :new
    live "/categories/:id/edit", CategoryLive.Index, :edit

    live "/categories/:id", CategoryLive.Show, :show
    live "/categories/:id/show/edit", CategoryLive.Show, :edit

    live "/classifications", ClassificationLive.Index, :index
    live "/classifications/new", ClassificationLive.Index, :new
    live "/classifications/:id/edit", ClassificationLive.Index, :edit

    live "/classifications/:id", ClassificationLive.Show, :show
    live "/classifications/:id/show/edit", ClassificationLive.Show, :edit

    live "/sub_categories", SubCategoryLive.Index, :index
    live "/sub_categories/new", SubCategoryLive.Index, :new
    live "/sub_categories/:id/edit", SubCategoryLive.Index, :edit

    live "/sub_categories/:id", SubCategoryLive.Show, :show
    live "/sub_categories/:id/show/edit", SubCategoryLive.Show, :edit

    live "/products", ProductLive.Index, :index
    live "/products/new", ProductLive.Index, :new
    live "/products/:id/edit", ProductLive.Index, :edit

    live "/products/:id", ProductLive.Show, :show
    live "/products/:id/show/edit", ProductLive.Show, :edit

    live "/products_skus", ProductSKULive.Index, :index
    live "/products_skus/new", ProductSKULive.Index, :new
    live "/products_skus/:id/edit", ProductSKULive.Index, :edit

    live "/products_skus/:id", ProductSKULive.Show, :show
    live "/products_skus/:id/show/edit", ProductSKULive.Show, :edit

    live "/product_cover_images", ProductCoverImageLive.Index, :index
    live "/product_cover_images/new", ProductCoverImageLive.Index, :new
    live "/product_cover_images/:id/edit", ProductCoverImageLive.Index, :edit

    live "/product_cover_images/:id", ProductCoverImageLive.Show, :show
    live "/product_cover_images/:id/show/edit", ProductCoverImageLive.Show, :edit

    live "/product_perks", ProductPerkLive.Index, :index
    live "/product_perks/new", ProductPerkLive.Index, :new
    live "/product_perks/:id/edit", ProductPerkLive.Index, :edit

    live "/product_perks/:id", ProductPerkLive.Show, :show
    live "/product_perks/:id/show/edit", ProductPerkLive.Show, :edit

    live "/product_attributes", ProductAttributeLive.Index, :index
    live "/product_attributes/new", ProductAttributeLive.Index, :new
    live "/product_attributes/:id/edit", ProductAttributeLive.Index, :edit

    live "/product_attributes/:id", ProductAttributeLive.Show, :show
    live "/product_attributes/:id/show/edit", ProductAttributeLive.Show, :edit

    live "/item_models", ItemModelLive.Index, :index
    live "/item_models/new", ItemModelLive.Index, :new
    live "/item_models/:id/edit", ItemModelLive.Index, :edit

    live "/item_models/:id", ItemModelLive.Show, :show
    live "/item_models/:id/show/edit", ItemModelLive.Show, :edit

    live "/addresses", AddressLive.Index, :index
    live "/addresses/new", AddressLive.Index, :new
    live "/addresses/:id/edit", AddressLive.Index, :edit

    live "/addresses/:id", AddressLive.Show, :show
    live "/addresses/:id/show/edit", AddressLive.Show, :edit

    live "/carts", CartLive.Index, :index
    live "/carts/new", CartLive.Index, :new
    live "/carts/:id/edit", CartLive.Index, :edit

    live "/carts/:id", CartLive.Show, :show
    live "/carts/:id/show/edit", CartLive.Show, :edit

    live "/cart_items", CartItemLive.Index, :index
    live "/cart_items/new", CartItemLive.Index, :new
    live "/cart_items/:id/edit", CartItemLive.Index, :edit

    live "/cart_items/:id", CartItemLive.Show, :show
    live "/cart_items/:id/show/edit", CartItemLive.Show, :edit

    live "/wishlists", WishlistLive.Index, :index
    live "/wishlists/new", WishlistLive.Index, :new
    live "/wishlists/:id/edit", WishlistLive.Index, :edit

    live "/wishlists/:id", WishlistLive.Show, :show
    live "/wishlists/:id/show/edit", WishlistLive.Show, :edit

    live "/orders", OrderLive.Index, :index
    live "/orders/new", OrderLive.Index, :new
    live "/orders/:id/edit", OrderLive.Index, :edit

    live "/orders/:id", OrderLive.Show, :show
    live "/orders/:id/show/edit", OrderLive.Show, :edit

    live "/order_items", OrderItemLive.Index, :index
    live "/order_items/new", OrderItemLive.Index, :new
    live "/order_items/:id/edit", OrderItemLive.Index, :edit

    live "/order_items/:id", OrderItemLive.Show, :show
    live "/order_items/:id/show/edit", OrderItemLive.Show, :edit

    live "/payments", PaymentLive.Index, :index
    live "/payments/new", PaymentLive.Index, :new
    live "/payments/:id/edit", PaymentLive.Index, :edit

    live "/payments/:id", PaymentLive.Show, :show
    live "/payments/:id/show/edit", PaymentLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveCommerceWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:live_commerce, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LiveCommerceWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", LiveCommerceWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{LiveCommerceWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", LiveCommerceWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{LiveCommerceWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", LiveCommerceWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{LiveCommerceWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
