class Api::V1::Project::TranslationsController < Api::V1::ApplicationController
  before_action :set_project
  before_action :set_translations, only: [:index, :destroy]

  def index
    render json: @translations.map(&:as_json2)
  end

  def create
  end

  def update
  end

  def destroy
    @translations.each(&:destroy)

    head :no_content
  end

  protected
  def set_project
    @project = current_user.projects.find(params.require(:project_id))
    @permission = current_user.user_project_permissions.find_by(project_id: @project.id)
  end

  def set_locales_and_keys
    ##### LOCALES
    @locales = [params[:locale], params[:locales]].flatten.reject(&:blank?)

    if @locales.empty? || @locales.include?("*")
      @locales = I18nData.languages.keys.map(&:downcase)
    end
    @locales = @project.locales.where(:code.in => @locales).distinct(:code)


    ##### KEYS
    @keys = [params[:key], params[:keys]].flatten.reject(&:blank?)


    ##### TRANSLATIONS
    @translations = @project.translations.where(
      :locale.in => @locales,
      :key.in => @keys,
    )
  end
end
