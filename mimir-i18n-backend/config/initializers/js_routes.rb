JsRoutes.setup do |c|
  # Setup your JS module system:
  # ESM, CJS, AMD, UMD or nil
  # c.module_type = "ESM"

  Rails.application.config.after_initialize do
    JsRoutes.generate!
    JsRoutes.definitions!
  end
end
