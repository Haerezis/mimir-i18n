class Api::V1::Project::TranslationsController < Api::V1::ApplicationController
  before_action :set_project
  before_action :set_translation, only: [:update, :destroy]
  before_action :set_translations, only: [:index, :destroy_many]

  def index
    render json: @translations
  end

  def create
    key = params.require(:key)
    default_value = params[:value].presence
    values = params[:values].presence || []

    translation_key = @project.translations.find_or_create(key: key)
    @project.locales.each do |locale|
      translation_value = translation_key.find_or_initialize(
        locale: locale.code,
      )
      translation_value.assign_attributes(
        value: values[locale.code] || default_value || ""
      )
      translation_value.save!
    end

    render json: translation_key
  end


  def update
    @translation.assign_attributes(
      key: params[:key].presence || @translation.key,
      value: params.require(:value)
    )
    
    @translation.save!

    render json: @translation
  end


  def update_many
    items = JSON.parse(raw_post)
    if !items.is_a?(Hash)
      raise JSON::ParserError.new
    end

    retvals = []
    items.each_with_index do |id, update_data|

      translation = nil

      begin
        translation = @project.translations.find(id)

        key = update_data["key"].presence
        if key
          translation.key = key
          translation.save!
        end

        values = update_data["values"] || {}
        values.each do |locale, value|
          translation_value = translation.find_by(locale: locale)
          translation_value.value = value
          translation_value.save!
        end

        retvals.push(translation)
      rescue => e
        retvals.push(e.to_str)
      end
    end

    render json: retvals
  rescue JSON::ParserError => e
    bad_request!("Request body should have been a JSON array")
  end



  def destroy
    @translation.destroy

    head :no_content
  end

  def destroy_many
    @translations.each(&:destroy)

    head :no_content
  end

  def update_key
    old_key = params[:old].presence
    new_key = params[:new].presence

    raise ActionController::ParameterMissing.new(:old) if old_key.nil?
    raise ActionController::ParameterMissing.new(:new) if new_key.nil?

    translation = @project.translations.find_by(key: old_key)
    translation.key = new_key
    translation.save!

    render json: translation
  end

  protected
  def set_project
    @project = Project.find(params.require(:project_id))
    if @project.owner != current_user
      bad_request!("Current user don't have permission for this project")
      return
    end
  end

  def set_translation
    @translation = @project.translations.find(params.require(:id))
  end

  def set_translations
    ##### KEYS
    @keys = [params[:key], params[:keys]].flatten.reject(&:blank?)


    ##### LOCALES
    @locales = [params[:locale], params[:locales]].flatten.reject(&:blank?)

    if @locales.empty? || @locales.include?("*")
      @locales = I18nData.languages.keys.map(&:downcase)
    end
    @locales = @project.locales.where(code: @locales).map(&:code)


    ##### TRANSLATIONS
    @translations = @project.translations
    if @keys.present?
      @translations = @translations.where(key: @keys)
    end
  end
end
