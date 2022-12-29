require "test_helper"

class Api::V1::ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    sign_in(@user)

    @project = create(:project, owner: @user)
    @another_project = create(:project)
  end


  test "index" do
    get api_v1_projects_path
    assert_response :success

    json = JSON.parse(response.body)
    assert_equal 1, json.count
    assert_equal @project.id, json.first['id']
  end

  test "show" do
    get api_v1_project_path(@project)
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal @project.id, json['id']

    get api_v1_project_path(@another_project)
    assert_response :bad_request
  end

  test "create" do
    Project.expects(:factory_create).returns(@project)
    post api_v1_projects_path, params: {
      name: "Foobar",
      locales: ['en', 'fr']
    }
    assert_response :success
  end

  test "update" do
    patch api_v1_project_path(@project), params: { name: "foobar" }
    assert_response :success
    assert_equal "foobar", @project.reload.name

    assert_no_changes(->{@another_project.reload.name}) do
      patch api_v1_project_path(@another_project), params: { name: "foobar" }
      assert_response :bad_request
    end
  end

  test "destroy" do
    assert_difference(->{Project.count}, -1) do
      assert_difference(->{TranslationKey.count}, -@project.translations.count) do
        assert_difference(->{UserProjectPermission.count}, -@project.permissions.count) do
          delete api_v1_project_path(@project)
          assert_response :success
        end
      end
    end

    assert_no_difference(->{Project.count}) do
      assert_no_difference(->{TranslationKey.count}) do
        assert_no_difference(->{UserProjectPermission.count}) do
          delete api_v1_project_path(@another_project)
          assert_response :bad_request
        end
      end
    end
  end
end
