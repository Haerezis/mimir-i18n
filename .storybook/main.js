const { mergeConfig } = require('vite');
const path = require("path")

module.exports = {
  "stories": [
    {
      titlePrefix: "Elements",
      directory: "../app/frontend/components/elements/**",
      files: "*.stories.@(mdx|js|jsx|ts|tsx)"
    },
    {
      titlePrefix: "Prototypes",
      directory: "../app/frontend/components/prototypes/**",
      files: "*.stories.@(mdx|js|jsx|ts|tsx)"
    },
  ],
  "addons": [
    "@storybook/addon-links",
    "@storybook/addon-essentials",
    "@storybook/addon-interactions"
  ],
  "framework": "@storybook/vue",
  "core": {
    "builder": "@storybook/builder-vite"
  },
  "features": {
    "storyStoreV7": true
  },
  async viteFinal(config) {
    // Merge custom configuration into the default config
    return mergeConfig(config, {
      // Use the same "resolve" configuration as your app
      resolve: {
        alias: {
          "@": path.resolve(__dirname, "../app/frontend/"),
        },
      }
    });
  },
}
