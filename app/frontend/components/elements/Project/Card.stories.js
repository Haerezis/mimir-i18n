import ProjectCard from './Card.vue';

export default {
  title: 'ProjectCard',
  component: ProjectCard,
};

const Template = (args) => ({
  components: { ProjectCard },
  setup() {
    return { args };
  },
  template: '<ProjectCard :value="args.project"/>',
});

export const DefaultProjectCard = Template.bind({});

DefaultProjectCard.args = {
  project: {
    id: 42,
    owner_id: 42,
    owner_fullname: "John Doe",
    name: "Test Project",
    locales: ['en', 'fr'],
  }
}

