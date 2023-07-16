class Api::V1::Project::TranslationsController < Api::V1::Project::BaseController
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

  def destroy
    @translation.destroy

    head :no_content
  end

  # This action create/update/delete multiple translations in one API call
  def commit
    items = JSON.parse(request.raw_post)
    if !items.is_a?(Array)
      raise JSON::ParserError.new
    end

    failed = false
    retvals = []

    ApplicationRecord.transaction do
      items.each do |item|
        id = item["id"]
        action = item["action"]
        data = item["data"]

        begin
          res = nil
          case action
          when "create"
            res = commit_create(data)
          when "update"
            res = commit_update(data)
          when "delete"
            res = commit_delete(data)
          else
            raise "Cannot handle action '#{action}'"
          end

          item.merge!(
            status: "success",
            retval: res,
          )
        rescue => e
          failed = true
          item.merge!(
            status: "error",
            error_messages: [e.to_s],
          )
        end
      end

      if failed
        raise ActiveRecord::Rollback
      end
    end

    if failed
      render status: :bad_request, json: items
    else
      render json: items
    end
  end

  protected
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


  # Data:
  # {
  #   key: <Translation#key>,
  #   values: {
  #     locale: <TranslationValue#locale>
  #     value: <TranslationValue#value>
  #   }
  # }
  def commit_create(data)
    translation = @project.translations.new

    translation.key = data["key"]

    translation.save!

    (data["values"] || []).each do |value|
      translation_value = translation.values.new

      translation_value.locale = value["locale"]
      translation_value.value = value["value"]

      translation_value.save!
    end

    translation
  end

  # Data :
  # {
  #   id: <Translation#id>,
  #   key?: <Translation#key>,
  #   values: [
  #     {
  #       id: <TranslationValue#id>,
  #       value: <TranslationValue#value>
  #     }
  #   ]
  # }
  def commit_update(data)
    translation = @project.translations.find(data["id"])

    if data.key?("key")
      translation.key = data["key"]
    end
    translation.save!

    (data["values"] || []).each do |value|
      translation_value = translation.values.find(value["id"])
      if value.key?("value")
        translation_value.value = value["value"]
      end
      translation_value.save!
    end

    translation
  end

  # Data:
  #   <Translation#id>
  def commit_delete(data)
    translation = @project.translations.find(data)
    translation.destroy!
  end

end
