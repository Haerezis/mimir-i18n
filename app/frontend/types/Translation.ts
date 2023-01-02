import { ApiTranslationValue, TranslationValue } from "@/types/TranslationValue"

export interface ApiTranslation {
  id: number;
  project_id: number;
  key: string;
  values: { [key: string]: ApiTranslationValue; };
}

export class Translation {
  id?: number;
  project_id: number;
  key: string;
  key_original: string;
  values: { [key: string]: TranslationValue; } = {};

  public init_from_api(data: ApiTranslation) {
    this.id = data.id
    this.project_id = data.project_id
    this.key = data.key
    this.key_original = data.key
    Object.entries(data.values).forEach(([locale, value_data]) => {
      const value = new TranslationValue().init_from_api(value_data)
      this.values[locale] = value
    })
    
    return this
  }

  public init(project_id: number, key: string, locales: string[]) {
    this.project_id = project_id
    this.key = key
    this.key_original = key
    locales.forEach((locale) => {
      const value = new TranslationValue().init(locale)
      this.values[locale] = value
    })

    return this
  }

  public get is_new() {
    return !this.id
  }

  public get is_flagged_for_deletion() {
    return false
  }

  public get is_dirty() {
    return this.key != this.key_original
  }
}

export default Translation
