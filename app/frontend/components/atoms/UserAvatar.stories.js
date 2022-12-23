import UserAvatar from './UserAvatar.vue';

export default {
  title: 'UserAvatar',
  component: UserAvatar,
};

const Template = (args) => ({
  components: { UserAvatar },
  setup() {
    return { args };
  },
  template: '<UserAvatar v-bind="args"/>',
});

export const DefaultUserAvatar = Template.bind({});

DefaultUserAvatar.args = {
  user: {
    firstname: "Foo",
    lastname: "Bar"
  }
};
