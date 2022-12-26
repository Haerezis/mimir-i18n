import LocalesSelect from './LocalesSelect.vue';

export default {
  title: 'LocalesSelect',
  component: LocalesSelect,
};

const Template = (args, { argTypes }) => ({
  components: { LocalesSelect },
  props: Object.keys(argTypes),
  template: '<LocalesSelect v-model="$props.values"/>',
});

export const DefaultLocalesSelect = Template.bind({});
DefaultLocalesSelect.args = {
  values: ['en']
}
