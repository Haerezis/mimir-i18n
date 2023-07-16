import SelectLocales from './SelectLocales.vue';

export default {
  title: 'SelectLocales',
  component: SelectLocales,
};

const Template = (args, { argTypes }) => ({
  components: { SelectLocales },
  props: Object.keys(argTypes),
  template: '<SelectLocales v-model="$props.values"/>',
});

export const DefaultSelectLocales = Template.bind({});
DefaultSelectLocales.args = {
  values: ['en']
}
