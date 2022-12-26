import { createPinia, PiniaVuePlugin } from 'pinia'

const pinia = createPinia();

export const Plugin = PiniaVuePlugin;
export const PluginInstance = pinia;
