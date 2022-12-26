import LocalesSelect from './LocalesSelect.vue';

export default {
  title: 'LocalesSelect',
  component: LocalesSelect,
};

const Template = () => ({
  components: { LocalesSelect },
  setup() {
    return {
      values: ['en'],
    };
  },
  template: '<LocalesSelect v-model="values"/>',
});

export const DefaultLocalesSelect = Template.bind();
