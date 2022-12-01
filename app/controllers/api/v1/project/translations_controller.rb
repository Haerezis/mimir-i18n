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
    @permission = current_user.permissions.find_by(project_id: @project.id)
  end

  def set_translations
    ##### LOCALES
    @locales = [params[:locale], params[:locales]].flatten.reject(&:blank?)

    if @locales.empty? || @locales.include?("*")
      @locales = I18nData.languages.keys.map(&:downcase)
    end
    @locales = @project.locales.where(code: @locales).map(&:code)


    ##### KEYS
    @keys = [params[:key], params[:keys]].flatten.reject(&:blank?)


    ##### TRANSLATIONS
    @translations = @project.translations
    if @locales.present?
      @translations = @translations.where(locale: @locales)
    end
    if @keys.present?
      @translations = @translations.where(key: @keys)
    end
  end

  def create_or_update_translation(locale, key, value)
    translation = @project.translations.where(
      locale: locale,
      key: key
    ).first_or_initialize

    translation.value = value
    translation.save!

    translation
  end
end
