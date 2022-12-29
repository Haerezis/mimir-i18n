import ProjectCardNew from './ProjectCardNew.vue';

export default {
  title: 'ProjectCardNew',
  component: ProjectCardNew,
};

const Template = (args) => ({
  components: { ProjectCardNew },
  setup() {
    return { args };
  },
  template: '<ProjectCardNew v-bind="args"/>',
});

export const DefaultProjectCardNew = Template.bind({});

DefaultProjectCardNew.args = {
  size: 128
}

