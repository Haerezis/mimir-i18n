require "test_helper"

class Api::V1::Project::TranslationsControllerTest < ActionDispatch::IntegrationTest
  setup do 
    @project = create(:project)
    @user = @project.owner
    sign_in(@user)
  end

  test "index" do
    get api_v1_project_translations_path(@project)
    assert_response :success

    json = JSON.parse(response.body)
    assert_equal 2, json.count
    assert_equal @project.translations.map(&:id).sort, json.map {|i| i['id']}.sort


    get api_v1_project_translations_path(@project), params: {
      keys: ["foo.bar"]
    }
    assert_response :success
    assert_equal @project.translations.where(key: 'foo.bar').map(&:id).sort, JSON.parse(response.body).map {|i| i['id']}.sort
  end

  test "create" do
  end

  test "update" do
  end
end
