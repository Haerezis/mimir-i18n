const { mergeConfig } = require('vite');
const path = require("path")

module.exports = {
  "stories": [
    "../app/frontend/components/**/*.stories.mdx",
    "../app/frontend/components/**/*.stories.@(js|jsx|ts|tsx)"
  ],
  "addons": [
    "@storybook/addon-links",
    "@storybook/addon-essentials",
    "@storybook/addon-interactions"
  ],
  "framework": "@storybook/vue3",
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
