class Api::V1::Project::TranslationsController < Api::V1::ApplicationController
  before_action :set_project
  before_action :set_translation, only: [:update, :destroy]
  before_action :set_translations, only: [:index, :update_many, :destroy_many]

  def index
    render json: @translations
  end

  def create
    key = params.require(:key)
    default_value = params[:value].presence
    values = params[:values].presence || []

    @translations = @project.locales.map do |locale|
      @project.translations.find_or_create(
        locale: locale.code,
        key: key,
        value: values[locale.code] || default_value || ""
      )
    end

    render json: @translations
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
    if !items.is_a?(Array)
      raise JSON::ParserError.new
    end

    retvals = []
    items.each_with_index do |item, i|
      translation = nil
      id = item["id"]

      begin
        translation = @project.find(id)

        key = item["key"].presence || translation.key
        value = items["value"] || ""

        translation.assign_attributes(
          key: key,
          value: value,
        )
        translation.save!

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

    translations = @project.translations.where(key: old_key).to_a
    @project.transaction do
      translations.each do |translation|
        translation.key = new_key
        translation.save!
      end
    end

    render json: translations
  end

  protected
  def set_project
    @project = current_user.projects.find(params.require(:project_id))
    @permission = current_user.permissions.find_by(project_id: @project.id)
  end

  def set_translation
    @translation = @project.translations.find(params.require(:id))
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
