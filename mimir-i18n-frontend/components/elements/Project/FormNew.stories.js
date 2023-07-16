import ProjectFormNew from './Project/FormNew.vue';

export default {
  title: 'ProjectFormNew',
  component: ProjectFormNew,
};

const Template = (args, { argTypes }) => ({
  components: { ProjectFormNew },
  props: Object.keys(argTypes),
  template: '<ProjectFormNew />',
});

export const DefaultProjectFormNew = Template.bind({});
DefaultProjectFormNew.args = {}
