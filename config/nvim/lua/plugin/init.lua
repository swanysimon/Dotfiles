require("plugin.bootstrap")

require("packer").startup({
  require("plugin.plugins"),
  config = {
    display = {
      open_fn = require("packer.util").float
    }
  }
})

require("packer").install()
